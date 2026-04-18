// certif-ios/CertifApp/Presentation/History/HistoryView.swift
//
// Exam session history with pagination and filters.
// Equivalent of the history tab in Android's LearningViewModel.

import SwiftUI

// MARK: - HistoryViewModel

@Observable
final class HistoryViewModel {

    // MARK: - State

    var sessions: [ExamSessionSummaryDTO] = []
    var isLoading: Bool = false
    var errorMessage: String?
    var currentPage: Int = 0
    var hasMorePages: Bool = true
    var selectedFilter: HistoryFilter = .all

    enum HistoryFilter: String, CaseIterable {
        case all      = "Tous"
        case passed   = "Réussis"
        case failed   = "Échoués"
        case exam     = "Examen blanc"
        case revision = "Révision"
    }

    var filteredSessions: [ExamSessionSummaryDTO] {
        switch selectedFilter {
        case .all:      return sessions
        case .passed:   return sessions.filter { $0.passed == true }
        case .failed:   return sessions.filter { $0.passed == false }
        case .exam:     return sessions.filter { $0.mode == "EXAM" }
        case .revision: return sessions.filter { $0.mode == "REVISION" }
        }
    }

    // MARK: - Dependencies

    private let examRepository: any ExamRepositoryProtocol
    private let authService: AuthService

    init(examRepository: any ExamRepositoryProtocol, authService: AuthService) {
        self.examRepository = examRepository
        self.authService = authService
    }

    // MARK: - Actions

    @MainActor
    func loadHistory() async {
        guard let userId = authService.currentUser?.id else { return }
        isLoading = true
        currentPage = 0
        do {
            let page = try await examRepository.fetchHistory(userId: userId, page: 0, size: 20)
            sessions = page.content
            hasMorePages = page.number < page.totalPages - 1
        } catch {
            errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
        }
        isLoading = false
    }

    @MainActor
    func loadMore() async {
        guard hasMorePages, !isLoading,
              let userId = authService.currentUser?.id else { return }
        currentPage += 1
        do {
            let page = try await examRepository.fetchHistory(userId: userId, page: currentPage, size: 20)
            sessions.append(contentsOf: page.content)
            hasMorePages = page.number < page.totalPages - 1
        } catch { }
    }
}

// MARK: - HistoryView

struct HistoryView: View {

    @State var viewModel: HistoryViewModel

    var body: some View {
        VStack(spacing: 0) {
            // Filter chips
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(HistoryViewModel.HistoryFilter.allCases, id: \.self) { filter in
                        FilterChip(
                            label: filter.rawValue,
                            isSelected: viewModel.selectedFilter == filter
                        ) {
                            viewModel.selectedFilter = filter
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }

            Divider()

            // Sessions list
            if viewModel.isLoading && viewModel.sessions.isEmpty {
                Spacer()
                ProgressView()
                Spacer()
            } else if viewModel.filteredSessions.isEmpty {
                Spacer()
                ContentUnavailableView(
                    "Aucun examen",
                    systemImage: "tray",
                    description: Text("Commencez un examen pour voir votre historique ici.")
                )
                Spacer()
            } else {
                List {
                    ForEach(viewModel.filteredSessions) { session in
                        SessionHistoryRow(session: session)
                            .onAppear {
                                if session.id == viewModel.filteredSessions.last?.id {
                                    Task { await viewModel.loadMore() }
                                }
                            }
                    }
                    if viewModel.isLoading {
                        HStack { Spacer(); ProgressView(); Spacer() }
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Historique")
        .task { await viewModel.loadHistory() }
        .refreshable { await viewModel.loadHistory() }
        .overlay {
            if let error = viewModel.errorMessage {
                VStack {
                    Spacer()
                    ErrorBannerView(message: error).padding()
                }
            }
        }
    }
}

// MARK: - SessionHistoryRow

private struct SessionHistoryRow: View {
    let session: ExamSessionSummaryDTO

    var body: some View {
        HStack(spacing: 14) {
            // Score circle
            ZStack {
                Circle()
                    .stroke(scoreColor.opacity(0.2), lineWidth: 4)
                Circle()
                    .trim(from: 0, to: (session.score ?? 0) / 100)
                    .stroke(scoreColor, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                Text(String(format: "%.0f", session.score ?? 0))
                    .font(.caption2.bold())
                    .foregroundStyle(scoreColor)
            }
            .frame(width: 44, height: 44)

            // Info
            VStack(alignment: .leading, spacing: 4) {
                Text(session.certificationName)
                    .font(.subheadline.bold())
                    .lineLimit(1)
                HStack(spacing: 8) {
                    Text(modeLabel)
                        .font(.caption).foregroundStyle(.secondary)
                    Text("•").foregroundStyle(.secondary)
                    Text(formattedDate)
                        .font(.caption).foregroundStyle(.secondary)
                }
            }

            Spacer()

            // Pass/Fail badge
            if let passed = session.passed {
                Text(passed ? "✓" : "✗")
                    .font(.headline.bold())
                    .foregroundStyle(passed ? .green : .red)
            }
        }
        .padding(.vertical, 4)
    }

    private var scoreColor: Color {
        let s = session.score ?? 0
        if s >= 70 { return .green }
        if s >= 50 { return .orange }
        return .red
    }

    private var modeLabel: String {
        switch session.mode {
        case "EXAM":     return "Examen blanc"
        case "FREE":     return "Libre"
        case "REVISION": return "Révision"
        default:         return session.mode
        }
    }

    private var formattedDate: String {
        let raw = session.startedAt
        // ISO8601 prefix 10 chars = YYYY-MM-DD
        return String(raw.prefix(10))
    }
}

// MARK: - FilterChip

private struct FilterChip: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.caption.bold())
                .padding(.horizontal, 14).padding(.vertical, 7)
                .background(isSelected ? Color.accentColor : Color(.systemGray5))
                .foregroundStyle(isSelected ? .white : .primary)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.15), value: isSelected)
    }
}
