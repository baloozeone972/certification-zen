// certif-ios/CertifApp/Data/Local/KeychainService.swift
//
// Secure JWT token storage using the system Keychain via KeychainAccess SPM package.
// This is the iOS equivalent of Android EncryptedSharedPreferences for tokens.

import Foundation
import KeychainAccess

/// Manages JWT access and refresh token persistence in the iOS Keychain.
final class KeychainService {

    // MARK: - Constants

    private enum Keys {
        static let accessToken  = "com.certifapp.accessToken"
        static let refreshToken = "com.certifapp.refreshToken"
        static let userId       = "com.certifapp.userId"
    }

    // MARK: - Properties

    private let keychain = Keychain(service: "com.certifapp.CertifApp")
        .accessibility(.afterFirstUnlock)

    // MARK: - Read

    /// Returns the stored JWT access token, or nil if not present.
    var accessToken: String? {
        try? keychain.get(Keys.accessToken)
    }

    /// Returns the stored JWT refresh token, or nil if not present.
    var refreshToken: String? {
        try? keychain.get(Keys.refreshToken)
    }

    /// Returns the stored user UUID string, or nil if not present.
    var userId: String? {
        try? keychain.get(Keys.userId)
    }

    /// True if a valid access token is stored.
    var isAuthenticated: Bool {
        accessToken != nil
    }

    // MARK: - Write

    /// Saves both tokens after successful login or refresh.
    func save(accessToken: String, refreshToken: String) {
        do {
            try keychain.set(accessToken, key: Keys.accessToken)
            try keychain.set(refreshToken, key: Keys.refreshToken)
        } catch {
            // Keychain write failures are non-fatal; log for crash reporting
            print("[KeychainService] Failed to save tokens: \(error)")
        }
    }

    /// Saves the authenticated user's UUID.
    func save(userId: UUID) {
        do {
            try keychain.set(userId.uuidString, key: Keys.userId)
        } catch {
            print("[KeychainService] Failed to save userId: \(error)")
        }
    }

    // MARK: - Delete

    /// Clears all stored authentication data (logout).
    func clearTokens() {
        try? keychain.remove(Keys.accessToken)
        try? keychain.remove(Keys.refreshToken)
        try? keychain.remove(Keys.userId)
    }
}
