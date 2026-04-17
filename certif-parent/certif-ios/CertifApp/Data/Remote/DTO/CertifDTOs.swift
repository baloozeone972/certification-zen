// certif-ios/CertifApp/Data/Remote/DTO/CertifDTOs.swift
//
// Data Transfer Objects — miroirs exacts des DTOs Java (certif-api-rest).
// Tous les types sont Codable pour la sérialisation JSON URLSession.

import Foundation

// MARK: - Generic API Response

/// Generic paginated API response wrapper.
struct PageResponse<T: Codable>: Codable {
    let content: [T]
    let totalElements: Int
    let totalPages: Int
    let number: Int
    let size: Int
}

/// Generic single-object API response wrapper.
struct ApiResponse<T: Codable>: Codable {
    let data: T
    let message: String?
}

// MARK: - Auth DTOs

struct LoginRequestDTO: Encodable {
    let email: String
    let password: String
}

struct RegisterRequestDTO: Encodable {
    let email: String
    let password: String
    let locale: String
    let timezone: String
}

struct TokenPairDTO: Decodable {
    let accessToken: String
    let refreshToken: String
    let expiresIn: Int
}

// MARK: - User DTOs

struct UserDTO: Codable, Identifiable {
    let id: UUID
    let email: String
    let role: String
    let subscriptionTier: String
    let locale: String
    let timezone: String
    let stripeCustomerId: String?
    let isActive: Bool
    let createdAt: String
}

struct UserPreferencesDTO: Codable {
    let userId: UUID
    let theme: String
    let language: String
    let defaultMode: String
    let notificationsEnabled: Bool
    let lastCertificationId: String?
    let freeModeQuestionCount: Int
    let freeModeQuestionDurationMin: Int
}

struct UpdatePreferencesRequestDTO: Encodable {
    let theme: String?
    let language: String?
    let defaultMode: String?
    let notificationsEnabled: Bool?
    let lastCertificationId: String?
}

// MARK: - Certification DTOs

struct CertificationDTO: Codable, Identifiable {
    let id: String
    let code: String
    let name: String
    let description: String
    let totalQuestions: Int
    let passingScore: Int
    let examDurationMinutes: Int
    let examType: String
    let themes: [CertificationThemeDTO]?
}

struct CertificationThemeDTO: Codable, Identifiable {
    let id: UUID
    let code: String
    let label: String
    let questionCount: Int
    let displayOrder: Int
}

// MARK: - Question DTOs

struct QuestionDTO: Codable, Identifiable {
    let id: UUID
    let certificationId: String
    let themeCode: String
    let statement: String
    let options: [QuestionOptionDTO]
    let explanation: String
    let difficultyLevel: String
    let questionType: String
    let tags: [String]
    let codeExample: String?
}

struct QuestionOptionDTO: Codable, Identifiable {
    let id: UUID
    let label: String
    let text: String
    let isCorrect: Bool
}

// MARK: - Exam DTOs

struct StartExamRequestDTO: Encodable {
    let certificationId: String
    let mode: String
    let themeCode: String?
    let questionCount: Int?
    let durationMinutes: Int?
}

struct ExamSessionDTO: Codable, Identifiable {
    let id: UUID
    let userId: UUID
    let certificationId: String
    let mode: String
    let status: String
    let startedAt: String
    let endedAt: String?
    let totalQuestions: Int
    let correctAnswers: Int
    let score: Double?
    let passed: Bool?
    let questions: [QuestionDTO]?
    let themeStats: [ThemeStatsDTO]?
}

struct SubmitAnswerRequestDTO: Encodable {
    let sessionId: UUID
    let questionId: UUID
    let selectedOptionIds: [UUID]
    let timeSpentSeconds: Int
}

struct AnswerResultDTO: Decodable {
    let questionId: UUID
    let isCorrect: Bool
    let explanation: String
    let correctOptionIds: [UUID]
}

struct ThemeStatsDTO: Codable {
    let themeCode: String
    let themeLabel: String
    let correct: Int
    let wrong: Int
    let skipped: Int
    let total: Int
    let percentage: Double
}

struct ExamSessionSummaryDTO: Codable, Identifiable {
    let id: UUID
    let certificationId: String
    let certificationName: String
    let mode: String
    let status: String
    let score: Double?
    let passed: Bool?
    let startedAt: String
    let endedAt: String?
    let totalQuestions: Int
    let correctAnswers: Int
}

// MARK: - Learning DTOs

struct CourseDTO: Codable, Identifiable {
    let id: UUID
    let certificationId: String
    let themeCode: String
    let title: String
    let contentMarkdown: String
    let contentHtml: String
    let version: Int
}

struct FlashcardDTO: Codable, Identifiable {
    let id: UUID
    let questionId: UUID?
    let courseId: UUID?
    let frontText: String
    let backText: String
    let codeExample: String?
    let aiGenerated: Bool
}

