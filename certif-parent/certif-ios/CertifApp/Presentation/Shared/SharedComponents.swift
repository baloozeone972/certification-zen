// certif-ios/CertifApp/Presentation/Shared/SharedComponents.swift
//
// Reusable UI components shared across all screens.
// Equivalent of the shared Composables in Android's presentation layer.

import SwiftUI

// MARK: - ErrorBannerView

/// Displays an inline error message with warning icon.
struct ErrorBannerView: View {
    let message: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundStyle(.red)
            Text(message)
                .font(.caption)
                .foregroundStyle(.red)
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
        }
        .padding(12)
        .background(Color.red.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Shimmering Modifier

/// Animated shimmer effect for loading skeletons.
struct ShimmeringModifier: ViewModifier {
    @State private var phase: CGFloat = -1.0

    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geo in
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: .clear, location: 0),
                            .init(color: .white.opacity(0.5), location: 0.4),
                            .init(color: .white.opacity(0.5), location: 0.6),
                            .init(color: .clear, location: 1)
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: geo.size.width * 2)
                    .offset(x: geo.size.width * phase)
                    .animation(
                        .linear(duration: 1.2).repeatForever(autoreverses: false),
                        value: phase
                    )
                }
                .clipped()
            )
            .onAppear { phase = 1.5 }
    }
}

extension View {
    /// Applies a shimmer loading animation.
    func shimmering() -> some View {
        modifier(ShimmeringModifier())
    }
}

// MARK: - LoadingOverlay

/// Full-screen semi-transparent loading overlay.
struct LoadingOverlay: View {
    let message: String

    var body: some View {
        ZStack {
            Color.black.opacity(0.3).ignoresSafeArea()
            VStack(spacing: 16) {
                ProgressView()
                    .scaleEffect(1.3)
                    .tint(.white)
                Text(message)
                    .font(.subheadline)
                    .foregroundStyle(.white)
            }
            .padding(28)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

// MARK: - EmptyStateView

/// Generic empty state with icon, title and optional action.
struct EmptyStateView: View {
    let icon: String
    let title: String
    let subtitle: String
    var actionLabel: String? = nil
    var action: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: icon)
                .font(.system(size: 52))
                .foregroundStyle(Color(.systemGray3))
            Text(title).font(.headline)
            Text(subtitle)
                .font(.subheadline).foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            if let label = actionLabel, let action {
                Button(label, action: action)
                    .buttonStyle(.borderedProminent)
            }
        }
        .padding(40)
    }
}

// MARK: - ProBadge

/// Small "PRO" badge for gated features.
struct ProBadge: View {
    var body: some View {
        Text("PRO")
            .font(.system(size: 9, weight: .black))
            .foregroundStyle(.white)
            .padding(.horizontal, 5)
            .padding(.vertical, 2)
            .background(Color.orange)
            .clipShape(Capsule())
    }
}

// MARK: - DifficultyBadge

/// Colored difficulty label for questions.
struct DifficultyBadge: View {
    let difficulty: String

    private var color: Color {
        switch difficulty.uppercased() {
        case "EASY":   return .green
        case "MEDIUM": return .orange
        case "HARD":   return .red
        default:       return .secondary
        }
    }

    private var label: String {
        switch difficulty.uppercased() {
        case "EASY":   return "Facile"
        case "MEDIUM": return "Moyen"
        case "HARD":   return "Difficile"
        default:       return difficulty
        }
    }

    var body: some View {
        Text(label)
            .font(.system(size: 10, weight: .bold))
            .foregroundStyle(color)
            .padding(.horizontal, 7)
            .padding(.vertical, 3)
            .background(color.opacity(0.12))
            .clipShape(Capsule())
    }
}

// MARK: - ContentView (App Shell)

/// Simple root content view shown after authentication (placeholder).
struct ContentView: View {
    var body: some View {
        AppTabView()
    }
}
