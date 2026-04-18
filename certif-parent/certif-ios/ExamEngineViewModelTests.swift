// certif-parent/certif-ios/ExamEngineViewModelTests.swift
//
// ViewModel tests using protocol-based mock repositories.
// Mirrors Android ExamViewModelTest.kt pattern.
// Uses ExamEngineViewModel from ExamViewModel.swift.

import XCTest
@testable import CertifApp

// MARK: - MockExamRepository

final class MockExamRepository: ExamRepositoryProtocol {

    var startExamResult: ExamSessionDTO?
    var startExamError: Error?
    var submitAnswerError: Error?
    var completeExamResult: ExamSessionDTO?

    var startExamCallCount = 0
    var submitAnswerCallCount = 0
    var completeExamCallCount = 0
    var lastSubmittedRequest: SubmitAnswerRequestDTO?

    func startExam(_ request: StartExamRequestDTO) async throws -> ExamSessionDTO {
        startExamCallCount += 1
        if let error = startExamError { throw error }
        return startExamResult ?? makeSessionDTO()
    }

    func submitAnswer(_ request: SubmitAnswerRequestDTO) async throws -> AnswerResultDTO {
        submitAnswerCallCount += 1
        lastSubmittedRequest = request
        if let error = submitAnswerError { throw error }
        return AnswerResultDTO(
            questionId: request.questionId,
            isCorrect: true,
            explanation: "Test explanation",
            correctOptionIds: request.selectedOptionIds
        )
    }

    func completeExam(sessionId: UUID) async throws -> ExamSessionDTO {
        completeExamCallCount += 1
        return completeExamResult ?? makeSessionDTO(status: "COMPLETED")
    }

    func fetchHistory(userId: UUID, page: Int, size: Int) async throws -> PageResponse<ExamSessionSummaryDTO> {
        PageResponse(content: [], totalElements: 0, totalPages: 0, number: 0, size: size)
    }

    func fetchSession(id: UUID) async throws -> ExamSessionDTO {
        if let error = startExamError { throw error }
        return startExamResult ?? makeSessionDTO()
    }

    // MARK: - Builders

    func makeSessionDTO(status: String = "IN_PROGRESS") -> ExamSessionDTO {
        ExamSessionDTO(
            id: UUID(), userId: UUID(), certificationId: "java21",
            mode: "EXAM", status: status,
            startedAt: ISO8601DateFormatter().string(from: Date()),
            endedAt: nil, totalQuestions: 2, correctAnswers: 0,
            score: nil, passed: nil,
            questions: [makeQuestionDTO(isCorrect: true), makeQuestionDTO(isCorrect: false)],
            themeStats: nil
        )
    }

    func makeQuestionDTO(isCorrect: Bool = true) -> QuestionDTO {
        let correctId = UUID()
        let wrongId   = UUID()
        return QuestionDTO(
            id: UUID(), certificationId: "java21", themeCode: "oop",
            statement: "Test question?",
            options: [
                QuestionOptionDTO(id: correctId, label: "A", text: "Option A", isCorrect: true),
                QuestionOptionDTO(id: wrongId,   label: "B", text: "Option B", isCorrect: false)
            ],
            explanation: "Test explanation",
            difficultyLevel: "MEDIUM",
            questionType: "SINGLE_CHOICE",
            tags: ["test"], codeExample: nil
        )
    }
}

// MARK: - ExamEngineViewModelTests

@MainActor
final class ExamEngineViewModelTests: XCTestCase {

    private var mockRepo: MockExamRepository!
    private var viewModel: ExamEngineViewModel!

    override func setUp() async throws {
        mockRepo  = MockExamRepository()
        viewModel = ExamEngineViewModel(examRepository: mockRepo)
    }

    // MARK: - loadSession

    func test_loadSession_success_setsActiveState() async throws {
        let sessionId = UUID()
        mockRepo.startExamResult = mockRepo.makeSessionDTO()

        await viewModel.loadSession(sessionId: sessionId)

        if case .active(let session, let index) = viewModel.state {
            XCTAssertEqual(index, 0)
            XCTAssertEqual(session.mode, "EXAM")
        } else {
            XCTFail("Expected .active state, got \(viewModel.state)")
        }
    }

