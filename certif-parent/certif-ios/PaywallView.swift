// certif-ios/CertifApp/Presentation/Payment/PaywallView.swift
//
// Paywall screen — displays Pro subscription and Pack offers.
// Presented as a sheet from ProfileView or when freemium limit is reached.
// Equivalent of the Stripe Checkout flow used on the web.

import SwiftUI
import StoreKit

struct PaywallView: View {

    @ObservedObject private var storeKitWrapper: StoreKitWrapper
    @Environment(\.dismiss) private var dismiss
    @State private var selectedTab: PaywallTab = .pro

    enum PaywallTab: String, CaseIterable {
        case pro  = "Pro"
        case pack = "Pack"
    }

    init(storeKitService: StoreKitService) {
        _storeKitWrapper = ObservedObject(wrappedValue: StoreKitWrapper(service: storeKitService))
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header
                PaywallHeader()

                // Tab selector
                Picker("Offre", selection: $selectedTab) {
                    ForEach(PaywallTab.allCases, id: \.self) {
                        Text($0.rawValue).tag($0)
                    }
                }
                .pickerStyle(.segmented)
                .padding()

                ScrollView {
                    VStack(spacing: 16) {
                        if selectedTab == .pro {
                            ProOfferSection(
                                service: storeKitWrapper.service,
                                onPurchase: { product in
                                    Task { await storeKitWrapper.service.purchase(product) }
                                }
                            )
                        } else {
                            PackOfferSection(
                                service: storeKitWrapper.service,
                                onPurchase: { product in
                                    Task { await storeKitWrapper.service.purchase(product) }
                                }
                            )
                        }

                        // Purchase state feedback
                        PurchaseStateBanner(state: storeKitWrapper.service.purchaseState) {
                            dismiss()
                        }

                        // Restore button
                        Button("Restaurer les achats") {
                            Task { await storeKitWrapper.service.restorePurchases() }
                        }
                        .font(.footnote).foregroundStyle(.secondary)

                        // Legal
                        Text("Paiement via App Store. Renouvellement automatique annulable à tout moment dans vos réglages Apple.")
                            .font(.caption2).foregroundStyle(Color(.tertiaryLabel))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding()
                }
            }
            .navigationTitle("Passer à Pro")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .onChange(of: storeKitWrapper.service.purchaseState) { _, newState in
                if case .success = newState {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { dismiss() }
                }
            }
        }
    }
}

// MARK: - PaywallHeader

private struct PaywallHeader: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "crown.fill")
                .font(.system(size: 44))
                .foregroundStyle(.orange)
            Text("Débloquez tout votre potentiel")
                .font(.title2.bold())
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 24)
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors: [Color.orange.opacity(0.12), Color.accentColor.opacity(0.08)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
}

// MARK: - ProOfferSection

private struct ProOfferSection: View {
    let service: StoreKitService
    let onPurchase: (Product) -> Void

    private let features = [
        ("infinity",            "Examens illimités"),
        ("clock.arrow.circlepath", "Historique complet"),
        ("wifi.slash",          "Mode offline total"),
        ("brain.head.profile",  "Coach IA personnalisé"),
        ("person.fill.questionmark", "Simulation d'entretien"),
        ("chart.line.uptrend.xyaxis", "Plan adaptatif SM-2"),
    ]

    var body: some View {
        VStack(spacing: 20) {
            // Features list
            VStack(alignment: .leading, spacing: 12) {
                ForEach(features, id: \.0) { icon, label in
                    Label(label, systemImage: icon)
                        .font(.body)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16))

            // Pro product button
            if let product = service.product(for: .proMonthly) {
                ProductPurchaseButton(
                    title: "Pro Mensuel",
                    price: product.displayPrice,
                    subtitle: "Par mois, annulable à tout moment",
                    color: .orange,
                    isLoading: service.purchaseState == .loading,
                    alreadyOwned: service.isProActive
                ) {
                    onPurchase(product)
                }
            } else {
                ProgressView()
            }
        }
    }
}

// MARK: - PackOfferSection

private struct PackOfferSection: View {
    let service: StoreKitService
    let onPurchase: (Product) -> Void

    private let packProducts: [(CertifProduct, String)] = [
        (.packJava21,     "Java 21 Developer"),
        (.packAws,        "AWS Solutions Architect"),
        (.packSpring,     "Spring Boot 3"),
        (.packKubernetes, "Kubernetes (CKA/CKAD)"),
    ]

    var body: some View {
        VStack(spacing: 12) {
            Text("Accès permanent à une certification")
                .font(.subheadline).foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)

            ForEach(packProducts, id: \.0) { certifProduct, name in
                if let product = service.product(for: certifProduct) {
                    ProductPurchaseButton(
                        title: name,
                        price: product.displayPrice,
                        subtitle: "Achat unique — accès permanent",
                        color: .purple,
                        isLoading: service.purchaseState == .loading,
                        alreadyOwned: service.purchasedProductIds.contains(certifProduct.rawValue)
                    ) {
                        onPurchase(product)
                    }
                }
            }
        }
    }
}

// MARK: - ProductPurchaseButton

private struct ProductPurchaseButton: View {
    let title: String
    let price: String
    let subtitle: String
    let color: Color
    let isLoading: Bool
    let alreadyOwned: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title).font(.headline).foregroundStyle(.white)
                    Text(subtitle).font(.caption).foregroundStyle(.white.opacity(0.8))
                }
                Spacer()
                if alreadyOwned {
                    Image(systemName: "checkmark.seal.fill").foregroundStyle(.white)
                } else if isLoading {
                    ProgressView().tint(.white)
                } else {
                    Text(price).font(.headline.bold()).foregroundStyle(.white)
                }
            }
            .padding()
            .background(alreadyOwned ? Color.gray : color)
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .buttonStyle(.plain)
        .disabled(isLoading || alreadyOwned)
    }
}

// MARK: - PurchaseStateBanner

private struct PurchaseStateBanner: View {
    let state: PurchaseState
    let onDismiss: () -> Void

    var body: some View {
        switch state {
        case .success:
            Label("Achat réussi ! Bienvenue dans CertifApp Pro 🎉", systemImage: "checkmark.circle.fill")
                .font(.body.bold()).foregroundStyle(.green)
                .padding()
                .background(Color.green.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        case .failed(let message):
            Label(message, systemImage: "exclamationmark.circle.fill")
                .font(.caption).foregroundStyle(.red)
                .padding()
                .background(Color.red.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        case .cancelled:
            EmptyView()
        default:
            EmptyView()
        }
    }
}

// MARK: - ObservableObject wrapper (bridging @Observable → sheet)

/// Bridge between @Observable StoreKitService and ObservableObject for sheet compatibility.
final class StoreKitWrapper: ObservableObject {
    let service: StoreKitService
    init(service: StoreKitService) { self.service = service }
}
