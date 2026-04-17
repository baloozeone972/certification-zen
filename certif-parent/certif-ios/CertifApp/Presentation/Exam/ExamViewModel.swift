// certif-parent/certif-ios/CertifApp/Presentation/Exam/ExamViewModel.swift
//
// Exam engine ViewModel — server-synchronized timer, multi-choice, offline SwiftData.
// Mirrors Android ExamViewModel.kt.
// @Observable + @MainActor for SwiftUI integration.

import Foundation
import SwiftData

// MARK: - SM2Calculator (pure domain — no dependencies)

/// Pure value-type SM-2 algorithm — mirrors Java SM2AlgorithmService.
enum SM2Calculator {

    static let minEaseFactor: Double = 1.3

    /// Computes new (intervalDays, easeFactor) from current SM-2 state and review quality.
    ///
    /// - Parameters:
    ///   - rating:      0-5 (0=blackout, 5=perfect)
    ///   - easeFactor:  current EF (>= 1.3)
    ///   - intervalDays: current interval
    ///   - repetitions: successful consecutive reviews
    /// - Returns: (newInterval, newEaseFactor)
    static func calculate(
        rating: Int,
        easeFactor: Double,
        intervalDays: Int,
        repetitions: Int
    ) -> (interval: Int, easeFactor: Double) {

        guard rating >= 0, rating <= 5 else {
            preconditionFailure("SM-2 quality must be 0-5, got \(rating)")
        }

        if rating >= 3 {
            // Correct answer
            let newInterval: Int
            switch repetitions {
            case 0:  newInterval = 1
            case 1:  newInterval = 6
            default: newInterval = Int((Double(intervalDays) * easeFactor).rounded())
            }
            let newEF = computeEF(current: easeFactor, quality: rating)
            return (newInterval, newEF)
        } else {
            // Incorrect — reset per SM-2 spec; EF unchanged on failure
            return (1, easeFactor)
        }
    }

    private static func computeEF(current: Double, quality: Int) -> Double {
        let q = Double(quality)
        let newEF = current + 0.1 - (5.0 - q) * (0.08 + (5.0 - q) * 0.02)
        return max(minEaseFactor, newEF)
    }
}

// MARK: - ExamEngineState

/// Sealed state for the exam engine screen.
enum ExamEngineState: Equatable {
    case loading
    case active(session: ExamSessionDTO, currentIndex: Int)
    case submitting
    case completed(result: ExamResultSummary)
    case error(String)

    static func == (lhs: ExamEngineState, rhs: ExamEngineState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.submitting, .submitting): return true
        case (.error(let a), .error(let b)): return a == b
        default: return false
        }
    }
}

// MARK: - ExamResultSummary

struct ExamResultSummary: Equatable {
    let sessionId: UUID
    let totalQuestions: Int
    let correctAnswers: Int
    let score: Double
    let passed: Bool
    let durationSeconds: Int
    let themeStats: [ThemeStatsDTO]
}

// MARK: - ExamEngineViewModel

/// Main ViewModel for the exam engine.
///
/// Responsibilities:
/// - Server-synchronized timer (started_at + duration, not client-only)
/// - Multi-choice question support (SINGLE_CHOICE and MULTIPLE_CHOICE)
/// - Offline answer persistence via SwiftData PendingSyncEntity
/// - @Observable for SwiftUI automatic view updates
@Observable
@MainActor
final class ExamEngineViewModel {

    // MARK: - State

    var state: ExamEngineState = .loading
    var selectedOptionIds: Set<UUID> = []
    var remainingSeconds: Int = 0
    var isTimerRunning: Bool = false
    var answeredQuestions: Set<UUID> = []

    // MARK: - Session data

    private(set) var session: ExamSessionDTO?
    private(set) var currentIndex: Int = 0
    private var startedAt: Date?
    private var timerTask: Task<Void, Never>?

    // MARK: - Computed

    var currentQuestion: QuestionDTO? {
        guard let questions = session?.questions,
              currentIndex < questions.count else { return nil }
        return questions[currentIndex]
    }

    var totalQuestions: Int { session?.questions?.count ?? 0 }

    var progressFraction: Double {
        guard totalQuestions > 0 else { return 0 }
        return Double(currentIndex) / Double(totalQuestions)
    }

    var canGoNext: Bool { currentIndex < totalQuestions - 1 }
    var isLastQuestion: Bool { currentIndex == totalQuestions - 1 }

    var isMultipleChoice: Bool {
        currentQuestion?.questionType == "MULTIPLE_CHOICE"
    }

