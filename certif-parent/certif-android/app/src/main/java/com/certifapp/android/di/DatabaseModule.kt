// certif-parent/certif-android/app/src/main/java/com/certifapp/android/di/DatabaseModule.kt
package com.certifapp.android.di

import android.content.Context
import androidx.room.Room
import com.certifapp.android.data.local.dao.CertificationDao
import com.certifapp.android.data.local.dao.FlashcardDao
import com.certifapp.android.data.local.dao.PendingAnswerDao
import com.certifapp.android.data.local.database.CertifDatabase
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

/**
 * Hilt DatabaseModule — provides Room database and all DAOs.
 */
@Module
@InstallIn(SingletonComponent::class)
object DatabaseModule {

    @Provides
    @Singleton
    fun provideDatabase(@ApplicationContext context: Context): CertifDatabase =
        Room.databaseBuilder(context, CertifDatabase::class.java, "certifapp.db")
            .fallbackToDestructiveMigration() // Replace with proper migrations in prod
            .build()

    @Provides
    @Singleton
    fun provideCertificationDao(db: CertifDatabase): CertificationDao = db.certificationDao()

    @Provides
    @Singleton
    fun provideFlashcardDao(db: CertifDatabase): FlashcardDao = db.flashcardDao()

    @Provides
    @Singleton
    fun providePendingAnswerDao(db: CertifDatabase): PendingAnswerDao = db.pendingAnswerDao()
}
