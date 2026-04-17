// certif-ios/CertifApp/Data/Remote/APIClient.swift
//
// Centralized HTTP client using URLSession + async/await.
// Handles JWT injection, automatic token refresh, and error mapping.
// Justification: URLSession natif iOS 17 évite toute dépendance Alamofire,
// async/await offre une lisibilité équivalente à Retrofit Kotlin.

import Foundation

// MARK: - API Errors

/// Typed API errors matching HTTP semantics and backend error codes.
enum APIError: LocalizedError {
    case invalidURL
    case unauthorized
    case forbidden
    case notFound
    case freemiumLimitReached(message: String)
    case serverError(statusCode: Int, message: String)
    case decodingError(underlying: Error)
    case networkError(underlying: Error)
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL:                         return "URL invalide."
        case .unauthorized:                       return "Session expirée. Veuillez vous reconnecter."
        case .forbidden:                          return "Accès refusé."
        case .notFound:                           return "Ressource introuvable."
        case .freemiumLimitReached(let msg):      return msg
        case .serverError(let code, let msg):     return "Erreur serveur \(code) : \(msg)"
        case .decodingError(let err):             return "Erreur de décodage : \(err.localizedDescription)"
        case .networkError(let err):              return "Erreur réseau : \(err.localizedDescription)"
        case .unknown:                            return "Erreur inconnue."
        }
    }
}

// MARK: - HTTP Method

enum HTTPMethod: String {
    case GET, POST, PUT, PATCH, DELETE
}

// MARK: - API Endpoint

/// Type-safe endpoint definition — mirrors Java controller mappings.
struct Endpoint {
    let path: String
    let method: HTTPMethod
    var queryItems: [URLQueryItem]?
    var body: (any Encodable)?

    static func get(_ path: String, query: [URLQueryItem]? = nil) -> Endpoint {
        Endpoint(path: path, method: .GET, queryItems: query)
    }

    static func post(_ path: String, body: some Encodable) -> Endpoint {
        Endpoint(path: path, method: .POST, body: body)
    }

    static func put(_ path: String, body: some Encodable) -> Endpoint {
        Endpoint(path: path, method: .PUT, body: body)
    }

    static func delete(_ path: String) -> Endpoint {
        Endpoint(path: path, method: .DELETE)
    }
}

// MARK: - API Configuration

struct APIConfiguration {
    let baseURL: URL
    static let current = APIConfiguration(
        baseURL: URL(string: Bundle.main.infoDictionary?["API_BASE_URL"] as? String
                     ?? "https://api.certifapp.com")!
    )
}

// MARK: - APIClient

/// Main HTTP client. All requests go through this actor for thread safety.
actor APIClient {

    // MARK: - Dependencies

    private let session: URLSession
    private let configuration: APIConfiguration
    private let keychainService: KeychainService
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder

    // MARK: - Init

    init(
        session: URLSession = .shared,
        configuration: APIConfiguration = .current,
        keychainService: KeychainService
    ) {
        self.session = session
        self.configuration = configuration
        self.keychainService = keychainService

        self.decoder = JSONDecoder()
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.decoder.dateDecodingStrategy = .iso8601

        self.encoder = JSONEncoder()
        self.encoder.keyEncodingStrategy = .convertToSnakeCase
        self.encoder.dateEncodingStrategy = .iso8601
    }

    // MARK: - Public Interface

    /// Executes a typed request, returning a decoded response body.
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let urlRequest = try buildRequest(endpoint)
        return try await execute(urlRequest, retryOnUnauthorized: true)
    }

    /// Executes a request with no expected response body (204 No Content).
    func requestVoid(_ endpoint: Endpoint) async throws {
        let urlRequest = try buildRequest(endpoint)
        let (_, response) = try await session.data(for: urlRequest)
        try validateResponse(response, data: Data())
    }

    // MARK: - Private Helpers

    private func buildRequest(_ endpoint: Endpoint) throws -> URLRequest {
        var components = URLComponents(
            url: configuration.baseURL.appendingPathComponent(endpoint.path),
            resolvingAgainstBaseURL: false
        )
        components?.queryItems = endpoint.queryItems

        guard let url = components?.url else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.timeoutInterval = 30

        // Inject JWT if available
        if let token = keychainService.accessToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        // Encode body
        if let body = endpoint.body {
            request.httpBody = try encoder.encode(AnyEncodable(body))
        }

        return request
    }

    private func execute<T: Decodable>(
        _ request: URLRequest,
        retryOnUnauthorized: Bool
    ) async throws -> T {
        do {
            let (data, response) = try await session.data(for: request)
            try validateResponse(response, data: data)
            return try decodeResponse(data)
        } catch APIError.unauthorized where retryOnUnauthorized {
            // Attempt JWT refresh then retry once
            try await refreshTokens()
            var retryRequest = request
            if let token = keychainService.accessToken {
                retryRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            let (data, response) = try await session.data(for: retryRequest)
            try validateResponse(response, data: data)
            return try decodeResponse(data)
        } catch let urlError as URLError {
            throw APIError.networkError(underlying: urlError)
        }
    }

    private func validateResponse(_ response: URLResponse, data: Data) throws {
        guard let http = response as? HTTPURLResponse else { throw APIError.unknown }
        switch http.statusCode {
        case 200...299: return
        case 401: throw APIError.unauthorized
        case 403:
            // Freemium limit returns 403 with specific code
            if let errorBody = try? decoder.decode(ErrorBody.self, from: data),
               errorBody.errorCode == "FREEMIUM_LIMIT_REACHED" {
                throw APIError.freemiumLimitReached(message: errorBody.message)
            }
            throw APIError.forbidden
        case 404: throw APIError.notFound
        default:
            let message = (try? decoder.decode(ErrorBody.self, from: data))?.message ?? "Erreur serveur"
            throw APIError.serverError(statusCode: http.statusCode, message: message)
        }
    }

    private func decodeResponse<T: Decodable>(_ data: Data) throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decodingError(underlying: error)
        }
    }

    private func refreshTokens() async throws {
        guard let refreshToken = keychainService.refreshToken else {
            throw APIError.unauthorized
        }
        struct RefreshRequest: Encodable { let refreshToken: String }
        let body = try encoder.encode(RefreshRequest(refreshToken: refreshToken))
        var request = URLRequest(
            url: configuration.baseURL.appendingPathComponent("/api/v1/auth/refresh")
        )
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body

        let (data, response) = try await session.data(for: request)
        guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
            keychainService.clearTokens()
            throw APIError.unauthorized
        }
        let tokens = try decoder.decode(TokenPairDTO.self, from: data)
        keychainService.save(accessToken: tokens.accessToken, refreshToken: tokens.refreshToken)
    }
}

// MARK: - Supporting Types

private struct ErrorBody: Decodable {
    let message: String
    let errorCode: String?
}

/// Type-erased Encodable wrapper for heterogeneous body types.
private struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void

    init(_ value: any Encodable) {
        self._encode = { encoder in try value.encode(to: encoder) }
    }

    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}
