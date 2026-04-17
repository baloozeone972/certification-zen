// certif-ios/CertifApp/Domain/Port/RepositoryProtocols.swift
//
// Repository protocol definitions — iOS equivalent of Java port/output interfaces.
// Depend only on DTOs and Foundation. No UIKit/SwiftUI.

import Foundation

// MARK: - Certification

protocol CertificationRepositoryProtocol: AnyObject {
    func fetchAll() async throws -> [CertificationDTO]
    func fetchById(_ id: String) async throws -> CertificationDTO
}

// MARK: - Exam

protocol ExamRepositoryProtocol: AnyObject {
    func startExam(_ request: StartExamRequestDTO) async throws -> ExamSessionDTO
    func submitAnswer(_ request: SubmitAnswerRequestDTO) async throws -> AnswerResultDTO
    func completeExam(sessionId: UUID) async throws -> ExamSessionDTO
    func fetchHistory(userId: UUID, page: Int, size: Int) async throws -> PageResponse<ExamSessionSummaryDTO>
    func fetchSession(id: UUID) async throws -> ExamSessionDTO
}

// MARK: - Learning

protocol LearningRepositoryProtocol: AnyObject {
    func fetchCourse(certificationId: String, themeCode: String) async throws -> CourseDTO
    func fetchFlashcards(certificationId: String, limit: Int) async throws -> [FlashcardDTO]
    func reviewFlashcard(id: UUID, rating: Int) async throws -> SM2ProgressDTO
    func fetchAdaptivePlan(certificationId: String) async throws -> AdaptivePlanDTO
}

// MARK: - User

protocol UserRepositoryProtocol: AnyObject {
    func login(email: String, password: String) async throws -> TokenPairDTO
    func register(email: String, password: String, locale: String, timezone: String) async throws -> UserDTO
    func fetchCurrentUser() async throws -> UserDTO
    func updatePreferences(_ request: UpdatePreferencesRequestDTO) async throws -> UserPreferencesDTO
    func logout()
}

// MARK: - Community

protocol CommunityRepositoryProtocol: AnyObject {
    func fetchCurrentChallenge(certificationId: String) async throws -> WeeklyChallengeDTO
    func fetchCertifiedWall(page: Int, size: Int) async throws -> PageResponse<CertifiedWallProfileDTO>
    func publishCertifiedProfile(_ request: PublishCertifiedProfileRequestDTO) async throws -> CertifiedWallProfileDTO
}

// MARK: - Coaching

protocol CoachingRepositoryProtocol: AnyObject {
    func fetchDiagnostic(certificationId: String) async throws -> DiagnosticResultDTO
    func fetchWeeklyReport() async throws -> WeeklyCoachReportDTO
    func fetchJobMarket(certificationId: String, country: String) async throws -> JobMarketDTO
}

// MARK: - AI

protocol AIRepositoryProtocol: AnyObject {
    func sendChatMessage(_ request: SendChatMessageRequestDTO) async throws -> ChatResponseDTO
    func explainQuestion(questionId: UUID) async throws -> String
    func generateFlashcards(certificationId: String, themeCode: String) async throws -> [FlashcardDTO]
}

// MARK: - Payment

protocol PaymentRepositoryProtocol: AnyObject {
    func fetchSubscriptionStatus() async throws -> SubscriptionStatusDTO
    func validateAppleReceipt(_ request: AppleReceiptValidationRequestDTO) async throws -> SubscriptionStatusDTO
}

// ===========================================================================
// MARK: - SM-2 Calculator (pure domain logic)
// ===========================================================================
// Swift port of Java SM2Algorithm.java in certif-domain.
// No dependencies — pure computation.

/// Implements the SuperMemo SM-2 spaced repetition algorithm.
enum SM2Calculator {

    /// Computes next interval and ease factor after a review.
    /// - Parameters:
    ///   - rating:      Review quality 0–5 (0=blackout, 5=perfect)
    ///   - easeFactor:  Current ease factor (default 2.5)
    ///   - intervalDays: Current interval in days
    ///   - repetitions: Number of successful repetitions so far
    /// - Returns: Tuple (newIntervalDays, newEaseFactor)
    static func calculate(
        rating: Int,
        easeFactor: Double,
        intervalDays: Int,
        repetitions: Int
    ) -> (newInterval: Int, newEaseFactor: Double) {
        guard rating >= 0, rating <= 5 else {
            return (1, max(1.3, easeFactor - 0.2))
        }

        // Failed recall: reset
        if rating < 3 {
            return (1, max(1.3, easeFactor - 0.2))
        }

        // Compute new ease factor: EF' = EF + (0.1 - (5-q)*(0.08+(5-q)*0.02))
        let q = Double(rating)
        let newEase = max(1.3, easeFactor + 0.1 - (5.0 - q) * (0.08 + (5.0 - q) * 0.02))

        // Compute new interval
        let newInterval: Int
        switch repetitions {
        case 0:  newInterval = 1
        case 1:  newInterval = 6
        default: newInterval = Int((Double(intervalDays) * newEase).rounded())
        }

        return (newInterval, newEase)
    }
}

// ===========================================================================
// MARK: - FreemiumGuard (domain rule — mirrors Java FreemiumGuardService)
// ===========================================================================

/// Enforces freemium limits client-side for fast UX feedback.
/// Server-side enforcement is the source of truth.
enum FreemiumGuard {

    static let freeExamsPerCertification = 2
    static let freeQuestionsPerExam = 20

    /// Returns true if the user can start an exam given their session history.
    static func canStartExam(tier: AppUser.SubscriptionTier, examCountForCertification: Int) -> Bool {
        if tier.isProOrPack { return true }
        return examCountForCertification < freeExamsPerCertification
    }

    /// Returns the max question count for an exam given the user's tier.
    static func maxQuestions(tier: AppUser.SubscriptionTier, requested: Int) -> Int {
        if tier.isProOrPack { return requested }
        return min(requested, freeQuestionsPerExam)
    }
}
