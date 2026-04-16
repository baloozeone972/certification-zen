// certif-parent/certif-android/app/src/main/java/com/certifapp/android/data/local/entity/FlashcardEntity.kt
package com.certifapp.android.data.local.entity

import androidx.room.Entity
import androidx.room.PrimaryKey

/**
 * Room entity for offline flashcard SM-2 cache.
 * Enables offline review without network connectivity.
 */
@Entity(tableName = "flashcards")
data class FlashcardEntity(
    @PrimaryKey val id: String,
    val certificationId: String,
    val frontText: String,
    val backText: String,
    val codeExample: String?,
    val nextReviewDate: String,
    val easeFactor: Double,
    val intervalDays: Int,
    val repetitions: Int,
    val pendingSync: Boolean = false // true = review submitted offline, needs sync
)
