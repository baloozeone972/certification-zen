// certif-ios/CertifApp/Data/Repository/CertificationRepository.swift
//
// Repository with online/offline fallback — mirrors Android CertificationRepository.kt.
// Strategy: fetch from API, persist to SwiftData, return cache on network failure.

import Foundation
import SwiftData

/// Concrete implementation of CertificationRepositoryProtocol.
/// Online-first with SwiftData fallback when offline.
final class CertificationRepository: CertificationRepositoryProtocol {

    private let apiClient: APIClient
    private let modelContext: ModelContext

    init(apiClient: APIClient, modelContext: ModelContext) {
        self.apiClient = apiClient
        self.modelContext = modelContext
    }

    func fetchAll() async throws -> [CertificationDTO] {
        do {
            let dtos: [CertificationDTO] = try await apiClient.request(
                .get("/api/v1/certifications")
            )
            // Update SwiftData cache
            await persistCertifications(dtos)
            return dtos
        } catch APIError.networkError {
            return fetchCachedCertifications()
        }
    }

    func fetchById(_ id: String) async throws -> CertificationDTO {
        let dtos: [CertificationDTO] = try await apiClient.request(
            .get("/api/v1/certifications/\(id)")
        )
        // Single-item endpoint returns array per API contract
        guard let dto = dtos.first else {
            throw APIError.notFound
        }
        return dto
    }

    // MARK: - Cache helpers

    @MainActor
    private func persistCertifications(_ dtos: [CertificationDTO]) {
        for dto in dtos {
            let descriptor = FetchDescriptor<CertificationEntity>(
                predicate: #Predicate { $0.id == dto.id }
            )
            if let existing = try? modelContext.fetch(descriptor).first {
                existing.name = dto.name
                existing.syncedAt = Date()
            } else {
                modelContext.insert(CertificationEntity(from: dto))
            }
        }
        try? modelContext.save()
    }

    private func fetchCachedCertifications() -> [CertificationDTO] {
        let descriptor = FetchDescriptor<CertificationEntity>(
            sortBy: [SortDescriptor(\.name)]
        )
        let entities = (try? modelContext.fetch(descriptor)) ?? []
        return entities.map { entity in
            CertificationDTO(
                id: entity.id,
                code: entity.code,
                name: entity.name,
                description: entity.certificationDescription,
                totalQuestions: entity.totalQuestions,
                passingScore: entity.passingScore,
                examDurationMinutes: entity.examDurationMinutes,
                examType: entity.examType,
                themes: nil
            )
        }
    }
}

// MARK: - ExamRepository

/// Handles exam session lifecycle with offline queue support.
final class ExamRepository: ExamRepositoryProtocol {

    private let apiClient: APIClient
    private let modelContext: ModelContext

    init(apiClient: APIClient, modelContext: ModelContext) {
        self.apiClient = apiClient
        self.modelContext = modelContext
    }

    func startExam(_ request: StartExamRequestDTO) async throws -> ExamSessionDTO {
        try await apiClient.request(.post("/api/v1/exams/start", body: request))
    }

    func submitAnswer(_ request: SubmitAnswerRequestDTO) async throws -> AnswerResultDTO {
        do {
            return try await apiClient.request(
                .post("/api/v1/exams/\(request.sessionId)/answers", body: request)
            )
        } catch APIError.networkError {
            // Queue for later sync
            let pending = PendingSyncEntity(type: "SUBMIT_ANSWER", payload: request)
            modelContext.insert(pending)
            try? modelContext.save()
            // Return optimistic result (isCorrect unknown offline)
            return AnswerResultDTO(
                questionId: request.questionId,
                isCorrect: false,
                explanation: "Résultat disponible après reconnexion",
                correctOptionIds: []
            )
        }
    }

    func completeExam(sessionId: UUID) async throws -> ExamSessionDTO {
        try await apiClient.request(
            .post("/api/v1/exams/\(sessionId)/complete", body: EmptyBody())
        )
    }

    func fetchHistory(userId: UUID, page: Int, size: Int) async throws -> PageResponse<ExamSessionSummaryDTO> {
        try await apiClient.request(
            .get("/api/v1/exams/history", query: [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "size", value: "\(size)")
            ])
        )
    }

    func fetchSession(id: UUID) async throws -> ExamSessionDTO {
        try await apiClient.request(.get("/api/v1/exams/\(id)"))
    }
}

