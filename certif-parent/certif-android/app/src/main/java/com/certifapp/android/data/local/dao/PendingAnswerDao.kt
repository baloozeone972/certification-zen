// certif-parent/certif-android/app/src/main/java/com/certifapp/android/data/local/dao/PendingAnswerDao.kt
package com.certifapp.android.data.local.dao

import androidx.room.*
import com.certifapp.android.data.local.entity.PendingAnswerEntity

/** Room DAO for offline answer queue. */
@Dao
interface PendingAnswerDao {

    @Insert
    suspend fun insert(answer: PendingAnswerEntity)

    @Query("SELECT * FROM pending_answers ORDER BY submittedAt ASC")
    suspend fun getAll(): List<PendingAnswerEntity>

    @Delete
    suspend fun delete(answer: PendingAnswerEntity)

    @Query("DELETE FROM pending_answers WHERE sessionId = :sessionId")
    suspend fun deleteBySession(sessionId: String)
}