    // MARK: - Dependencies

    private let examRepository: any ExamRepositoryProtocol
    private let modelContext: ModelContext?

    // MARK: - Init

    init(examRepository: any ExamRepositoryProtocol, modelContext: ModelContext? = nil) {
        self.examRepository = examRepository
        self.modelContext = modelContext
    }

    // MARK: - Load session

    func loadSession(sessionId: UUID) async {
        state = .loading
        do {
            let dto = try await examRepository.fetchSession(id: sessionId)
            session = dto
            startedAt = ISO8601DateFormatter().date(from: dto.startedAt) ?? Date()
            // Synchronize timer with server startedAt
            if let durationMin = dto.questions?.count != nil ? 90 : nil {
                remainingSeconds = computeRemainingSeconds(durationMinutes: durationMin)
            }
            state = .active(session: dto, currentIndex: 0)
            startTimer()
        } catch let error as APIError {
            state = .error(error.errorDescription ?? "Erreur inconnue")
        } catch {
            state = .error(error.localizedDescription)
        }
    }

    // MARK: - Answer selection

    func toggleOption(_ optionId: UUID) {
        guard let question = currentQuestion else { return }
        if question.questionType == "SINGLE_CHOICE" {
            selectedOptionIds = [optionId]
        } else {
            if selectedOptionIds.contains(optionId) {
                selectedOptionIds.remove(optionId)
            } else {
                selectedOptionIds.insert(optionId)
            }
        }
    }

    // MARK: - Submit answer

    func submitCurrentAnswer() async {
        guard let session = session, let question = currentQuestion else { return }
        let options = Array(selectedOptionIds)

        let request = SubmitAnswerRequestDTO(
            sessionId: session.id,
            questionId: question.id,
            selectedOptionIds: options,
            timeSpentSeconds: 30 // approximate
        )

        do {
            _ = try await examRepository.submitAnswer(request)
        } catch APIError.networkError {
            // Queue offline
            persistOffline(request: request)
        } catch {
            // Non-fatal — continue exam
        }

        answeredQuestions.insert(question.id)
        selectedOptionIds.removeAll()
    }

    // MARK: - Navigation

    func nextQuestion() {
        guard canGoNext else { return }
        currentIndex += 1
        selectedOptionIds.removeAll()
        if case .active = state {
            state = .active(session: session!, currentIndex: currentIndex)
        }
    }

    func skipQuestion() {
        nextQuestion()
    }

    // MARK: - Complete exam

    func completeExam() async {
        guard let session = session else { return }
        state = .submitting
        stopTimer()
        do {
            let result = try await examRepository.completeExam(sessionId: session.id)
            let summary = ExamResultSummary(
                sessionId: result.id,
                totalQuestions: result.totalQuestions,
                correctAnswers: result.correctAnswers,
                score: result.score ?? 0,
                passed: result.passed ?? false,
                durationSeconds: Int(Date().timeIntervalSince(startedAt ?? Date())),
                themeStats: result.themeStats ?? []
            )
            state = .completed(result: summary)
        } catch {
            state = .error(error.localizedDescription)
        }
    }

    // MARK: - Timer (server-synchronized)

    /// Starts a countdown timer synchronized with the server's startedAt timestamp.
    private func startTimer() {
        guard remainingSeconds > 0 else { return }
        isTimerRunning = true
        timerTask = Task { [weak self] in
            while let self = self, self.remainingSeconds > 0 {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                guard !Task.isCancelled else { break }
                self.remainingSeconds -= 1
                if self.remainingSeconds == 0 {
                    await self.completeExam() // auto-submit on expiry
                }
            }
        }
    }

    private func stopTimer() {
        timerTask?.cancel()
        timerTask = nil
        isTimerRunning = false
    }

    /// Computes remaining seconds from server startedAt + duration.
    private func computeRemainingSeconds(durationMinutes: Int) -> Int {
        guard let start = startedAt else { return durationMinutes * 60 }
        let elapsed = Int(Date().timeIntervalSince(start))
        let total = durationMinutes * 60
        return max(0, total - elapsed)
    }

    // MARK: - Offline persistence

    private func persistOffline(request: SubmitAnswerRequestDTO) {
        guard let context = modelContext else { return }
        let entity = PendingSyncEntity(type: "SUBMIT_ANSWER", payload: request)
        context.insert(entity)
        try? context.save()
    }

    deinit {
        timerTask?.cancel()
    }
}
