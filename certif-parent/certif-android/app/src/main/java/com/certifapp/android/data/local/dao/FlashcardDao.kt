// certif-parent/certif-android/app/src/main/java/com/certifapp/android/data/local/dao/FlashcardDao.kt
package com.certifapp.android.data.local.dao

import androidx.room.*
import com.certifapp.android.data.local.entity.FlashcardEntity
import kotlinx.coroutines.flow.Flow
import java.time.LocalDate

/** Room DAO for flashcards and SM-2 schedule. */
@Dao
interface FlashcardDao {

    /** Returns flashcards due today or overdue for a given certification. */
    @Query(
        """
        SELECT * FROM flashcards
        WHERE certificationId = :certId
        AND nextReviewDate <= :today
        ORDER BY nextReviewDate ASC
        LIMIT :limit
    """
    )
    fun getDue(certId: String, today: String, limit: Int = 20): Flow<List<FlashcardEntity>>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertAll(flashcards: List<FlashcardEntity>)

    @Update
    suspend fun update(flashcard: FlashcardEntity)

    @Query("SELECT * FROM flashcards WHERE pendingSync = 1")
    suspend fun getPendingSync(): List<FlashcardEntity>

    @Query("UPDATE flashcards SET pendingSync = 0 WHERE id = :id")
    suspend fun markSynced(id: String)
}
