// certif-ios/CertifAppTests/Presentation/ExamEngineViewModelTests.swift
//
// ViewModel tests using protocol-based mock repositories.
// Mirrors Android ExamViewModelTest.kt pattern.

import XCTest
@testable import CertifApp

// MARK: - Mock Repositories

final class MockExamRepository: ExamRepositoryProtocol {
    var startExamResult: ExamSessionDTO?
    var startExamError: Error?
    var submitAnswerResult: AnswerResultDTO?
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
        return submitAnswerResult ?? AnswerResultDTO(
            questionId: request.questionId,
            isCorrect: true,
            explanation: "Test explanation",
            correctOptionIds: [request.selectedOptionIds.first!]
        )
    }

    func completeExam(sessionId: UUID) async throws -> ExamSessionDTO {
        completeExamCallCount += 1
        return completeExamResult ?? makeSessionDTO(status: "COMPLETED")
    }

    func fetchHistory(userId: UUID, page: Int, size: Int) async throws -> PageResponse<ExamSessionSummaryDTO> {
        PageResponse(content: [], totalElements: 0, totalPages: 0, number: 0, size: size)
    }

    func fetchSession(id: UUID) async throws -> ExamSessionDTO { makeSessionDTO() }

    private func makeSessionDTO(status: String = "IN_PROGRESS") -> ExamSessionDTO {
        ExamSessionDTO(
            id: UUID(), userId: UUID(), certificationId: "java21",
            mode: "EXAM", status: status,
            startedAt: ISO8601DateFormatter().string(from: Date()),
            endedAt: nil, totalQuestions: 2, correctAnswers: 0,
            score: nil, passed: nil,
            questions: [makeQuestionDTO(), makeQuestionDTO()],
            themeStats: nil
        )
    }

    private func makeQuestionDTO() -> QuestionDTO {
        let optionId = UUID()
        return QuestionDTO(
            id: UUID(), certificationId: "java21", themeCode: "oop",
            statement: "Test question?",
            options: [
                QuestionOptionDTO(id: optionId, label: "A", text: "Option A", isCorrect: true),
                QuestionOptionDTO(id: UUID(), label: "B", text: "Option B", isCorrect: false)
            ],
            explanation: "Test explanation",
            difficultyLevel: "MEDIUM",
            questionType: "SINGLE_CHOICE",
            tags: ["test"], codeExample: nil
        )
    }
}

final class MockCertificationRepository: CertificationRepositoryProtocol {
    var certifications: [CertificationDTO] = []
    var fetchAllError: Error?

    func fetchAll() async throws -> [CertificationDTO] {
        if let error = fetchAllError { throw error }
        return certifications
    }

    func fetchById(_ id: String) async throws -> CertificationDTO {
        guard let cert = certifications.first(where: { $0.id == id }) else {
            throw APIError.notFound
        }
        return cert
    }
}

// MARK: - ExamEngineViewModelTests

@MainActor
final class ExamEngineViewModelTests: XCTestCase {

    private var mockRepo: MockExamRepository!
    private var session: ExamSessionDTO!

    override func setUp() {
        super.setUp()
        mockRepo = MockExamRepository()
        // Build a session with 2 questions directly
        let optId1 = UUID()
        let optId2 = UUID()
        session = ExamSessionDTO(
            id: UUID(), userId: UUID(), certificationId: "java21",
            mode: "EXAM", status: "IN_PROGRESS",
            startedAt: ISO8601DateFormatter().string(from: Date()),
            endedAt: nil, totalQuestions: 2, correctAnswers: 0,
            score: nil, passed: nil,
            questions: [
                QuestionDTO(
                    id: UUID(), certificationId: "java21", themeCode: "oop",
                    statement: "Q1?",
                    options: [
                        QuestionOptionDTO(id: optId1, label: "A", text: "Option A", isCorrect: true),
                        QuestionOptionDTO(id: UUID(), label: "B", text: "Option B", isCorrect: false)
                    ],
                    explanation: "Expl 1", difficultyLevel: "EASY",
                    questionType: "SINGLE_CHOICE", tags: [], codeExample: nil
                ),
                QuestionDTO(
                    id: UUID(), certificationId: "java21", themeCode: "collections",
                    statement: "Q2?",
                    options: [
                        QuestionOptionDTO(id: optId2, label: "A", text: "Option A", isCorrect: true),
                        QuestionOptionDTO(id: UUID(), label: "B", text: "Option B", isCorrect: false)
                    ],
                    explanation: "Expl 2", difficultyLevel: "MEDIUM",
                    questionType: "SINGLE_CHOICE", tags: [], codeExample: nil
                )
            ],
            themeStats: nil
        )
    }

