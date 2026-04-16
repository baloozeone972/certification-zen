// certif-parent/certif-android/app/src/main/java/com/certifapp/android/worker/SyncWorker.kt
package com.certifapp.android.worker

import android.content.Context
import androidx.hilt.work.HiltWorker
import androidx.work.*
import com.certifapp.android.data.local.dao.PendingAnswerDao
import com.certifapp.android.data.remote.api.ExamApi
import com.certifapp.android.data.remote.dto.SubmitAnswerRequest
import com.certifapp.android.domain.repository.CertificationRepository
import dagger.assisted.Assisted
import dagger.assisted.AssistedInject
import java.util.concurrent.TimeUnit

/**
 * WorkManager worker that syncs offline data (pending answers, flashcard reviews)
 * to the backend when network connectivity is restored.
 *
 * Scheduled as a periodic work with NetworkType.CONNECTED constraint.
 */
@HiltWorker
class SyncWorker @AssistedInject constructor(
    @Assisted context: Context,
    @Assisted workerParams: WorkerParameters,
    private val pendingAnswerDao: PendingAnswerDao,
    private val examApi: ExamApi,
    private val certificationRepository: CertificationRepository
) : CoroutineWorker(context, workerParams) {

    override suspend fun doWork(): Result {
        return try {
            // 1. Sync pending exam answers
            syncPendingAnswers()
            // 2. Refresh certification cache
            certificationRepository.refreshCertifications()
            Result.success()
        } catch (e: Exception) {
            if (runAttemptCount < 3) Result.retry()
            else Result.failure()
        }
    }

    private suspend fun syncPendingAnswers() {
        val pending = pendingAnswerDao.getAll()
        for (answer in pending) {
            try {
                examApi.submitAnswer(
                    answer.sessionId,
                    SubmitAnswerRequest(answer.questionId, answer.selectedOptionId, answer.responseTimeMs)
                )
                pendingAnswerDao.delete(answer)
            } catch (e: Exception) {
                // Leave in queue for next sync
            }
        }
    }

    companion object {
        const val WORK_NAME = "certifapp_sync"

        /** Creates a periodic sync request running every 15 minutes with network constraint. */
        fun buildPeriodicRequest(): PeriodicWorkRequest =
            PeriodicWorkRequestBuilder<SyncWorker>(15, TimeUnit.MINUTES)
                .setConstraints(
                    Constraints.Builder()
                        .setRequiredNetworkType(NetworkType.CONNECTED)
                        .build()
                )
                .setBackoffCriteria(BackoffPolicy.EXPONENTIAL, 30, TimeUnit.SECONDS)
                .build()
    }
}
