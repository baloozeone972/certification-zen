// certif-ios/CertifApp/Presentation/Learning/LearningViews.swift
//
// Learning module: Flashcards SM-2, Courses (Markdown), Adaptive Plan.
// Equivalent of FlashcardScreen.kt + CourseScreen.kt + AdaptivePlanScreen.kt

import SwiftUI
import MarkdownUI

// MARK: - LearningHubView

/// Navigation hub for the learning tab.
struct LearningHubView: View {
    private let container = DIContainer.shared

    var body: some View {
        List {
            NavigationLink {
                // Needs certification selection — simplified: uses last known cert
                FlashcardView(viewModel: container.makeFlashcardViewModel(certificationId: "java21"))
            } label: {
                Label("Flashcards (SM-2)", systemImage: "rectangle.on.rectangle.angled.fill")
            }

            NavigationLink {
                AdaptivePlanView(viewModel: container.makeAdaptivePlanViewModel(certificationId: "java21"))
            } label: {
                Label("Plan adaptatif", systemImage: "brain.head.profile")
            }

            NavigationLink {
                HistoryView(viewModel: container.makeHistoryViewModel())
            } label: {
                Label("Historique", systemImage: "clock.fill")
            }
        }
        .navigationTitle("Apprendre")
    }
}

// MARK: - FlashcardViewModel

@Observable
final class FlashcardViewModel {

    var flashcards: [FlashcardDTO] = []
    var currentIndex: Int = 0
    var isFlipped: Bool = false
    var isLoading: Bool = false
    var isDeckComplete: Bool = false
    var errorMessage: String?

    var currentFlashcard: FlashcardDTO? { flashcards[safe: currentIndex] }
    var progress: Double { flashcards.isEmpty ? 0 : Double(currentIndex) / Double(flashcards.count) }

    private let certificationId: String
    private let learningRepository: any LearningRepositoryProtocol

    init(certificationId: String, learningRepository: any LearningRepositoryProtocol) {
        self.certificationId = certificationId
        self.learningRepository = learningRepository
    }

    @MainActor
    func loadFlashcards() async {
        isLoading = true
        do {
            flashcards = try await learningRepository.fetchFlashcards(certificationId: certificationId, limit: 20)
        } catch {
            errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
        }
        isLoading = false
    }

    @MainActor
    func review(rating: Int) async {
        guard let card = currentFlashcard else { return }
        _ = try? await learningRepository.reviewFlashcard(id: card.id, rating: rating)
        isFlipped = false
        if currentIndex < flashcards.count - 1 {
            currentIndex += 1
        } else {
            isDeckComplete = true
        }
    }

    func flip() { isFlipped.toggle() }
}

// MARK: - FlashcardView

struct FlashcardView: View {

    @State var viewModel: FlashcardViewModel
    @State private var dragOffset: CGSize = .zero
    @State private var dragColor: Color = .clear

    var body: some View {
        VStack(spacing: 24) {
            // Progress
            ProgressView(value: viewModel.progress)
                .padding(.horizontal)
            Text("\(viewModel.currentIndex)/\(viewModel.flashcards.count)")
                .font(.caption).foregroundStyle(.secondary)

            if viewModel.isDeckComplete {
                DeckCompleteView {
                    Task {
                        viewModel.currentIndex = 0
                        viewModel.isDeckComplete = false
                        await viewModel.loadFlashcards()
                    }
                }
            } else if let card = viewModel.currentFlashcard {
                // Flashcard with flip animation
                ZStack {
                    FlashcardFace(text: card.backText, codeExample: card.codeExample, isFront: false)
                        .rotation3DEffect(.degrees(viewModel.isFlipped ? 0 : 180), axis: (1, 0, 0))
                        .opacity(viewModel.isFlipped ? 1 : 0)

                    FlashcardFace(text: card.frontText, codeExample: nil, isFront: true)
                        .rotation3DEffect(.degrees(viewModel.isFlipped ? 180 : 0), axis: (1, 0, 0))
                        .opacity(viewModel.isFlipped ? 0 : 1)
                }
                .offset(x: dragOffset.width)
                .overlay(alignment: .center) {
                    if dragOffset.width > 40 {
                        SwipeLabel(text: "Connu", color: .green)
                    } else if dragOffset.width < -40 {
                        SwipeLabel(text: "À revoir", color: .red)
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation
                        }
                        .onEnded { value in
                            if value.translation.width > 80 {
                                Task { await viewModel.review(rating: 4) }  // known
                            } else if value.translation.width < -80 {
                                Task { await viewModel.review(rating: 1) }  // again
                            }
                            withAnimation { dragOffset = .zero }
                        }
                )
                .onTapGesture { viewModel.flip() }
                .animation(.spring(duration: 0.4), value: viewModel.isFlipped)

                // Rating buttons (visible after flip)
                if viewModel.isFlipped {
                    SM2RatingRow { rating in
                        Task { await viewModel.review(rating: rating) }
                    }
                } else {
                    Text("Appuyez pour retourner")
                        .font(.caption).foregroundStyle(.secondary)
                }
            }
        }
        .padding()
        .navigationTitle("Flashcards")
        .task { await viewModel.loadFlashcards() }
    }
}

