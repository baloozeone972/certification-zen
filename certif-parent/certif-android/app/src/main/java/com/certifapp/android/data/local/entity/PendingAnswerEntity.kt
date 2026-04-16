// certif-parent/certif-android/app/src/main/java/com/certifapp/android/data/local/entity/PendingAnswerEntity.kt
package com.certifapp.android.data.local.entity

import androidx.room.Entity
import androidx.room.PrimaryKey

/**
 * Room entity for answers submitted while offline.
 * Synced to the backend by [SyncWorker] when connectivity is restored.
 */
@Entity(tableName = "pending_answers")
data class PendingAnswerEntity(
    @PrimaryKey(autoGenerate = true) val id: Long = 0,
    val sessionId: String,
    val questionId: String,
    val selectedOptionId: String?,
    val responseTimeMs: Long,
    val submittedAt: Long = System.currentTimeMillis()
)
