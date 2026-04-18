// certif-ios/CertifAppTests/Data/APIClientTests.swift
//
// Integration-style tests for APIClient using URLProtocol stubbing.
// No real network calls — all HTTP responses are mocked.

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

    // MARK: - Successful requests

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
    }

    func test_post_200_sendsBodyAndDecodesResponse() async throws {
        let requestBody = LoginRequestDTO(email: "test@test.com", password: "pass123")
        let expectedTokens = TokenPairDTO(
            accessToken: "access_abc",
            refreshToken: "refresh_xyz",
            expiresIn: 3600
        )

        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let responseData = try encoder.encode(expectedTokens)

        MockURLProtocol.handler = { request in
            XCTAssertEqual(request.httpMethod, "POST")
            XCTAssertNotNil(request.httpBody)
            let response = HTTPURLResponse(
                url: request.url!, statusCode: 200,
                httpVersion: nil, headerFields: nil
            )!
            return (response, responseData)
        }

        let result: TokenPairDTO = try await client.request(.post("/api/v1/auth/login", body: requestBody))
        XCTAssertEqual(result.accessToken, "access_abc")
        XCTAssertEqual(result.refreshToken, "refresh_xyz")
    }

    // MARK: - JWT injection

    func test_get_withToken_injectsAuthorizationHeader() async throws {
        keychainService.save(accessToken: "my_token_123", refreshToken: "refresh")

        let data = try JSONEncoder().encode([String]())
        MockURLProtocol.handler = { request in
            let auth = request.value(forHTTPHeaderField: "Authorization")
            XCTAssertEqual(auth, "Bearer my_token_123")
            let response = HTTPURLResponse(
                url: request.url!, statusCode: 200,
                httpVersion: nil, headerFields: nil
            )!
            return (response, data)
        }

        let _: [String] = try await client.request(.get("/api/v1/test"))
    }

    // MARK: - Error mapping

    func test_401_throwsUnauthorized() async {
        MockURLProtocol.handler = { request in
            // 401 — block refresh attempt too
            let response = HTTPURLResponse(
                url: request.url!, statusCode: 401,
                httpVersion: nil, headerFields: nil
            )!
            return (response, Data())
        }

        do {
            let _: [String] = try await client.request(.get("/api/v1/test"))
            XCTFail("Expected APIError.unauthorized")
        } catch APIError.unauthorized {
            // Expected
        } catch {
            XCTFail("Wrong error: \(error)")
        }
    }

    func test_404_throwsNotFound() async {
        MockURLProtocol.handler = { _ in
            let response = HTTPURLResponse(
                url: URL(string: "https://api.test.com")!, statusCode: 404,
                httpVersion: nil, headerFields: nil
            )!
            return (response, Data())
        }

        do {
            let _: [String] = try await client.request(.get("/api/v1/missing"))
            XCTFail("Expected APIError.notFound")
        } catch APIError.notFound {
            // Expected
        } catch {
            XCTFail("Wrong error: \(error)")
        }
    }

    func test_403_freemiumLimit_throwsFreemiumError() async throws {
        struct ErrorBody: Encodable {
            let message: String
            let errorCode: String
        }
        let body = ErrorBody(message: "Limite gratuit atteinte", errorCode: "FREEMIUM_LIMIT_REACHED")
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try encoder.encode(body)

        MockURLProtocol.handler = { _ in
            let response = HTTPURLResponse(
                url: URL(string: "https://api.test.com")!, statusCode: 403,
                httpVersion: nil, headerFields: nil
            )!
            return (response, data)
        }

        do {
            let _: ExamSessionDTO = try await client.request(.post("/api/v1/exams/start", body: EmptyEncodable()))
            XCTFail("Expected freemium error")
        } catch APIError.freemiumLimitReached(let msg) {
            XCTAssertEqual(msg, "Limite gratuit atteinte")
        } catch {
            XCTFail("Wrong error: \(error)")
        }
    }

    func test_networkError_throwsNetworkError() async {
        MockURLProtocol.handler = { _ in
            throw URLError(.notConnectedToInternet)
        }

        do {
            let _: [String] = try await client.request(.get("/api/v1/test"))
            XCTFail("Expected network error")
        } catch APIError.networkError {
            // Expected
        } catch {
            XCTFail("Wrong error: \(error)")
        }
    }

    func test_invalidJSON_throwsDecodingError() async {
        MockURLProtocol.handler = { _ in
            let response = HTTPURLResponse(
                url: URL(string: "https://api.test.com")!, statusCode: 200,
                httpVersion: nil, headerFields: nil
            )!
            return (response, Data("not json".utf8))
        }

        do {
            let _: [CertificationDTO] = try await client.request(.get("/api/v1/certifications"))
            XCTFail("Expected decoding error")
        } catch APIError.decodingError {
            // Expected
        } catch {
            XCTFail("Wrong error: \(error)")
        }
    }
}

// MARK: - Helper

private struct EmptyEncodable: Encodable {}