// MARK: - FlashcardFace

private struct FlashcardFace: View {
    let text: String
    let codeExample: String?
    let isFront: Bool

    var body: some View {
        VStack(spacing: 16) {
            Text(isFront ? "Question" : "Réponse")
                .font(.caption.bold())
                .foregroundStyle(isFront ? Color.accentColor : .green)
                .padding(.horizontal, 8).padding(.vertical, 4)
                .background((isFront ? Color.accentColor : Color.green).opacity(0.1))
                .clipShape(Capsule())

            ScrollView {
                Text(text).font(.body).multilineTextAlignment(.center).padding()
                if let code = codeExample {
                    Text(code)
                        .font(.system(.caption, design: .monospaced))
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 300)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.08), radius: 10, y: 5)
    }
}

// MARK: - SM2RatingRow

private struct SM2RatingRow: View {
    let onRate: (Int) -> Void

    private let ratings: [(Int, String, Color)] = [
        (0, "Oublié", .red),
        (1, "Difficile", .orange),
        (3, "Moyen", .yellow),
        (4, "Bien", .green),
        (5, "Parfait", .teal)
    ]

    var body: some View {
        HStack(spacing: 8) {
            ForEach(ratings, id: \.0) { rating, label, color in
                Button {
                    onRate(rating)
                } label: {
                    VStack(spacing: 2) {
                        Circle().fill(color).frame(width: 12, height: 12)
                        Text(label).font(.system(size: 9)).foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(color.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .buttonStyle(.plain)
            }
        }
    }
}

// MARK: - DeckCompleteView

private struct DeckCompleteView: View {
    let onRestart: () -> Void
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 60)).foregroundStyle(.green)
            Text("Deck terminé !").font(.title.bold())
            Text("Toutes les flashcards ont été révisées.").foregroundStyle(.secondary)
            Button("Recommencer", action: onRestart)
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

private struct SwipeLabel: View {
    let text: String
    let color: Color
    var body: some View {
        Text(text).font(.headline.bold()).padding(10)
            .background(color.opacity(0.15))
            .foregroundStyle(color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .rotationEffect(.degrees(-10))
    }
}

// MARK: - CourseViewModel

@Observable
final class CourseViewModel {

    var course: CourseDTO?
    var isLoading: Bool = false
    var errorMessage: String?

    private let certificationId: String
    private let themeCode: String
    private let learningRepository: any LearningRepositoryProtocol

    init(certificationId: String, themeCode: String, learningRepository: any LearningRepositoryProtocol) {
        self.certificationId = certificationId
        self.themeCode = themeCode
        self.learningRepository = learningRepository
    }

    @MainActor
    func loadCourse() async {
        isLoading = true
        do {
            course = try await learningRepository.fetchCourse(certificationId: certificationId, themeCode: themeCode)
        } catch {
            errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
        }
        isLoading = false
    }
}

// MARK: - CourseView

struct CourseView: View {

    @State var viewModel: CourseViewModel

    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView().padding(.top, 60)
            } else if let course = viewModel.course {
                Markdown(course.contentMarkdown)
                    .markdownTheme(.gitHub)
                    .padding()
            } else if let error = viewModel.errorMessage {
                ErrorBannerView(message: error)
            }
        }
        .navigationTitle(viewModel.course?.title ?? "Cours")
        .navigationBarTitleDisplayMode(.large)
        .task { await viewModel.loadCourse() }
    }
}