// MARK: - LearningRepository

final class LearningRepository: LearningRepositoryProtocol {

    private let apiClient: APIClient
    private let modelContext: ModelContext

    init(apiClient: APIClient, modelContext: ModelContext) {
        self.apiClient = apiClient
        self.modelContext = modelContext
    }

    func fetchCourse(certificationId: String, themeCode: String) async throws -> CourseDTO {
        try await apiClient.request(
            .get("/api/v1/learning/courses/\(certificationId)/\(themeCode)")
        )
    }

    func fetchFlashcards(certificationId: String, limit: Int) async throws -> [FlashcardDTO] {
        do {
            let dtos: [FlashcardDTO] = try await apiClient.request(
                .get("/api/v1/learning/flashcards/\(certificationId)/due",
                     query: [URLQueryItem(name: "limit", value: "\(limit)")])
            )
            await persistFlashcards(dtos, certificationId: certificationId)
            return dtos
        } catch APIError.networkError {
            return fetchCachedFlashcards(certificationId: certificationId)
        }
    }

    func reviewFlashcard(id: UUID, rating: Int) async throws -> SM2ProgressDTO {
        do {
            return try await apiClient.request(
                .post("/api/v1/learning/flashcards/\(id)/review",
                      body: ReviewFlashcardRequestDTO(rating: rating))
            )
        } catch APIError.networkError {
            return applyLocalSM2(flashcardId: id, rating: rating)
        }
    }

    func fetchAdaptivePlan(certificationId: String) async throws -> AdaptivePlanDTO {
        try await apiClient.request(
            .get("/api/v1/learning/adaptive-plan/\(certificationId)")
        )
    }

    // MARK: - Offline helpers

    @MainActor
    private func persistFlashcards(_ dtos: [FlashcardDTO], certificationId: String) {
        for dto in dtos {
            let descriptor = FetchDescriptor<FlashcardEntity>(
                predicate: #Predicate { $0.id == dto.id }
            )
            guard (try? modelContext.fetch(descriptor).first) == nil else { continue }
            modelContext.insert(FlashcardEntity(from: dto, certificationId: certificationId))
        }
        try? modelContext.save()
    }

    private func fetchCachedFlashcards(certificationId: String) -> [FlashcardDTO] {
        let descriptor = FetchDescriptor<FlashcardEntity>(
            predicate: #Predicate { $0.certificationId == certificationId }
        )
        return ((try? modelContext.fetch(descriptor)) ?? []).map { entity in
            FlashcardDTO(
                id: entity.id,
                questionId: nil,
                courseId: nil,
                frontText: entity.frontText,
                backText: entity.backText,
                codeExample: entity.codeExample,
                aiGenerated: entity.aiGenerated
            )
        }
    }

    private func applyLocalSM2(flashcardId: UUID, rating: Int) -> SM2ProgressDTO {
        let descriptor = FetchDescriptor<SM2ScheduleEntity>(
            predicate: #Predicate { $0.flashcardId == flashcardId }
        )
        let entity: SM2ScheduleEntity
        if let existing = (try? modelContext.fetch(descriptor))?.first {
            entity = existing
        } else {
            entity = SM2ScheduleEntity(flashcardId: flashcardId)
            modelContext.insert(entity)
        }
        // SM-2 algorithm (same as Java SM2Algorithm.java)
        let (newInterval, newEase) = SM2Calculator.calculate(
            rating: rating,
            easeFactor: entity.easeFactor,
            intervalDays: entity.intervalDays,
            repetitions: entity.repetitions
        )
        entity.intervalDays = newInterval
        entity.easeFactor = newEase
        entity.repetitions += 1
        entity.dueDate = Calendar.current.date(byAdding: .day, value: newInterval, to: Date()) ?? Date()
        entity.lastReviewedAt = Date()
        entity.isDirty = true
        try? modelContext.save()

        let iso = ISO8601DateFormatter()
        return SM2ProgressDTO(
            flashcardId: flashcardId,
            nextReviewDate: iso.string(from: entity.dueDate),
            intervalDays: newInterval,
            easeFactor: newEase,
            repetitions: entity.repetitions
        )
    }
}

// MARK: - UserRepository

final class UserRepository: UserRepositoryProtocol {

    private let apiClient: APIClient
    private let keychainService: KeychainService

