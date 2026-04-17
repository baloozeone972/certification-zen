// certif-ios/CertifApp/Presentation/Exam/ExamViews.swift
//
// Full exam flow: Config → Engine → Results
// Equivalent of ExamConfigScreen.kt + ExamEngineScreen.kt + ExamResultsScreen.kt

import SwiftUI

// MARK: - ExamConfigViewModel

@Observable
final class ExamConfigViewModel {

    var certification: CertificationDTO?
    var selectedMode: ExamSessionDTO.ExamModeRaw = .exam
    var selectedThemeCode: String?
    var questionCount: Int = 40
    var isLoading: Bool = false
    var errorMessage: String?
    var startedSession: ExamSessionDTO?

    private let certificationId: String
    private let examRepository: any ExamRepositoryProtocol
    private let certificationRepository: any CertificationRepositoryProtocol
    let authService: AuthService

    init(certificationId: String,
         examRepository: any ExamRepositoryProtocol,
         certificationRepository: any CertificationRepositoryProtocol,
         authService: AuthService) {
        self.certificationId = certificationId
        self.examRepository = examRepository
        self.certificationRepository = certificationRepository
        self.authService = authService
    }

    @MainActor
    func loadCertification() async {
        do {
            certification = try await certificationRepository.fetchById(certificationId)
            questionCount = certification?.totalQuestions ?? 40
        } catch {
            errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
        }
    }

    @MainActor
    func startExam() async {
        guard let user = authService.currentUser else { return }

        // Freemium guard
        let maxQ = FreemiumGuard.maxQuestions(tier: user.subscriptionTier, requested: questionCount)

        isLoading = true
        errorMessage = nil
        do {
            startedSession = try await examRepository.startExam(
                StartExamRequestDTO(
                    certificationId: certificationId,
                    mode: selectedMode.rawValue,
                    themeCode: selectedThemeCode,
                    questionCount: maxQ,
                    durationMinutes: certification?.examDurationMinutes
                )
            )
        } catch APIError.freemiumLimitReached(let msg) {
            errorMessage = msg
        } catch {
            errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
        }
        isLoading = false
    }
}

extension ExamSessionDTO {
    enum ExamModeRaw: String, CaseIterable {
        case exam = "EXAM"
        case free = "FREE"
        case revision = "REVISION"

        var label: String {
            switch self {
            case .exam:     return "Examen Blanc"
            case .free:     return "Mode Libre"
            case .revision: return "Révision"
            }
        }
    }
}

// MARK: - ExamConfigView

struct ExamConfigView: View {

    @State var viewModel: ExamConfigViewModel
    @State private var navigateToExam = false
    private let container = DIContainer.shared

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                if let cert = viewModel.certification {
                    // Certification header
                    VStack(alignment: .leading, spacing: 4) {
                        Text(cert.name).font(.title2.bold())
                        Text("\(cert.totalQuestions) questions • Score minimum : \(cert.passingScore)%")
                            .font(.subheadline).foregroundStyle(.secondary)
                    }

                    // Mode selector
                    SectionHeader(title: "Mode d'examen")
                    Picker("Mode", selection: $viewModel.selectedMode) {
                        ForEach(ExamSessionDTO.ExamModeRaw.allCases, id: \.self) { mode in
                            Text(mode.label).tag(mode)
                        }
                    }
                    .pickerStyle(.segmented)

                    // Theme selector (optional)
                    if let themes = cert.themes, !themes.isEmpty {
                        SectionHeader(title: "Thème (optionnel)")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ThemeChip(label: "Tous", isSelected: viewModel.selectedThemeCode == nil) {
                                    viewModel.selectedThemeCode = nil
                                }
                                ForEach(themes) { theme in
                                    ThemeChip(label: theme.label, isSelected: viewModel.selectedThemeCode == theme.code) {
                                        viewModel.selectedThemeCode = theme.code
                                    }
                                }
                            }
                        }
                    }

                    // Question count slider
                    SectionHeader(title: "Nombre de questions : \(viewModel.questionCount)")
                    Slider(value: Binding(
                        get: { Double(viewModel.questionCount) },
                        set: { viewModel.questionCount = Int($0) }
                    ), in: 10...Double(cert.totalQuestions), step: 5)

                    // Freemium notice
                    if viewModel.authService.currentUser?.subscriptionTier == .free {
                        FreemiumNotice(maxQuestions: FreemiumGuard.freeQuestionsPerExam)
                    }
                }

                // Error
                if let error = viewModel.errorMessage {
                    ErrorBannerView(message: error)
                }

                // Start button
                Button {
                    Task { await viewModel.startExam() }
                } label: {
                    Group {
                        if viewModel.isLoading {
                            ProgressView().tint(.white)
                        } else {
                            Label("Démarrer", systemImage: "play.fill")
                                .font(.headline)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .disabled(viewModel.isLoading)
            }
            .padding()
        }
        .navigationTitle("Configuration")
        .navigationBarTitleDisplayMode(.inline)
        .task { await viewModel.loadCertification() }
        .navigationDestination(item: $viewModel.startedSession) { session in
            ExamEngineView(viewModel: container.makeExamEngineViewModel(session: session))
        }
    }
}

