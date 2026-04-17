// certif-parent/certif-ios/CertifApp/Data/Auth/AuthService.swift
//
// Authentication service — JWT storage in Keychain, biometric auth, @Observable.
// Mirrors Android AuthRepositoryImpl.kt pattern.
// Uses native Security framework — no third-party dependency.

import Foundation
import LocalAuthentication

// MARK: - AuthService

/// Manages authentication state: JWT tokens, user info, biometric prompt.
/// @Observable enables SwiftUI automatic view updates on state changes.
@Observable
final class AuthService {

    // MARK: - Published state (automatically observed by SwiftUI)

    var currentUser: UserDTO?
    var isLoading: Bool = false
    var errorMessage: String?

    // MARK: - Computed

    /// True if a valid access token is stored in Keychain.
    var isAuthenticated: Bool { keychainService.isAuthenticated }

    var isPro: Bool {
        guard let tier = currentUser?.subscriptionTier else { return false }
        return tier == "PRO" || tier == "PACK"
    }

    // MARK: - Dependencies

    private let keychainService: KeychainService
    private let apiClient: APIClient

    // MARK: - Init

    init(keychainService: KeychainService, apiClient: APIClient) {
        self.keychainService = keychainService
        self.apiClient = apiClient
        // Restore user from stored token on app launch
        Task { await restoreSession() }
    }

    // MARK: - Login

    /// Authenticates with email and password, stores tokens in Keychain.
    @MainActor
    func login(email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        do {
            let tokens: TokenPairDTO = try await apiClient.request(
                .post("/api/v1/auth/login", body: LoginRequestDTO(email: email, password: password))
            )
            keychainService.save(accessToken: tokens.accessToken, refreshToken: tokens.refreshToken)
            await fetchCurrentUser()
        } catch let error as APIError {
            errorMessage = error.errorDescription
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    // MARK: - Register

    /// Registers a new account and auto-logs in.
    @MainActor
    func register(email: String, password: String,
                  locale: String = "fr", timezone: String = "Europe/Paris") async {
        isLoading = true
        errorMessage = nil
        do {
            let tokens: TokenPairDTO = try await apiClient.request(
                .post("/api/v1/auth/register", body: RegisterRequestDTO(
                    email: email, password: password, locale: locale, timezone: timezone
                ))
            )
            keychainService.save(accessToken: tokens.accessToken, refreshToken: tokens.refreshToken)
            await fetchCurrentUser()
        } catch let error as APIError {
            errorMessage = error.errorDescription
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    // MARK: - Logout

    @MainActor
    func logout() {
        keychainService.clearTokens()
        currentUser = nil
        errorMessage = nil
    }

    // MARK: - Biometric authentication

    /// Presents Face ID / Touch ID prompt. Returns true on success.
    func authenticateWithBiometrics(reason: String = "Accéder à CertifApp") async -> Bool {
        let context = LAContext()
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return false
        }
        do {
            return try await context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: reason
            )
        } catch {
            return false
        }
    }

    // MARK: - Token refresh

    /// Called by APIClient on 401. Returns new access token or nil.
    func refreshAccessToken() async -> String? {
        guard let refresh = keychainService.refreshToken else { return nil }
        do {
            struct RefreshRequest: Encodable { let refreshToken: String }
            let tokens: TokenPairDTO = try await apiClient.request(
                .post("/api/v1/auth/refresh", body: RefreshRequest(refreshToken: refresh))
            )
            keychainService.save(accessToken: tokens.accessToken, refreshToken: tokens.refreshToken)
            return tokens.accessToken
        } catch {
            await MainActor.run { logout() }
            return nil
        }
    }

    // MARK: - Private helpers

    @MainActor
    private func fetchCurrentUser() async {
        do {
            currentUser = try await apiClient.request(.get("/api/v1/users/me"))
        } catch {
            // Non-fatal: user info may be loaded later
        }
    }

    private func restoreSession() async {
        guard keychainService.isAuthenticated else { return }
        await fetchCurrentUser()
    }
}