    init(apiClient: APIClient, keychainService: KeychainService) {
        self.apiClient = apiClient
        self.keychainService = keychainService
    }

    func login(email: String, password: String) async throws -> TokenPairDTO {
        let tokens: TokenPairDTO = try await apiClient.request(
            .post("/api/v1/auth/login", body: LoginRequestDTO(email: email, password: password))
        )
        keychainService.save(accessToken: tokens.accessToken, refreshToken: tokens.refreshToken)
        return tokens
    }

    func register(email: String, password: String, locale: String, timezone: String) async throws -> UserDTO {
        let dto: UserDTO = try await apiClient.request(
            .post("/api/v1/auth/register", body: RegisterRequestDTO(
                email: email, password: password, locale: locale, timezone: timezone
            ))
        )
        keychainService.save(userId: dto.id)
        return dto
    }

    func fetchCurrentUser() async throws -> UserDTO {
        try await apiClient.request(.get("/api/v1/users/me"))
    }

    func updatePreferences(_ request: UpdatePreferencesRequestDTO) async throws -> UserPreferencesDTO {
        try await apiClient.request(.put("/api/v1/users/me/preferences", body: request))
    }

    func logout() {
        keychainService.clearTokens()
    }
}

// MARK: - CommunityRepository

final class CommunityRepository: CommunityRepositoryProtocol {

    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchCurrentChallenge(certificationId: String) async throws -> WeeklyChallengeDTO {
        try await apiClient.request(
            .get("/api/v1/community/challenges/current/\(certificationId)")
        )
    }

    func fetchCertifiedWall(page: Int, size: Int) async throws -> PageResponse<CertifiedWallProfileDTO> {
        try await apiClient.request(
            .get("/api/v1/community/wall", query: [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "size", value: "\(size)")
            ])
        )
    }

    func publishCertifiedProfile(_ request: PublishCertifiedProfileRequestDTO) async throws -> CertifiedWallProfileDTO {
        try await apiClient.request(.post("/api/v1/community/wall", body: request))
    }
}

// MARK: - CoachingRepository

final class CoachingRepository: CoachingRepositoryProtocol {

    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchDiagnostic(certificationId: String) async throws -> DiagnosticResultDTO {
        try await apiClient.request(
            .get("/api/v1/coaching/diagnostic/\(certificationId)")
        )
    }

    func fetchWeeklyReport() async throws -> WeeklyCoachReportDTO {
        try await apiClient.request(.get("/api/v1/coaching/report/weekly"))
    }

    func fetchJobMarket(certificationId: String, country: String) async throws -> JobMarketDTO {
        try await apiClient.request(
            .get("/api/v1/coaching/job-market", query: [
                URLQueryItem(name: "certificationId", value: certificationId),
                URLQueryItem(name: "country", value: country)
            ])
        )
    }
}

// MARK: - AIRepository

final class AIRepository: AIRepositoryProtocol {

    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func sendChatMessage(_ request: SendChatMessageRequestDTO) async throws -> ChatResponseDTO {
        try await apiClient.request(.post("/api/v1/ai/chat", body: request))
    }

    func explainQuestion(questionId: UUID) async throws -> String {
        let response: ExplainResponseDTO = try await apiClient.request(
            .get("/api/v1/ai/explain/\(questionId)")
        )
        return response.explanation
    }

    func generateFlashcards(certificationId: String, themeCode: String) async throws -> [FlashcardDTO] {
        try await apiClient.request(
            .post("/api/v1/ai/flashcards/generate",
                  body: GenerateFlashcardsRequestDTO(
                    certificationId: certificationId,
                    themeCode: themeCode
                  ))
        )
    }
}

// MARK: - PaymentRepository

final class PaymentRepository: PaymentRepositoryProtocol {

    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchSubscriptionStatus() async throws -> SubscriptionStatusDTO {
        try await apiClient.request(.get("/api/v1/payments/subscription/status"))
    }

    func validateAppleReceipt(_ request: AppleReceiptValidationRequestDTO) async throws -> SubscriptionStatusDTO {
        try await apiClient.request(.post("/api/v1/payments/apple/validate", body: request))
    }
}

// MARK: - Supporting types

private struct EmptyBody: Encodable {}

private struct ExplainResponseDTO: Decodable {
    let explanation: String
}

private struct GenerateFlashcardsRequestDTO: Encodable {
    let certificationId: String
    let themeCode: String
}
