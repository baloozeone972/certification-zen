// certif-parent/certif-android/app/src/main/java/com/certifapp/android/data/repository/ExamRepositoryImpl.kt
package com.certifapp.android.data.repository

import com.certifapp.android.data.remote.api.ExamApi
import com.certifapp.android.data.remote.dto.StartExamRequest
import com.certifapp.android.data.remote.dto.SubmitAnswerRequest
import com.certifapp.android.domain.model.*
import com.certifapp.android.domain.repository.ExamRepository
import javax.inject.Inject

class ExamRepositoryImpl @Inject constructor(
    private val api: ExamApi
) : ExamRepository {

    override suspend fun startSession(certificationId: String, mode: ExamMode): ExamSession {
        val dto = api.startSession(
            StartExamRequest(certificationId = certificationId, mode = mode.name)
        ).data
        return dto.toDomain()
    }

    override suspend fun submitAnswer(
        sessionId: String, questionId: String,
        selectedOptionId: String?, responseTimeMs: Long
    ) {
        api.submitAnswer(sessionId, SubmitAnswerRequest(questionId, selectedOptionId, responseTimeMs))
    }

    override suspend fun submitExam(sessionId: String): ExamSession =
        api.submitExam(sessionId).data.toDomain()

    override suspend fun getResults(sessionId: String): ExamSession =
        api.getResults(sessionId).data.toDomain()

    private fun com.certifapp.android.data.remote.dto.ExamSessionDto.toDomain() = ExamSession(
        id = id,
        certificationId = certificationId,
        mode = ExamMode.valueOf(mode),
        questions = questions.map { q ->
            Question(
                id = q.id, statement = q.statement,
                options = q.options.map { QuestionOption(it.id, it.label, it.text) },
                themeCode = q.themeCode, difficulty = q.difficulty
            )
        },
        startedAt = startedAt,
        durationSeconds = durationSeconds,
        timerEnabled = timerEnabled
    )
}
