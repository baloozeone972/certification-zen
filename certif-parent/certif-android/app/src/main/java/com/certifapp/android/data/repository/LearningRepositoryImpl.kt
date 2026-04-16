// certif-parent/certif-android/app/src/main/java/com/certifapp/android/data/repository/LearningRepositoryImpl.kt
package com.certifapp.android.data.repository

import com.certifapp.android.data.local.dao.FlashcardDao
import com.certifapp.android.data.local.entity.FlashcardEntity
import com.certifapp.android.data.remote.api.LearningApi
import com.certifapp.android.data.remote.dto.ReviewFlashcardRequest
import com.certifapp.android.domain.model.Flashcard
import com.certifapp.android.domain.repository.LearningRepository
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map
import java.time.LocalDate
import javax.inject.Inject

class LearningRepositoryImpl @Inject constructor(
    private val dao: FlashcardDao,
    private val api: LearningApi
) : LearningRepository {

    override fun getFlashcardsDue(certificationId: String): Flow<List<Flashcard>> =
        dao.getDue(certificationId, LocalDate.now().toString())
           .map { it.map(FlashcardEntity::toDomain) }

    override suspend fun reviewFlashcard(flashcardId: String, rating: Int) {
        api.reviewFlashcard(flashcardId, ReviewFlashcardRequest(rating))
    }

    override suspend fun syncFlashcards(certificationId: String) {
        val dtos = api.getFlashcardsDue(certificationId, 50).data
        val entities = dtos.map {
            FlashcardEntity(it.id, certificationId, it.frontText, it.backText,
                it.codeExample, it.nextReviewDate, it.easeFactor, it.intervalDays, it.repetitions)
        }
        dao.insertAll(entities)
    }

    private fun FlashcardEntity.toDomain() = Flashcard(
        id, frontText, backText, codeExample, nextReviewDate, easeFactor, intervalDays, repetitions)
}
