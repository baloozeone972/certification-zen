// certif-ios/CertifApp/Data/Payment/StoreKitService.swift
//
// StoreKit 2 in-app purchase service.
// Handles Pro subscription (monthly) and Pack (one-time purchase per certification).
// Equivalent of Google Play Billing library used in Android module.
// Justification: StoreKit 2 async/await natif iOS 15+ évite toute dépendance
// externe (RevenueCat) et conserve 100% de la marge commerciale.

import StoreKit
import Foundation

// MARK: - Product Identifiers

/// Product identifiers must match App Store Connect configuration exactly.
enum CertifProduct: String, CaseIterable {
    case proMonthly    = "com.certifapp.pro.monthly"
    case packJava21    = "com.certifapp.pack.java21"
    case packAws       = "com.certifapp.pack.aws"
    case packSpring    = "com.certifapp.pack.spring"
    case packKubernetes = "com.certifapp.pack.kubernetes"

    var displayName: String {
        switch self {
        case .proMonthly:    return "Pro Mensuel"
        case .packJava21:    return "Pack Java 21"
        case .packAws:       return "Pack AWS"
        case .packSpring:    return "Pack Spring Boot"
        case .packKubernetes: return "Pack Kubernetes"
        }
    }

    var isPack: Bool { rawValue.contains(".pack.") }
    var isSubscription: Bool { rawValue.contains(".pro.") }
}

// MARK: - Purchase State

enum PurchaseState: Equatable {
    case idle
    case loading
    case success(productId: String)
    case failed(message: String)
    case cancelled
}

// MARK: - StoreKitService

/// Manages all StoreKit 2 interactions: product loading, purchasing, entitlement verification.
@Observable
final class StoreKitService {

    // MARK: - State

    var products: [Product] = []
    var purchasedProductIds: Set<String> = []
    var purchaseState: PurchaseState = .idle
    var isProActive: Bool = false

    // MARK: - Private

    private var transactionListenerTask: Task<Void, Error>?
    private let paymentRepository: (any PaymentRepositoryProtocol)?

    // MARK: - Init

    init(paymentRepository: (any PaymentRepositoryProtocol)? = nil) {
        self.paymentRepository = paymentRepository
        transactionListenerTask = listenForTransactions()
        Task { await loadProducts() }
        Task { await updateEntitlements() }
    }

    deinit {
        transactionListenerTask?.cancel()
    }

    // MARK: - Load Products

    /// Fetches product metadata from App Store Connect.
    @MainActor
    func loadProducts() async {
        do {
            let identifiers = CertifProduct.allCases.map(\.rawValue)
            products = try await Product.products(for: identifiers)
                .sorted { $0.price < $1.price }
        } catch {
            print("[StoreKitService] Product load failed: \(error)")
        }
    }

    // MARK: - Purchase

    /// Initiates a purchase flow for the given product.
    @MainActor
    func purchase(_ product: Product) async {
        purchaseState = .loading
        do {
            let result = try await product.purchase()
            switch result {
            case .success(let verification):
                let transaction = try checkVerified(verification)
                await handleSuccessfulPurchase(transaction: transaction, product: product)
                await transaction.finish()
                purchaseState = .success(productId: product.id)

            case .userCancelled:
                purchaseState = .cancelled

            case .pending:
                purchaseState = .idle   // Awaiting parental approval or SCA

            @unknown default:
                purchaseState = .idle
            }
        } catch {
            purchaseState = .failed(message: error.localizedDescription)
        }
    }

    // MARK: - Restore Purchases

    /// Restores previously purchased products (required by App Store guidelines).
    @MainActor
    func restorePurchases() async {
        purchaseState = .loading
        do {
            try await AppStore.sync()
            await updateEntitlements()
            purchaseState = .idle
        } catch {
            purchaseState = .failed(message: "Restauration échouée : \(error.localizedDescription)")
        }
    }

    // MARK: - Entitlement Check

    /// Refreshes the set of active entitlements from the transaction ledger.
    @MainActor
    func updateEntitlements() async {
        var active: Set<String> = []
        for await result in Transaction.currentEntitlements {
            if case .verified(let transaction) = result,
               transaction.revocationDate == nil {
                active.insert(transaction.productID)
            }
        }
        purchasedProductIds = active
        isProActive = active.contains(CertifProduct.proMonthly.rawValue)
    }

    /// Returns true if the user owns the pack for a given certification ID.
    func ownsPack(certificationId: String) -> Bool {
        let packId = "com.certifapp.pack.\(certificationId.lowercased())"
        return purchasedProductIds.contains(packId)
    }

    /// Returns the Product for a given CertifProduct identifier, or nil.
    func product(for certifProduct: CertifProduct) -> Product? {
        products.first { $0.id == certifProduct.rawValue }
    }

    // MARK: - Private Helpers

    /// Listens for background transactions (renewals, refunds, etc.).
    private func listenForTransactions() -> Task<Void, Error> {
        Task.detached(priority: .background) { [weak self] in
            for await result in Transaction.updates {
                do {
                    let transaction = try self?.checkVerified(result)
                    await self?.updateEntitlements()
                    await transaction?.finish()
                } catch {
                    print("[StoreKitService] Unverified transaction: \(error)")
                }
            }
        }
    }

    /// Verifies StoreKit transaction signature — throws if not verified.
    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified(_, let error): throw error
        case .verified(let safe): return safe
        }
    }

    /// Notifies backend of successful purchase for server-side entitlement update.
    private func handleSuccessfulPurchase(transaction: Transaction, product: Product) async {
        guard let repo = paymentRepository else { return }
        // Send receipt to backend for server-side validation
        // Backend stores the entitlement in user's account
        if let receiptURL = Bundle.main.appStoreReceiptURL,
           let receiptData = try? Data(contentsOf: receiptURL) {
            let base64Receipt = receiptData.base64EncodedString()
            _ = try? await repo.validateAppleReceipt(
                AppleReceiptValidationRequestDTO(
                    receiptData: base64Receipt,
                    productId: product.id,
                    transactionId: transaction.id.description
                )
            )
        }
    }
}