// MARK: - ExamEngineViewModel

@Observable
final class ExamEngineViewModel {

    // MARK: - State

    var questions: [QuestionDTO] = []
    var currentIndex: Int = 0
    var selectedOptionIds: Set<UUID> = []
    var answerResult: AnswerResultDTO?
    var isAnswerRevealed: Bool = false
    var isLoading: Bool = false
    var completedSession: ExamSessionDTO?
    var timeRemaining: Int = 0
    var isTimerRunning: Bool = false

    var currentQuestion: QuestionDTO? { questions[safe: currentIndex] }
    var progress: Double { questions.isEmpty ? 0 : Double(currentIndex) / Double(questions.count) }
    var isLastQuestion: Bool { currentIndex == questions.count - 1 }

    // MARK: - Dependencies

    private let session: ExamSessionDTO
    private let examRepository: any ExamRepositoryProtocol
    private var timerTask: Task<Void, Never>?

    init(session: ExamSessionDTO, examRepository: any ExamRepositoryProtocol) {
        self.session = session
        self.examRepository = examRepository
        self.questions = session.questions ?? []
        self.timeRemaining = (session.questions?.count ?? 0) * 90 // ~90s/question default
    }

    @MainActor
    func startTimer() {
        isTimerRunning = true
        timerTask = Task {
            while timeRemaining > 0 && !Task.isCancelled {
                try? await Task.sleep(for: .seconds(1))
                timeRemaining -= 1
            }
            if timeRemaining == 0 { await completeExam() }
        }
    }

    @MainActor
    func submitAnswer() async {
        guard let question = currentQuestion else { return }
        guard !selectedOptionIds.isEmpty else { return }
        isLoading = true
        do {
            answerResult = try await examRepository.submitAnswer(
                SubmitAnswerRequestDTO(
                    sessionId: session.id,
                    questionId: question.id,
                    selectedOptionIds: Array(selectedOptionIds),
                    timeSpentSeconds: 90
                )
            )
            isAnswerRevealed = true
        } catch {
            // Show optimistic answer reveal on network error
            isAnswerRevealed = true
        }
        isLoading = false
    }

    @MainActor
    func nextQuestion() {
        if isLastQuestion {
            Task { await completeExam() }
        } else {
            currentIndex += 1
            selectedOptionIds = []
            answerResult = nil
            isAnswerRevealed = false
        }
    }

    @MainActor
    func completeExam() async {
        timerTask?.cancel()
        isLoading = true
        do {
            completedSession = try await examRepository.completeExam(sessionId: session.id)
        } catch {
            // Fallback with local data
        }
        isLoading = false
    }

    func toggleOption(_ optionId: UUID) {
        guard !isAnswerRevealed else { return }
        if selectedOptionIds.contains(optionId) {
            selectedOptionIds.remove(optionId)
        } else {
            // Single choice: replace; multiple: add
            if currentQuestion?.questionType == "SINGLE_CHOICE" {
                selectedOptionIds = [optionId]
            } else {
                selectedOptionIds.insert(optionId)
            }
        }
    }
}