    // MARK: - Initial state

    func test_initialState_firstQuestionLoaded() {
        let vm = ExamEngineViewModel(session: session, examRepository: mockRepo)
        XCTAssertEqual(vm.currentIndex, 0)
        XCTAssertEqual(vm.questions.count, 2)
        XCTAssertFalse(vm.isAnswerRevealed)
        XCTAssertTrue(vm.selectedOptionIds.isEmpty)
        XCTAssertNil(vm.completedSession)
    }

    // MARK: - Option selection

    func test_toggleOption_singleChoice_replacesSelection() {
        let vm = ExamEngineViewModel(session: session, examRepository: mockRepo)
        let id1 = UUID()
        let id2 = UUID()
        vm.toggleOption(id1)
        XCTAssertEqual(vm.selectedOptionIds, [id1])
        vm.toggleOption(id2)
        // Single choice: only one option at a time
        XCTAssertEqual(vm.selectedOptionIds, [id2])
    }

    func test_toggleOption_alreadySelected_deselects() {
        let vm = ExamEngineViewModel(session: session, examRepository: mockRepo)
        let id = UUID()
        vm.toggleOption(id)
        vm.toggleOption(id) // deselect
        XCTAssertTrue(vm.selectedOptionIds.isEmpty)
    }

    func test_toggleOption_disabled_afterReveal() {
        let vm = ExamEngineViewModel(session: session, examRepository: mockRepo)
        vm.isAnswerRevealed = true
        let id = UUID()
        vm.toggleOption(id)
        XCTAssertTrue(vm.selectedOptionIds.isEmpty, "Options must be locked after answer reveal")
    }

    // MARK: - Submit answer

    func test_submitAnswer_callsRepository() async {
        let vm = ExamEngineViewModel(session: session, examRepository: mockRepo)
        let optionId = session.questions!.first!.options.first!.id
        vm.toggleOption(optionId)
        await vm.submitAnswer()
        XCTAssertEqual(mockRepo.submitAnswerCallCount, 1)
        XCTAssertTrue(vm.isAnswerRevealed)
        XCTAssertNotNil(vm.answerResult)
    }

    func test_submitAnswer_withNoSelection_doesNotCall() async {
        let vm = ExamEngineViewModel(session: session, examRepository: mockRepo)
        await vm.submitAnswer()
        XCTAssertEqual(mockRepo.submitAnswerCallCount, 0)
    }

    // MARK: - Navigation

    func test_nextQuestion_advancesIndex() async {
        let vm = ExamEngineViewModel(session: session, examRepository: mockRepo)
        let optionId = session.questions!.first!.options.first!.id
        vm.toggleOption(optionId)
        await vm.submitAnswer()
        vm.nextQuestion()
        XCTAssertEqual(vm.currentIndex, 1)
        XCTAssertFalse(vm.isAnswerRevealed, "Answer reveal must reset on next question")
        XCTAssertTrue(vm.selectedOptionIds.isEmpty, "Selection must clear on next question")
    }

    func test_nextQuestion_onLast_completesExam() async {
        mockRepo.completeExamResult = ExamSessionDTO(
            id: session.id, userId: UUID(), certificationId: "java21",
            mode: "EXAM", status: "COMPLETED",
            startedAt: ISO8601DateFormatter().string(from: Date()),
            endedAt: ISO8601DateFormatter().string(from: Date()),
            totalQuestions: 2, correctAnswers: 2,
            score: 100.0, passed: true,
            questions: nil, themeStats: nil
        )

        let vm = ExamEngineViewModel(session: session, examRepository: mockRepo)
        // Go to last question
        vm.currentIndex = 1

        let optionId = session.questions![1].options.first!.id
        vm.toggleOption(optionId)
        await vm.submitAnswer()
        vm.nextQuestion()

        // Wait for async complete
        try? await Task.sleep(for: .milliseconds(100))
        XCTAssertEqual(mockRepo.completeExamCallCount, 1)
    }

