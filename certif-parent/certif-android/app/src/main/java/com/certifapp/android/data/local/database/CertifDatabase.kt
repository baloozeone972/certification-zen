// certif-parent/certif-android/app/src/main/java/com/certifapp/android/data/local/database/CertifDatabase.kt
package com.certifapp.android.data.local.database

import androidx.room.Database
import androidx.room.RoomDatabase
import com.certifapp.android.data.local.dao.CertificationDao
import com.certifapp.android.data.local.dao.FlashcardDao
import com.certifapp.android.data.local.dao.PendingAnswerDao
import com.certifapp.android.data.local.entity.CertificationEntity
import com.certifapp.android.data.local.entity.FlashcardEntity
import com.certifapp.android.data.local.entity.PendingAnswerEntity

/**
 * Room database for offline-first CertifApp.
 * Version 1 — migrated in future versions without data loss.
 */
@Database(
    entities = [
        CertificationEntity::class,
        FlashcardEntity::class,
        PendingAnswerEntity::class
    ],
    version = 1,
    exportSchema = true
)
abstract class CertifDatabase : RoomDatabase() {
    abstract fun certificationDao(): CertificationDao
    abstract fun flashcardDao(): FlashcardDao
    abstract fun pendingAnswerDao(): PendingAnswerDao
}