// MARK: - ExamEngineView

struct ExamEngineView: View {

    @State var viewModel: ExamEngineViewModel
    private let container = DIContainer.shared

    var body: some View {
        VStack(spacing: 0) {
            // Progress bar
            ProgressView(value: viewModel.progress)
                .padding(.horizontal)
                .padding(.top, 8)

            // Timer
            HStack {
                Spacer()
                Label(formatTime(viewModel.timeRemaining), systemImage: "timer")
                    .font(.caption.monospacedDigit())
                    .foregroundStyle(viewModel.timeRemaining < 60 ? .red : .secondary)
                    .padding(.trailing)
            }

            // Question + Options
            if let question = viewModel.currentQuestion {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Question counter
                        Text("Question \(viewModel.currentIndex + 1)/\(viewModel.questions.count)")
                            .font(.caption).foregroundStyle(.secondary)

                        // Statement
                        Text(question.statement)
                            .font(.body)

                        // Code example
                        if let code = question.codeExample {
                            CodeBlock(code: code)
                        }

                        // Options
                        VStack(spacing: 10) {
                            ForEach(question.options) { option in
                                OptionButton(
                                    option: option,
                                    isSelected: viewModel.selectedOptionIds.contains(option.id),
                                    isRevealed: viewModel.isAnswerRevealed,
                                    action: { viewModel.toggleOption(option.id) }
                                )
                            }
                        }

                        // Explanation (after answer revealed)
                        if viewModel.isAnswerRevealed {
                            ExplanationPanel(
                                explanation: viewModel.answerResult?.explanation ?? question.explanation
                            )
                        }
                    }
                    .padding()
                }
            }

            Spacer()