    // MARK: - Progress

    func test_progress_calculatedCorrectly() {
        let vm = ExamEngineViewModel(session: session, examRepository: mockRepo)
        XCTAssertEqual(vm.progress, 0.0)
        vm.currentIndex = 1
        XCTAssertEqual(vm.progress, 0.5, accuracy: 0.01)
    }
}

// MARK: - HomeViewModelTests

@MainActor
final class HomeViewModelTests: XCTestCase {

    private var mockCertRepo: MockCertificationRepository!
    private var mockAuthService: AuthService!

    override func setUp() {
        super.setUp()
        mockCertRepo = MockCertificationRepository()
        // AuthService with no keychain — unauthenticated
        mockAuthService = AuthService(
            keychainService: KeychainService(),
            apiClient: APIClient(keychainService: KeychainService())
        )
    }

    func test_loadCertifications_success_populatesList() async {
        mockCertRepo.certifications = [
            CertificationDTO(id: "java21", code: "1Z0-830", name: "Java 21",
                             description: "Java 21 cert", totalQuestions: 300,
                             passingScore: 68, examDurationMinutes: 90,
                             examType: "MCQ", themes: nil),
            CertificationDTO(id: "aws", code: "SAA-C03", name: "AWS SAA",
                             description: "AWS cert", totalQuestions: 65,
                             passingScore: 72, examDurationMinutes: 130,
                             examType: "MCQ", themes: nil)
        ]

        let vm = HomeViewModel(
            certificationRepository: mockCertRepo,
            authService: mockAuthService
        )
        await vm.loadCertifications()

        XCTAssertEqual(vm.certifications.count, 2)
        XCTAssertFalse(vm.isLoading)
        XCTAssertNil(vm.errorMessage)
    }

    func test_loadCertifications_networkError_setsErrorMessage() async {
        mockCertRepo.fetchAllError = APIError.networkError(underlying: URLError(.notConnectedToInternet))

        let vm = HomeViewModel(
            certificationRepository: mockCertRepo,
            authService: mockAuthService
        )
        await vm.loadCertifications()

        XCTAssertFalse(vm.isLoading)
        XCTAssertNotNil(vm.errorMessage)
    }

    func test_searchFilter_filtersCorrectly() async {
        mockCertRepo.certifications = [
            CertificationDTO(id: "java21", code: "1Z0-830", name: "Java 21",
                             description: "", totalQuestions: 300, passingScore: 68,
                             examDurationMinutes: 90, examType: "MCQ", themes: nil),
            CertificationDTO(id: "aws", code: "SAA-C03", name: "AWS Solutions Architect",
                             description: "", totalQuestions: 65, passingScore: 72,
                             examDurationMinutes: 130, examType: "MCQ", themes: nil)
        ]

        let vm = HomeViewModel(
            certificationRepository: mockCertRepo,
            authService: mockAuthService
        )
        await vm.loadCertifications()

        vm.searchQuery = "Java"
        XCTAssertEqual(vm.filteredCertifications.count, 1)
        XCTAssertEqual(vm.filteredCertifications.first?.id, "java21")
    }

    func test_searchFilter_empty_returnsAll() async {
        mockCertRepo.certifications = [
            CertificationDTO(id: "java21", code: "1Z0-830", name: "Java 21",
                             description: "", totalQuestions: 300, passingScore: 68,
                             examDurationMinutes: 90, examType: "MCQ", themes: nil)
        ]

        let vm = HomeViewModel(
            certificationRepository: mockCertRepo,
            authService: mockAuthService
        )
        await vm.loadCertifications()
        vm.searchQuery = ""

        XCTAssertEqual(vm.filteredCertifications.count, 1)
    }
}
