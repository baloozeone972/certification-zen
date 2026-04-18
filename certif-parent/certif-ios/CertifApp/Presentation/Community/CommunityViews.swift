// certif-ios/CertifApp/Presentation/Community/CommunityViews.swift
//
// Community module: Weekly Challenge + Certified Wall
// Equivalent of ChallengeScreen.kt + CertifiedWallScreen.kt

import SwiftUI

// MARK: - CommunityHubView

struct CommunityHubView: View {
    private let container = DIContainer.shared

    var body: some View {
        List {
            NavigationLink {
                ChallengeView(viewModel: container.makeChallengeViewModel(certificationId: "java21"))
            } label: {
                Label("Challenge de la semaine", systemImage: "trophy.fill")
            }
            NavigationLink {
                CertifiedWallView(viewModel: container.makeCertifiedWallViewModel())
            } label: {
                Label("Mur des certifiés", systemImage: "star.fill")
            }
        }
        .navigationTitle("Communauté")
    }
}

// MARK: - ChallengeViewModel

@Observable
final class ChallengeViewModel {

    var challenge: WeeklyChallengeDTO?
    var isLoading: Bool = false
    var errorMessage: String?

    private let certificationId: String
    private let communityRepository: any CommunityRepositoryProtocol

    init(certificationId: String, communityRepository: any CommunityRepositoryProtocol) {
        self.certificationId = certificationId
        self.communityRepository = communityRepository
    }

    @MainActor
    func loadChallenge() async {
        isLoading = true
        do {
            challenge = try await communityRepository.fetchCurrentChallenge(certificationId: certificationId)
        } catch {
            errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
        }
        isLoading = false
    }
}

// MARK: - ChallengeView

struct ChallengeView: View {

    @State var viewModel: ChallengeViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if viewModel.isLoading {
                    ProgressView().frame(maxWidth: .infinity).padding(.top, 60)
                } else if let challenge = viewModel.challenge {
                    // Header
                    VStack(alignment: .leading, spacing: 6) {
                        Text(challenge.title).font(.title2.bold())
                        Text(challenge.description).foregroundStyle(.secondary)
                        HStack {
                            Label("\(challenge.participantCount) participants", systemImage: "person.fill")
                            Spacer()
                            if let rank = challenge.userRank {
                                Label("Rang #\(rank)", systemImage: "rosette").foregroundStyle(.orange)
                            }
                        }
                        .font(.caption)
                    }
                    .padding()
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    // Leaderboard
                    if let leaderboard = challenge.leaderboard, !leaderboard.isEmpty {
                        Text("Classement").font(.headline)
                        ForEach(leaderboard.prefix(10)) { entry in
                            LeaderboardRow(entry: entry)
                        }
                    }
                } else if let error = viewModel.errorMessage {
                    ErrorBannerView(message: error)
                }
            }
            .padding()
        }
        .navigationTitle("Challenge")
        .task { await viewModel.loadChallenge() }
        .refreshable { await viewModel.loadChallenge() }
    }
}

private struct LeaderboardRow: View {
    let entry: LeaderboardEntryDTO
    var body: some View {
        HStack {
            Text("#\(entry.rank)")
                .font(.headline.monospacedDigit())
                .foregroundStyle(entry.rank <= 3 ? .orange : .secondary)
                .frame(width: 36)
            Text(entry.username).font(.body)
            if let country = entry.country {
                Text(countryFlag(country)).font(.title3)
            }
            Spacer()
            Text(String(format: "%.0f%%", entry.score))
                .font(.subheadline.bold())
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(entry.rank <= 3 ? Color.orange.opacity(0.05) : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    private func countryFlag(_ code: String) -> String {
        code.uppercased().unicodeScalars.reduce("") { result, scalar in
            guard let base = Unicode.Scalar(127397 + scalar.value) else { return result }
            return result + String(base)
        }
    }
}

// MARK: - CertifiedWallViewModel

@Observable
final class CertifiedWallViewModel {

    var profiles: [CertifiedWallProfileDTO] = []
    var isLoading: Bool = false
    var errorMessage: String?
    var currentPage: Int = 0
    var hasMorePages: Bool = true

    private let communityRepository: any CommunityRepositoryProtocol

    init(communityRepository: any CommunityRepositoryProtocol) {
        self.communityRepository = communityRepository
    }

    @MainActor
    func loadProfiles() async {
        isLoading = true
        currentPage = 0
        do {
            let response = try await communityRepository.fetchCertifiedWall(page: 0, size: 20)
            profiles = response.content
            hasMorePages = response.number < response.totalPages - 1
        } catch {
            errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
        }
        isLoading = false
    }

    @MainActor
    func loadMore() async {
        guard hasMorePages && !isLoading else { return }
        currentPage += 1
        do {
            let response = try await communityRepository.fetchCertifiedWall(page: currentPage, size: 20)
            profiles.append(contentsOf: response.content)
            hasMorePages = response.number < response.totalPages - 1
        } catch { }
    }
}

// MARK: - CertifiedWallView

struct CertifiedWallView: View {

    @State var viewModel: CertifiedWallViewModel

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                if viewModel.isLoading && viewModel.profiles.isEmpty {
                    ProgressView().padding(.top, 60)
                } else {
                    ForEach(viewModel.profiles) { profile in
                        CertifiedProfileCard(profile: profile)
                            .onAppear {
                                if profile.id == viewModel.profiles.last?.id {
                                    Task { await viewModel.loadMore() }
                                }
                            }
                    }
                    if viewModel.isLoading {
                        ProgressView()
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Mur des certifiés")
        .task { await viewModel.loadProfiles() }
        .refreshable { await viewModel.loadProfiles() }
    }
}

private struct CertifiedProfileCard: View {
    let profile: CertifiedWallProfileDTO
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .font(.title2).foregroundStyle(.accentColor)
                VStack(alignment: .leading, spacing: 2) {
                    Text(profile.username).font(.headline)
                    Text(profile.certificationName).font(.caption).foregroundStyle(.secondary)
                }
                Spacer()
                if let country = profile.country {
                    Text(countryFlag(country)).font(.title3)
                }
            }
            if let testimonial = profile.testimonial {
                Text("« \(testimonial) »").font(.body).italic().foregroundStyle(.secondary)
            }
            HStack {
                Label(profile.certifiedAt.prefix(10), systemImage: "calendar")
                if let weeks = profile.prepDurationWeeks {
                    Label("\(weeks) semaines", systemImage: "book.fill")
                }
            }
            .font(.caption).foregroundStyle(.secondary)
        }
        .padding()
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func countryFlag(_ code: String) -> String {
        code.uppercased().unicodeScalars.reduce("") { result, scalar in
            guard let base = Unicode.Scalar(127397 + scalar.value) else { return result }
            return result + String(base)
        }
    }
}
