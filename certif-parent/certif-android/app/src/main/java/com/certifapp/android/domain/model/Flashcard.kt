// certif-parent/certif-android/app/src/main/java/com/certifapp/android/domain/model/Flashcard.kt
package com.certifapp.android.domain.model

/** Domain model for an SM-2 spaced-repetition flashcard. */
data class Flashcard(
    val id: String,
    val frontText: String,
    val backText: String,
    val codeExample: String?,
    val nextReviewDate: String,
    val easeFactor: Double,
    val intervalDays: Int,
    val repetitions: Int
)
