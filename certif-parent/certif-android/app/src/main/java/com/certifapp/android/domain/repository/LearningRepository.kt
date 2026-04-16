// certif-parent/certif-android/app/src/main/java/com/certifapp/android/domain/repository/LearningRepository.kt
package com.certifapp.android.domain.repository

import com.certifapp.android.domain.model.Flashcard
import kotlinx.coroutines.flow.Flow

/** Domain port for learning features (flashcards, SM-2). */
interface LearningRepository {
    fun getFlashcardsDue(certificationId: String): Flow<List<Flashcard>>
    suspend fun reviewFlashcard(flashcardId: String, rating: Int)
    suspend fun syncFlashcards(certificationId: String)
}
