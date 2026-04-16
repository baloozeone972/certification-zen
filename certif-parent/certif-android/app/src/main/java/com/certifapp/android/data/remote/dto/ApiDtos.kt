// certif-parent/certif-android/app/src/main/java/com/certifapp/android/data/remote/dto/ApiDtos.kt
package com.certifapp.android.data.remote.dto

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** Generic API response envelope matching the backend ApiResponse<T>. */
@Serializable
data class ApiResponse<T>(
    val data: T,
    val message: String,
    val timestamp: String
)

@Serializable
data class TokenResponseDto(
    val accessToken: String,
    val refreshToken: String,
    val expiresIn: Int,
    val tokenType: String
)

@Serializable
data class CertificationDto(
    val id: String,
    val code: String,
    val name: String,
    val description: String? = null,
    val totalQuestions: Int,
    val examQuestionCount: Int,
    val passingScore: Int,
    val examDurationMin: Int,
    val examType: String,
    val themes: List<CertificationThemeDto> = emptyList(),
    val isActive: Boolean
)

@Serializable
data class CertificationThemeDto(
    val id: String,
    val code: String,
    val label: String,
    val questionCount: Int,
    val weightPercent: Double? = null
)

@Serializable
data class ExamSessionDto(
    val id: String,
    val certificationId: String,
    val mode: String,
    val questions: List<QuestionDto>,
    val startedAt: String,
    val durationSeconds: Int,
    val timerEnabled: Boolean
)

@Serializable
data class QuestionDto(
    val id: String,
    val statement: String,
    val options: List<QuestionOptionDto>,
    val themeCode: String,
    val difficulty: String
)

@Serializable
data class QuestionOptionDto(
    val id: String,
    val label: String,
    val text: String
)

@Serializable
data class FlashcardDto(
    val id: String,
    val frontText: String,
    val backText: String,
    val codeExample: String? = null,
    val nextReviewDate: String,
    val easeFactor: Double,
    val intervalDays: Int,
    val repetitions: Int
)

@Serializable
data class StartExamRequest(
    val certificationId: String,
    val mode: String,
    val selectedThemes: List<String> = emptyList(),
    val questionCount: Int = 0,
    val durationMinutes: Int = 0
)

@Serializable
data class SubmitAnswerRequest(
    val questionId: String,
    @SerialName("selectedOptionId") val selectedOptionId: String?,
    val responseTimeMs: Long
)

@Serializable
data class ReviewFlashcardRequest(val rating: Int)
