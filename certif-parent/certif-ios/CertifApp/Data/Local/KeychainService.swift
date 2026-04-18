// certif-parent/certif-ios/CertifApp/Data/Local/KeychainService.swift
//
// JWT token storage using the native Security framework (SecItem API).
// No third-party dependencies — avoids KeychainAccess SPM for testability.
// Mirrors Android EncryptedSharedPreferences / DataStore token storage.

import Foundation
import Security

/// Manages JWT access and refresh token persistence in the iOS Keychain.
final class KeychainService {

    // MARK: - Service identifier

    private let service = "com.certifapp.CertifApp"

    // MARK: - Keys

    private enum Keys {
        static let accessToken  = "certifapp.accessToken"
        static let refreshToken = "certifapp.refreshToken"
        static let userId       = "certifapp.userId"
    }

    // MARK: - Read

    var accessToken: String? { read(key: Keys.accessToken) }
    var refreshToken: String? { read(key: Keys.refreshToken) }
    var userId: String? { read(key: Keys.userId) }

    var isAuthenticated: Bool { accessToken != nil }

    // MARK: - Write

    func save(accessToken: String, refreshToken: String) {
        write(value: accessToken,  key: Keys.accessToken)
        write(value: refreshToken, key: Keys.refreshToken)
    }

    func save(userId: UUID) {
        write(value: userId.uuidString, key: Keys.userId)
    }

    // MARK: - Delete

    func clearTokens() {
        delete(key: Keys.accessToken)
        delete(key: Keys.refreshToken)
        delete(key: Keys.userId)
    }

    // MARK: - Private Security API

    private func read(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String:            kSecClassGenericPassword,
            kSecAttrService as String:      service,
            kSecAttrAccount as String:      key,
            kSecMatchLimit as String:       kSecMatchLimitOne,
            kSecReturnData as String:       true
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status == errSecSuccess,
              let data = result as? Data,
              let string = String(data: data, encoding: .utf8) else { return nil }
        return string
    }

    private func write(value: String, key: String) {
        guard let data = value.data(using: .utf8) else { return }
        // Try updating existing item first
        let query: [String: Any] = [
            kSecClass as String:        kSecClassGenericPassword,
            kSecAttrService as String:  service,
            kSecAttrAccount as String:  key
        ]
        let attributes: [String: Any] = [kSecValueData as String: data]
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        if status == errSecItemNotFound {
            var addQuery = query
            addQuery[kSecValueData as String] = data
            addQuery[kSecAttrAccessible as String] = kSecAttrAccessibleAfterFirstUnlock
            SecItemAdd(addQuery as CFDictionary, nil)
        }
    }

    private func delete(key: String) {
        let query: [String: Any] = [
            kSecClass as String:        kSecClassGenericPassword,
            kSecAttrService as String:  service,
            kSecAttrAccount as String:  key
        ]
        SecItemDelete(query as CFDictionary)
    }
}
