// certif-ios/CertifApp/Data/Local/SwiftDataEntities.swift
//
// SwiftData @Model entities — iOS equivalent of Android Room @Entity.
// Stored locally for full offline support (iOS 17+ SwiftData).
// Justification: SwiftData est le standard Apple iOS 17+ et remplace CoreData
// avec une API Swift-native, sans boilerplate XML.

import SwiftData
import Foundation

// MARK: - CertificationEntity

/// Local cache of certification metadata.
@Model
final class CertificationEntity {
    @Attribute(.unique) var id: String
    var code: String
    var name: String
    var certificationDescription: String
    var totalQuestions: Int
    var passingScore: Int
    var examDurationMinutes: Int
    var examType: String
    var syncedAt: Date

    init(from dto: CertificationDTO) {
        self.id = dto.id
        self.code = dto.code
        self.name = dto.name
        self.certificationDescription = dto.description
        self.totalQuestions = dto.totalQuestions
        self.passingScore = dto.passingScore
        self.examDurationMinutes = dto.examDurationMinutes
        self.examType = dto.examType
        self.syncedAt = Date()
    }
}

// MARK: - QuestionEntity

/// Downloaded question for offline exam mode.
@Model
final class QuestionEntity {
    @Attribute(.unique) var id: UUID
    var certificationId: String
    var themeCode: String
    var statement: String
    var optionsJson: Data            // Encoded [QuestionOptionDTO]
    var explanation: String
    var difficultyLevel: String
    var questionType: String
    var tagsJson: Data               // Encoded [String]
    var codeExample: String?
    var syncedAt: Date

    init(from dto: QuestionDTO, encoder: JSONEncoder = JSONEncoder()) {
        self.id = dto.id
        self.certificationId = dto.certificationId
        self.themeCode = dto.themeCode
        self.statement = dto.statement
        self.explanation = dto.explanation
        self.difficultyLevel = dto.difficultyLevel
        self.questionType = dto.questionType
        self.codeExample = dto.codeExample
        self.syncedAt = Date()
        self.optionsJson = (try? encoder.encode(dto.options)) ?? Data()
        self.tagsJson = (try? encoder.encode(dto.tags)) ?? Data()
    }

    /// Decodes options from JSON storage.
    func decodedOptions(decoder: JSONDecoder = JSONDecoder()) -> [QuestionOptionDTO] {
        (try? decoder.decode([QuestionOptionDTO].self, from: optionsJson)) ?? []
    }

    /// Decodes tags from JSON storage.
    func decodedTags(decoder: JSONDecoder = JSONDecoder()) -> [String] {
        (try? decoder.decode([String].self, from: tagsJson)) ?? []
    }
}

// MARK: - ExamSessionEntity

/// Locally stored exam session, awaiting sync to the backend.
@Model
final class ExamSessionEntity {
    @Attribute(.unique) var id: UUID
    var certificationId: String
    var mode: String
    var status: String
    var startedAt: Date
    var endedAt: Date?
    var answersJson: Data            // Encoded [LocalAnswer]
    var totalQuestions: Int
    var correctAnswers: Int
    var score: Double?
    var isSynced: Bool

    init(id: UUID = UUID(),
         certificationId: String,
         mode: String,
         totalQuestions: Int) {
        self.id = id
        self.certificationId = certificationId
        self.mode = mode
        self.status = "IN_PROGRESS"
        self.startedAt = Date()
        self.answersJson = Data()
        self.totalQuestions = totalQuestions
        self.correctAnswers = 0
        self.isSynced = false
    }
}

// MARK: - FlashcardEntity

/// Downloaded flashcard for offline review.
@Model
final class FlashcardEntity {
    @Attribute(.unique) var id: UUID
    var certificationId: String
    var frontText: String
    var backText: String
    var codeExample: String?
    var aiGenerated: Bool
    var syncedAt: Date

    init(from dto: FlashcardDTO, certificationId: String) {
        self.id = dto.id
        self.certificationId = certificationId
        self.frontText = dto.frontText
        self.backText = dto.backText
        self.codeExample = dto.codeExample
        self.aiGenerated = dto.aiGenerated
        self.syncedAt = Date()
    }
}

// MARK: - SM2ScheduleEntity

/// Local SM-2 spaced repetition schedule — synced bidirectionally with backend.
@Model
final class SM2ScheduleEntity {
    @Attribute(.unique) var flashcardId: UUID
    var easeFactor: Double
    var intervalDays: Int
    var repetitions: Int
    var dueDate: Date
    var lastReviewedAt: Date?
    var isDirty: Bool               // True = needs sync to API

    init(flashcardId: UUID) {
        self.flashcardId = flashcardId
        self.easeFactor = 2.5
        self.intervalDays = 1
        self.repetitions = 0
        self.dueDate = Date()
        self.isDirty = false
    }
}

// MARK: - PendingSyncEntity

/// Queue of actions to sync when connectivity returns.
@Model
final class PendingSyncEntity {
    @Attribute(.unique) var id: UUID
    var type: String          // "SUBMIT_ANSWER" | "COMPLETE_SESSION" | "REVIEW_FLASHCARD"
    var payloadJson: Data
    var createdAt: Date
    var retryCount: Int

    init(type: String, payload: some Encodable, encoder: JSONEncoder = JSONEncoder()) {
        self.id = UUID()
        self.type = type
        self.payloadJson = (try? encoder.encode(AnyEncodable(payload))) ?? Data()
        self.createdAt = Date()
        self.retryCount = 0
    }
}

// MARK: - Codable helper

private struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void
    init(_ value: any Encodable) { _encode = { try value.encode(to: $0) } }
    func encode(to encoder: Encoder) throws { try _encode(encoder) }
}
