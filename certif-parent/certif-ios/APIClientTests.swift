// certif-parent/certif-ios/APIClientTests.swift
//
// Integration-style tests for APIClient using URLProtocol stubbing.
// No real network calls — all HTTP responses are mocked.
// KeychainService uses native Security framework (no SPM dependency).

import XCTest
@testable import CertifApp

// MARK: - MockURLProtocol

final class MockURLProtocol: URLProtocol {

    static var handler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        guard let handler = MockURLProtocol.handler else {
            client?.urlProtocol(self, didFailWithError: URLError(.unknown))
            return
        }
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {}
}

// MARK: - APIClientTests

final class APIClientTests: XCTestCase {

    private var client: APIClient!
    private var keychainService: KeychainService!

    override func setUp() {
        super.setUp()
        keychainService = KeychainService()
        keychainService.clearTokens()

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)

        client = APIClient(
            session: session,
            configuration: APIConfiguration(baseURL: URL(string: "https://api.test.com")!),
            keychainService: keychainService
        )
    }

    override func tearDown() {
        MockURLProtocol.handler = nil
        keychainService.clearTokens()
        super.tearDown()
    }

    // MARK: - Successful GET

    func test_get_200_decodesResponse() async throws {
        let expected = [CertificationDTO(
            id: "java21", code: "1Z0-830", name: "Java 21",
            description: "Test", totalQuestions: 300, passingScore: 68,
            examDurationMinutes: 90, examType: "MCQ", themes: nil
        )]

        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try encoder.encode(expected)

        MockURLProtocol.handler = { request in
            XCTAssertEqual(request.httpMethod, "GET")
            XCTAssertTrue(request.url?.path.contains("/api/v1/certifications") == true)
            let response = HTTPURLResponse(
                url: request.url!, statusCode: 200,
                httpVersion: nil, headerFields: nil
            )!
            return (response, data)
        }

        let result: [CertificationDTO] = try await client.request(.get("/api/v1/certifications"))
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.id, "java21")
        XCTAssertEqual(result.first?.code, "1Z0-830")
    }

    // MARK: - JWT injection

    func test_authenticatedRequest_includesBearerToken() async throws {
        keychainService.save(accessToken: "test-token-123", refreshToken: "refresh-456")

        let data = try JSONEncoder().encode([String]())
        MockURLProtocol.handler = { request in
            let auth = request.value(forHTTPHeaderField: "Authorization")
            XCTAssertEqual(auth, "Bearer test-token-123")
            let response = HTTPURLResponse(
                url: request.url!, statusCode: 200,
                httpVersion: nil, headerFields: nil
            )!
            return (response, data)
        }

        let _: [String] = try await client.request(.get("/api/v1/certifications"))
    }

    // MARK: - 401 Unauthorized

    func test_401_throwsUnauthorized() async {
        MockURLProtocol.handler = { request in
            let response = HTTPURLResponse(
                url: request.url!, statusCode: 401,
                httpVersion: nil, headerFields: nil
            )!
            return (response, Data())
        }

        do {
            let _: [CertificationDTO] = try await client.request(.get("/api/v1/certifications"))
            XCTFail("Expected APIError.unauthorized")
        } catch APIError.unauthorized {
            // Expected
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    // MARK: - 404 Not Found

    func test_404_throwsNotFound() async {
        MockURLProtocol.handler = { request in
            let response = HTTPURLResponse(
                url: request.url!, statusCode: 404,
                httpVersion: nil, headerFields: nil
            )!
            return (response, Data())
        }

        do {
            let _: CertificationDTO = try await client.request(.get("/api/v1/certifications/unknown"))
            XCTFail("Expected APIError.notFound")
        } catch APIError.notFound {
            // Expected
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    // MARK: - Network error

    func test_networkError_throwsNetworkError() async {
        MockURLProtocol.handler = { _ in
            throw URLError(.notConnectedToInternet)
        }

        do {
            let _: [CertificationDTO] = try await client.request(.get("/api/v1/certifications"))
            XCTFail("Expected APIError.networkError")
        } catch APIError.networkError {
            // Expected
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    // MARK: - POST with body

    func test_post_encodesBodyAndDecodesResponse() async throws {
        let loginRequest = LoginRequestDTO(email: "user@test.com", password: "password123")
        let expectedToken = TokenPairDTO(
            accessToken: "access-abc", refreshToken: "refresh-xyz", expiresIn: 3600
        )

        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let responseData = try encoder.encode(expectedToken)

        MockURLProtocol.handler = { request in
            XCTAssertEqual(request.httpMethod, "POST")
            XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/json")
            let response = HTTPURLResponse(
                url: request.url!, statusCode: 200,
                httpVersion: nil, headerFields: nil
            )!
            return (response, responseData)
        }

        let result: TokenPairDTO = try await client.request(
            .post("/api/v1/auth/login", body: loginRequest)
        )
        XCTAssertEqual(result.accessToken, "access-abc")
    }

    // MARK: - Decoding error

    func test_invalidJSON_throwsDecodingError() async {
        let invalidData = "not json at all".data(using: .utf8)!
        MockURLProtocol.handler = { request in
            let response = HTTPURLResponse(
                url: request.url!, statusCode: 200,
                httpVersion: nil, headerFields: nil
            )!
            return (response, invalidData)
        }

        do {
            let _: CertificationDTO = try await client.request(.get("/api/v1/certifications/1"))
            XCTFail("Expected decoding error")
        } catch APIError.decodingError {
            // Expected
        } catch {
            XCTFail("Unexpected: \(error)")
        }
    }
}
