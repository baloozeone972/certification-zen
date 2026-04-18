// certif-parent/certif-android/app/src/main/java/com/certifapp/android/domain/repository/ExamRepository.kt
package com.certifapp.android.domain.repository

import com.certifapp.android.domain.model.ExamSession
import com.certifapp.android.domain.model.ExamMode

/** Domain port for exam session operations. */
interface ExamRepository {
    suspend fun startSession(certificationId: String, mode: ExamMode): ExamSession
    suspend fun submitAnswer(
        sessionId: String, questionId: String,
        selectedOptionId: String?, responseTimeMs: Long
    )

    suspend fun submitExam(sessionId: String): ExamSession
    suspend fun getResults(sessionId: String): ExamSession
}