struct SM2ProgressDTO: Codable {
    let flashcardId: UUID
    let nextReviewDate: String
    let intervalDays: Int
    let easeFactor: Double
    let repetitions: Int
}

struct ReviewFlashcardRequestDTO: Encodable {
    let rating: Int  // 0=blackout … 5=perfect (SM-2)
}

struct AdaptivePlanDTO: Codable {
    let userId: UUID
    let certificationId: String
    let predictedScore: Double
    let readinessLevel: String
    let todaySessions: [PlanSessionDTO]
    let weakThemes: [String]
    let estimatedReadyDate: String?
}

struct PlanSessionDTO: Codable, Identifiable {
    let id: UUID
    let type: String
    let themeCode: String
    let themeLabel: String
    let durationMinutes: Int
    let priority: Int
}

// MARK: - Community DTOs

struct WeeklyChallengeDTO: Codable, Identifiable {
    let id: UUID
    let certificationId: String
    let themeCode: String
    let title: String
    let description: String
    let startsAt: String
    let endsAt: String
    let participantCount: Int
    let userRank: Int?
    let userScore: Double?
    let leaderboard: [LeaderboardEntryDTO]?
}

struct LeaderboardEntryDTO: Codable, Identifiable {
    let id: UUID
    let username: String
    let score: Double
    let rank: Int
    let country: String?
}

struct CertifiedWallProfileDTO: Codable, Identifiable {
    let id: UUID
    let username: String
    let certificationId: String
    let certificationName: String
    let certifiedAt: String
    let prepDurationWeeks: Int?
    let testimonial: String?
    let country: String?
    let linkedinUrl: String?
}

struct PublishCertifiedProfileRequestDTO: Encodable {
    let certificationId: String
    let certifiedAt: String
    let prepDurationWeeks: Int?
    let testimonial: String?
    let country: String?
    let linkedinUrl: String?
    let isPublic: Bool
}

// MARK: - Coaching DTOs

struct DiagnosticResultDTO: Codable {
    let certificationId: String
    let predictedScore: Double
    let readinessLevel: String
    let strongThemes: [String]
    let weakThemes: [String]
    let recommendedPath: String
}

struct WeeklyCoachReportDTO: Codable {
    let userId: UUID
    let weekNumber: Int
    let totalStudyMinutes: Int
    let sessionsCompleted: Int
    let averageScore: Double
    let progressDelta: Double
    let alertMessages: [String]
    let certificationReports: [CertificationReportDTO]
}

struct CertificationReportDTO: Codable, Identifiable {
    let id: String
    let certificationId: String
    let certificationName: String
    let currentScore: Double
    let progressDelta: Double
    let weakThemes: [String]
    let nextMilestone: String?
}

struct JobMarketDTO: Codable {
    let certificationId: String
    let country: String
    let averageSalary: Double
    let currency: String
    let jobPostingsCount: Int
    let topEmployers: [String]
    let salaryRange: SalaryRangeDTO
    let updatedAt: String
}

struct SalaryRangeDTO: Codable {
    let min: Double
    let max: Double
    let median: Double
}

// MARK: - Interview DTOs

struct StartInterviewRequestDTO: Encodable {
    let certificationId: String
    let mode: String
    let domain: String?
}

struct InterviewSessionDTO: Codable, Identifiable {
    let id: UUID
    let certificationId: String
    let mode: String
    let startedAt: String
    let endedAt: String?
    let overallFeedback: String?
    let scoreByDomain: [String: Double]?
}

struct InterviewQuestionDTO: Codable {
    let questionText: String
    let domain: String
    let hints: [String]?
}

struct SubmitInterviewAnswerRequestDTO: Encodable {
    let sessionId: UUID
    let questionText: String
    let userAnswer: String
    let domain: String
}

struct InterviewFeedbackDTO: Codable {
    let score: Int
    let feedback: String
    let improvedAnswer: String?
    let nextQuestion: InterviewQuestionDTO?
}

// MARK: - AI Chat DTOs

struct ChatMessageDTO: Codable, Identifiable {
    let id: UUID
    let role: String   // "user" | "assistant"
    let content: String
    let timestamp: String
}

struct SendChatMessageRequestDTO: Encodable {
    let message: String
    let certificationId: String?
    let contextType: String?
}

struct ChatResponseDTO: Codable {
    let message: ChatMessageDTO
    let suggestedFollowUps: [String]?
}

// MARK: - Payment DTOs

struct SubscriptionStatusDTO: Codable {
    let tier: String
    let isActive: Bool
    let currentPeriodEnd: String?
    let cancelAtPeriodEnd: Bool
    let productId: String?
}

struct AppleReceiptValidationRequestDTO: Encodable {
    let receiptData: String
    let productId: String
    let transactionId: String
}

// MARK: - Notification DTOs

struct NotificationDTO: Codable, Identifiable {
    let id: UUID
    let type: String
    let title: String
    let body: String?
    let actionUrl: String?
    let readAt: String?
    let createdAt: String
}