            // Action button
            VStack(spacing: 0) {
                Divider()
                if !viewModel.isAnswerRevealed {
                    Button {
                        Task { await viewModel.submitAnswer() }
                    } label: {
                        Label("Valider", systemImage: "checkmark")
                            .frame(maxWidth: .infinity).padding()
                            .background(viewModel.selectedOptionIds.isEmpty ? Color.gray : Color.accentColor)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .disabled(viewModel.selectedOptionIds.isEmpty || viewModel.isLoading)
                    .padding()
                } else {
                    Button {
                        viewModel.nextQuestion()
                    } label: {
                        Label(viewModel.isLastQuestion ? "Terminer" : "Suivant",
                              systemImage: viewModel.isLastQuestion ? "flag.checkered" : "arrow.right")
                            .frame(maxWidth: .infinity).padding()
                            .background(Color.accentColor)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .padding()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Examen")
        .navigationBarTitleDisplayMode(.inline)
        .task { viewModel.startTimer() }
        .navigationDestination(item: $viewModel.completedSession) { session in
            ExamResultsView(session: session)
        }
    }

    private func formatTime(_ seconds: Int) -> String {
        let m = seconds / 60
        let s = seconds % 60
        return String(format: "%02d:%02d", m, s)
    }
}

// MARK: - ExamResultsView

struct ExamResultsView: View {

    let session: ExamSessionDTO

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                // Score circle
                ResultScoreCircle(score: session.score ?? 0, passed: session.passed ?? false)

                // Summary stats
                HStack(spacing: 16) {
                    StatCard(label: "Correctes", value: "\(session.correctAnswers)", color: .green)
                    StatCard(label: "Total", value: "\(session.totalQuestions)", color: .blue)
                    StatCard(label: "Score", value: String(format: "%.0f%%", session.score ?? 0), color: .orange)
                }

                // Per-theme breakdown
                if let themeStats = session.themeStats, !themeStats.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Résultats par thème").font(.headline)
                        ForEach(themeStats, id: \.themeCode) { stat in
                            ThemeStatRow(stat: stat)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }

                // Navigation buttons
                VStack(spacing: 12) {
                    NavigationLink("Revoir les réponses") {
                        // TODO Phase 2: ReviewSessionView
                        Text("À venir")
                    }
                    .buttonStyle(.bordered)

                    NavigationLink("Retour à l'accueil") {
                        ContentView()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
        }
        .navigationTitle(session.passed == true ? "🎉 Réussi !" : "Résultats")
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Supporting UI Components

private struct OptionButton: View {
    let option: QuestionOptionDTO
    let isSelected: Bool
    let isRevealed: Bool
    let action: () -> Void

    private var backgroundColor: Color {
        guard isRevealed else {
            return isSelected ? Color.accentColor.opacity(0.15) : Color(.systemBackground)
        }
        if option.isCorrect { return .green.opacity(0.15) }
        if isSelected && !option.isCorrect { return .red.opacity(0.15) }
        return Color(.systemBackground)
    }

    private var borderColor: Color {
        guard isRevealed else {
            return isSelected ? .accentColor : Color(.separator)
        }
        if option.isCorrect { return .green }
        if isSelected && !option.isCorrect { return .red }
        return Color(.separator)
    }

    var body: some View {
        Button(action: action) {
            HStack {
                Text(option.label).font(.caption.bold()).foregroundStyle(.secondary)
                    .frame(width: 24)
                Text(option.text).font(.body).foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)
                Spacer()
                if isRevealed {
                    Image(systemName: option.isCorrect ? "checkmark.circle.fill" : (isSelected ? "xmark.circle.fill" : ""))
                        .foregroundStyle(option.isCorrect ? .green : .red)
                }
            }
            .padding(12)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(borderColor, lineWidth: 1.5))
        }
        .buttonStyle(.plain)
        .disabled(isRevealed)
    }
}

private struct ExplanationPanel: View {
    let explanation: String
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("Explication", systemImage: "lightbulb.fill").font(.headline).foregroundStyle(.orange)
            Text(explanation).font(.body)
        }
        .padding()
        .background(Color.orange.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

private struct CodeBlock: View {
    let code: String
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            Text(code)
                .font(.system(.caption, design: .monospaced))
                .padding()
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

private struct ResultScoreCircle: View {
    let score: Double
    let passed: Bool
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray5), lineWidth: 12)
                .frame(width: 160)
            Circle()
                .trim(from: 0, to: score / 100)
                .stroke(passed ? Color.green : Color.red, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                .frame(width: 160)
                .rotationEffect(.degrees(-90))
            VStack {
                Text(String(format: "%.0f%%", score)).font(.largeTitle.bold())
                Text(passed ? "Réussi" : "Échoué").font(.caption).foregroundStyle(passed ? .green : .red)
            }
        }
        .padding()
    }
}

private struct StatCard: View {
    let label: String
    let value: String
    let color: Color
    var body: some View {
        VStack {
            Text(value).font(.title2.bold()).foregroundStyle(color)
            Text(label).font(.caption).foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

private struct ThemeStatRow: View {
    let stat: ThemeStatsDTO
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(stat.themeLabel).font(.subheadline)
                Spacer()
                Text(String(format: "%.0f%%", stat.percentage)).font(.subheadline.bold())
                    .foregroundStyle(stat.percentage >= 70 ? .green : .red)
            }
            ProgressView(value: stat.percentage / 100)
                .tint(stat.percentage >= 70 ? .green : .red)
        }
    }
}

private struct SectionHeader: View {
    let title: String
    var body: some View {
        Text(title).font(.headline).padding(.top, 4)
    }
}

private struct ThemeChip: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.caption.bold())
                .padding(.horizontal, 12).padding(.vertical, 6)
                .background(isSelected ? Color.accentColor : Color(.systemGray5))
                .foregroundStyle(isSelected ? .white : .primary)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}

private struct FreemiumNotice: View {
    let maxQuestions: Int
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "lock.fill").foregroundStyle(.orange)
            Text("Mode gratuit : \(maxQuestions) questions max. Passez Pro pour un accès illimité.")
                .font(.caption).foregroundStyle(.secondary)
        }
        .padding(10)
        .background(Color.orange.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// MARK: - Collection safe subscript

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
