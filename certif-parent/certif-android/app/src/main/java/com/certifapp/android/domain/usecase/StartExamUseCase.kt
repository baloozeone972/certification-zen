// certif-parent/certif-android/app/src/main/java/com/certifapp/android/domain/usecase/StartExamUseCase.kt
package com.certifapp.android.domain.usecase

import com.certifapp.android.domain.model.ExamMode
import com.certifapp.android.domain.model.ExamSession
import com.certifapp.android.domain.repository.ExamRepository
import javax.inject.Inject

/** Use case: start a new exam session. */
class StartExamUseCase @Inject constructor(
    private val repository: ExamRepository
) {
    suspend operator fun invoke(certificationId: String, mode: ExamMode): Result<ExamSession> =
        runCatching { repository.startSession(certificationId, mode) }
}
