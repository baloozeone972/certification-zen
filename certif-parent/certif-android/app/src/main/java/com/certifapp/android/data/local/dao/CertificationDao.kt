// certif-parent/certif-android/app/src/main/java/com/certifapp/android/data/local/dao/CertificationDao.kt
package com.certifapp.android.data.local.dao

import androidx.room.*
import com.certifapp.android.data.local.entity.CertificationEntity
import kotlinx.coroutines.flow.Flow

/** Room DAO for the certification cache. */
@Dao
interface CertificationDao {

    @Query("SELECT * FROM certifications WHERE isActive = 1 ORDER BY name")
    fun getAllActive(): Flow<List<CertificationEntity>>

    @Query("SELECT * FROM certifications WHERE id = :id")
    suspend fun getById(id: String): CertificationEntity?

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertAll(certifications: List<CertificationEntity>)

    @Query("DELETE FROM certifications")
    suspend fun deleteAll()

    @Transaction
    suspend fun refreshAll(certifications: List<CertificationEntity>) {
        deleteAll()
        insertAll(certifications)
    }
}