// MARK: - AdaptivePlanViewModel

@Observable
final class AdaptivePlanViewModel {

    var plan: AdaptivePlanDTO?
    var isLoading: Bool = false
    var errorMessage: String?

    private let certificationId: String
    private let learningRepository: any LearningRepositoryProtocol

    init(certificationId: String, learningRepository: any LearningRepositoryProtocol) {
        self.certificationId = certificationId
        self.learningRepository = learningRepository
    }

    @MainActor
    func loadPlan() async {
        isLoading = true
        do {
            plan = try await learningRepository.fetchAdaptivePlan(certificationId: certificationId)
        } catch {
            errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
        }
        isLoading = false
    }
}

// MARK: - AdaptivePlanView

struct AdaptivePlanView: View {

    @State var viewModel: AdaptivePlanViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if viewModel.isLoading {
                    ProgressView().frame(maxWidth: .infinity).padding(.top, 60)
                } else if let plan = viewModel.plan {
                    // Score prediction
                    ScorePredictionCard(score: plan.predictedScore, readiness: plan.readinessLevel)

                    // Today's sessions
                    if !plan.todaySessions.isEmpty {
                        Text("Aujourd'hui").font(.headline)
                        ForEach(plan.todaySessions) { session in
                            PlanSessionCard(session: session)
                        }
                    }

                    // Weak themes
                    if !plan.weakThemes.isEmpty {
                        Text("Thèmes à renforcer").font(.headline)
                        FlowLayout(items: plan.weakThemes) { theme in
                            Text(theme)
                                .font(.caption).padding(.horizontal, 10).padding(.vertical, 5)
                                .background(Color.red.opacity(0.1)).foregroundStyle(.red)
                                .clipShape(Capsule())
                        }
                    }

                    // Estimated ready date
                    if let date = plan.estimatedReadyDate {
                        HStack {
                            Image(systemName: "calendar.badge.checkmark").foregroundStyle(.green)
                            Text("Prêt pour l'examen le \(date)")
                                .font(.subheadline).foregroundStyle(.secondary)
                        }
                        .padding()
                        .background(Color.green.opacity(0.08))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                } else if let error = viewModel.errorMessage {
                    ErrorBannerView(message: error)
                }
            }
            .padding()
        }
        .navigationTitle("Plan adaptatif")
        .task { await viewModel.loadPlan() }
        .refreshable { await viewModel.loadPlan() }
    }
}

private struct ScorePredictionCard: View {
    let score: Double
    let readiness: String
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Score prédit").font(.caption).foregroundStyle(.secondary)
                Text(String(format: "%.0f%%", score)).font(.largeTitle.bold())
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("Niveau").font(.caption).foregroundStyle(.secondary)
                Text(readiness).font(.headline)
                    .foregroundStyle(score >= 70 ? .green : score >= 50 ? .orange : .red)
            }
        }
        .padding()
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

private struct PlanSessionCard: View {
    let session: PlanSessionDTO
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(session.themeLabel).font(.subheadline.bold())
                Text(session.type).font(.caption).foregroundStyle(.secondary)
            }
            Spacer()
            Text("\(session.durationMinutes) min")
                .font(.caption.bold())
                .padding(.horizontal, 8).padding(.vertical, 4)
                .background(Color.accentColor.opacity(0.1))
                .foregroundStyle(.accentColor)
                .clipShape(Capsule())
        }
        .padding()
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Simple FlowLayout

private struct FlowLayout<Item: Hashable, Content: View>: View {
    let items: [Item]
    @ViewBuilder let content: (Item) -> Content

    var body: some View {
        var rows: [[Item]] = [[]]
        // Simple approximation — SwiftUI Layout API for exact flow layout
        for item in items {
            if rows[rows.count - 1].count < 3 {
                rows[rows.count - 1].append(item)
            } else {
                rows.append([item])
            }
        }
        return VStack(alignment: .leading, spacing: 8) {
            ForEach(rows.indices, id: \.self) { i in
                HStack(spacing: 8) {
                    ForEach(rows[i], id: \.self) { item in
                        content(item)
                    }
                }
            }
        }
    }
}