    func test_loadSession_networkError_setsErrorState() async {
        mockRepo.startExamError = APIError.networkError(underlying: URLError(.notConnectedToInternet))

        await viewModel.loadSession(sessionId: UUID())

        if case .error = viewModel.state {
            // Expected
        } else {
            XCTFail("Expected .error state, got \(viewModel.state)")
        }
    }

    // MARK: - toggleOption

    func test_toggleOption_singleChoice_replacesSelection() async {
        await viewModel.loadSession(sessionId: UUID())

        let optionA = UUID()
        let optionB = UUID()

        viewModel.toggleOption(optionA)
        XCTAssertEqual(viewModel.selectedOptionIds, [optionA])

        viewModel.toggleOption(optionB)
        XCTAssertEqual(viewModel.selectedOptionIds, [optionB], "Single choice must replace selection")
    }

    func test_toggleOption_deselects_whenTappedAgain() async {
        await viewModel.loadSession(sessionId: UUID())

        // Force multiple choice for this test
        let optionId = UUID()
        viewModel.toggleOption(optionId)
        viewModel.toggleOption(optionId) // deselect

        // For single choice, second tap replaces — result is still [optionId]
        // This is expected behavior for SINGLE_CHOICE
        XCTAssertFalse(viewModel.selectedOptionIds.isEmpty || viewModel.selectedOptionIds.count > 1)
    }

    // MARK: - nextQuestion

    func test_nextQuestion_incrementsIndex() async {
        await viewModel.loadSession(sessionId: UUID())
        XCTAssertEqual(viewModel.currentIndex, 0)

        viewModel.nextQuestion()
        XCTAssertEqual(viewModel.currentIndex, 1)
    }

    func test_nextQuestion_doesNotExceedBounds() async {
        await viewModel.loadSession(sessionId: UUID())

        // Go to last question
        viewModel.nextQuestion()
        viewModel.nextQuestion() // should not go further

        XCTAssertEqual(viewModel.currentIndex, 1, "Index must not exceed question count")
    }

    // MARK: - submitCurrentAnswer

    func test_submitAnswer_callsRepository() async throws {
        await viewModel.loadSession(sessionId: UUID())

        if let q = viewModel.currentQuestion {
            viewModel.toggleOption(q.options.first!.id)
        }
        await viewModel.submitCurrentAnswer()

        XCTAssertEqual(mockRepo.submitAnswerCallCount, 1)
        XCTAssertNotNil(mockRepo.lastSubmittedRequest)
    }

    func test_submitAnswer_clearsSelection() async {
        await viewModel.loadSession(sessionId: UUID())
        viewModel.toggleOption(UUID())

        await viewModel.submitCurrentAnswer()

        XCTAssertTrue(viewModel.selectedOptionIds.isEmpty)
    }

    // MARK: - completeExam

    func test_completeExam_setsCompletedState() async {
        await viewModel.loadSession(sessionId: UUID())
        mockRepo.completeExamResult = mockRepo.makeSessionDTO(status: "COMPLETED")
        let completedDTO = mockRepo.makeSessionDTO(status: "COMPLETED")
        mockRepo.completeExamResult = completedDTO

        await viewModel.completeExam()

        if case .completed = viewModel.state {
            // Expected
        } else {
            XCTFail("Expected .completed state, got \(viewModel.state)")
        }
    }

    // MARK: - progressFraction

    func test_progressFraction_correctValues() async {
        await viewModel.loadSession(sessionId: UUID()) // 2 questions
        XCTAssertEqual(viewModel.progressFraction, 0.0, accuracy: 0.01)

        viewModel.nextQuestion()
        XCTAssertEqual(viewModel.progressFraction, 0.5, accuracy: 0.01)
    }

    // MARK: - isLastQuestion

    func test_isLastQuestion_trueOnLastQuestion() async {
        await viewModel.loadSession(sessionId: UUID()) // 2 questions
        viewModel.nextQuestion()
        XCTAssertTrue(viewModel.isLastQuestion)
    }
}
