// certif-ios/CertifApp/Presentation/Home/HomeView.swift
//
// Certification catalog — equivalent of HomeScreen.kt (Android).
// Displays all available certifications with search and freemium badge.

import SwiftUI

// MARK: - ViewModel

/// Manages certification list state.
@Observable
final class HomeViewModel {

    // MARK: - State

    var certifications: [CertificationDTO] = []
    var isLoading: Bool = false
    var errorMessage: String?
    var searchQuery: String = ""

    // MARK: - Computed

    var filteredCertifications: [CertificationDTO] {
        guard !searchQuery.isEmpty else { return certifications }
        return certifications.filter {
            $0.name.localizedCaseInsensitiveContains(searchQuery) ||
            $0.code.localizedCaseInsensitiveContains(searchQuery)
        }
    }

    // MARK: - Dependencies

    private let certificationRepository: any CertificationRepositoryProtocol
    let authService: AuthService

    init(certificationRepository: any CertificationRepositoryProtocol,
         authService: AuthService) {
        self.certificationRepository = certificationRepository
        self.authService = authService
    }

    // MARK: - Actions

    @MainActor
    func loadCertifications() async {
        isLoading = true
        errorMessage = nil
        do {
            certifications = try await certificationRepository.fetchAll()
        } catch {
            errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
        }
        isLoading = false
    }
}

// MARK: - View

struct HomeView: View {

    @State var viewModel: HomeViewModel
    private let container = DIContainer.shared

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header greeting
                if let user = viewModel.authService.currentUser {
                    Text("Bonjour 👋")
                        .font(.largeTitle.bold())
                    Text(user.subscriptionTier.displayName)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(user.subscriptionTier.isProOrPack ? Color.accentColor : Color.secondary.opacity(0.2))
                        .foregroundStyle(user.subscriptionTier.isProOrPack ? .white : .primary)
                        .clipShape(Capsule())
                }

                // Error banner
                if let error = viewModel.errorMessage {
                    ErrorBannerView(message: error)
                }

                // Certification grid
                if viewModel.isLoading {
                    CertificationGridSkeleton()
                } else {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 16)], spacing: 16) {
                        ForEach(viewModel.filteredCertifications) { cert in
                            NavigationLink(destination:
                                ExamConfigView(viewModel: container.makeExamConfigViewModel(certificationId: cert.id))
                            ) {
                                CertificationCard(certification: cert)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Certifications")
        .searchable(text: $viewModel.searchQuery, prompt: "Rechercher...")
        .task { await viewModel.loadCertifications() }
        .refreshable { await viewModel.loadCertifications() }
    }
}

// MARK: - CertificationCard

private struct CertificationCard: View {
    let certification: CertificationDTO

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Code badge
            Text(certification.code)
                .font(.caption.bold())
                .foregroundStyle(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.accentColor)
                .clipShape(Capsule())

            Text(certification.name)
                .font(.subheadline.bold())
                .lineLimit(3)
                .fixedSize(horizontal: false, vertical: true)

            Spacer()

            HStack {
                Label("\(certification.totalQuestions) Q", systemImage: "questionmark.circle.fill")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
                Label("\(certification.passingScore)%", systemImage: "checkmark.seal.fill")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .frame(height: 160)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.06), radius: 6, y: 3)
    }
}

// MARK: - Skeleton

private struct CertificationGridSkeleton: View {
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 16)], spacing: 16) {
            ForEach(0..<6, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.15))
                    .frame(height: 160)
                    .shimmering()
            }
        }
    }
}
