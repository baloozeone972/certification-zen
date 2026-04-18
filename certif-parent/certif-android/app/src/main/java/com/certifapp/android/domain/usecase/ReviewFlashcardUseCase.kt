// certif-parent/certif-android/app/src/main/java/com/certifapp/android/domain/usecase/ReviewFlashcardUseCase.kt
package com.certifapp.android.domain.usecase

import com.certifapp.android.domain.repository.LearningRepository
import javax.inject.Inject

/** Use case: submit SM-2 review for a flashcard. */
class ReviewFlashcardUseCase @Inject constructor(
    private val repository: LearningRepository
) {
    suspend operator fun invoke(flashcardId: String, rating: Int): Result<Unit> =
        runCatching { repository.reviewFlashcard(flashcardId, rating) }
}
