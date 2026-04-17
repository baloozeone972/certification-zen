// certif-ios/CertifApp/Domain/Models/DomainModels.swift
//
// Domain models — value types (structs) mapped from DTOs.
// Equivalent of Java Records in certif-domain module.
// No framework dependencies — pure Swift.

import Foundation

// MARK: - Certification

struct Certification: Identifiable, Hashable {
    let id: String
    let code: String
    let name: String
    let description: String
    let totalQuestions: Int
    let passingScore: Int
    let examDurationMinutes: Int
    let examType: ExamType
    let themes: [CertificationTheme]

    enum ExamType: String {
        case mcq = "MCQ"
        case practical = "PRACTICAL"
    }
}

struct CertificationTheme: Identifiable, Hashable {
    let id: UUID
    let code: String
    let label: String
    let questionCount: Int
    let displayOrder: Int
}

// MARK: - Question

struct Question: Identifiable, Hashable {
    let id: UUID
    let certificationId: String
    let themeCode: String
    let statement: String
    let options: [QuestionOption]
    let explanation: String
    let difficultyLevel: DifficultyLevel
    let questionType: QuestionType
    let tags: [String]
    let codeExample: String?

    enum DifficultyLevel: String {
        case easy = "EASY"
        case medium = "MEDIUM"
        case hard = "HARD"
    }

    enum QuestionType: String {
        case singleChoice = "SINGLE_CHOICE"
        case multipleChoice = "MULTIPLE_CHOICE"
    }
}

struct QuestionOption: Identifiable, Hashable {
    let id: UUID
    let label: String
    let text: String
    let isCorrect: Bool
}

// MARK: - Exam

struct ExamSession: Identifiable {
    let id: UUID
    let certificationId: String
    let mode: ExamMode
    var status: SessionStatus
    let startedAt: Date
    var endedAt: Date?
    var totalQuestions: Int
    var correctAnswers: Int
    var score: Double?
    var passed: Bool?
    let questions: [Question]
    var themeStats: [ThemeStats]

    enum ExamMode: String {
        case exam = "EXAM"
        case free = "FREE"
        case revision = "REVISION"
    }

    enum SessionStatus: String {
        case inProgress = "IN_PROGRESS"
        case completed = "COMPLETED"
        case abandoned = "ABANDONED"
        case expired = "EXPIRED"
    }
}

struct ThemeStats: Identifiable {
    let id = UUID()
    let themeCode: String
    let themeLabel: String
    let correct: Int
    let wrong: Int
    let skipped: Int
    let total: Int

    var percentage: Double {
        guard total > 0 else { return 0 }
        return Double(correct) / Double(total) * 100
    }
}

// MARK: - User

struct AppUser: Identifiable {
    let id: UUID
    let email: String
    let role: UserRole
    let subscriptionTier: SubscriptionTier
    let locale: String
    let timezone: String
    let isActive: Bool

    enum UserRole: String {
        case user = "USER"
        case admin = "ADMIN"
        case partner = "PARTNER"
    }

    enum SubscriptionTier: String {
        case free = "FREE"
        case pro = "PRO"
        case pack = "PACK"

        var displayName: String {
            switch self {
            case .free:  return "Gratuit"
            case .pro:   return "Pro – 9,99 €/mois"
            case .pack:  return "Pack Certification – 4,99 €"
            }
        }

        var isProOrPack: Bool { self == .pro || self == .pack }
    }
}

// MARK: - Flashcard

struct Flashcard: Identifiable, Hashable {
    let id: UUID
    let frontText: String
    let backText: String
    let codeExample: String?
    let aiGenerated: Bool
}

// MARK: - SM-2 Schedule

struct SM2Schedule {
    let flashcardId: UUID
    var easeFactor: Double
    var intervalDays: Int
    var repetitions: Int
    var dueDate: Date
    var lastReviewedAt: Date?
}
