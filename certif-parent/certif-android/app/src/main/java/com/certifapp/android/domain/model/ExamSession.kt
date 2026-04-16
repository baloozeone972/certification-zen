// certif-parent/certif-android/app/src/main/java/com/certifapp/android/domain/model/ExamSession.kt
package com.certifapp.android.domain.model

/** Domain model for an active or completed exam session. */
data class ExamSession(
    val id: String,
    val certificationId: String,
    val mode: ExamMode,
    val questions: List<Question>,
    val startedAt: String,
    val durationSeconds: Int,
    val timerEnabled: Boolean,
    // Populated after submission
    val status: SessionStatus = SessionStatus.IN_PROGRESS,
    val totalQuestions: Int = questions.size,
    val correctCount: Int = 0,
    val percentage: Double = 0.0,
    val passed: Boolean = false
)

enum class ExamMode { EXAM, FREE, REVISION }
enum class SessionStatus { IN_PROGRESS, COMPLETED, ABANDONED, EXPIRED }

data class Question(
    val id: String,
    val statement: String,
    val options: List<QuestionOption>,
    val themeCode: String,
    val difficulty: String,
    // Only populated in results view
    val correctOptionId: String? = null,
    val explanationOriginal: String? = null,
    val explanationEnriched: String? = null
)

data class QuestionOption(
    val id: String,
    val label: String,
    val text: String
)
