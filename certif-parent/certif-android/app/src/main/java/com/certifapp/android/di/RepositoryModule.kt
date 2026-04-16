// certif-parent/certif-android/app/src/main/java/com/certifapp/android/di/RepositoryModule.kt
package com.certifapp.android.di

import com.certifapp.android.data.repository.*
import com.certifapp.android.domain.repository.*
import dagger.Binds
import dagger.Module
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

/**
 * Hilt RepositoryModule — binds domain interfaces to data implementations.
 */
@Module
@InstallIn(SingletonComponent::class)
abstract class RepositoryModule {

    @Binds @Singleton
    abstract fun bindCertificationRepository(
        impl: CertificationRepositoryImpl
    ): CertificationRepository

    @Binds @Singleton
    abstract fun bindAuthRepository(
        impl: AuthRepositoryImpl
    ): AuthRepository

    @Binds @Singleton
    abstract fun bindExamRepository(
        impl: ExamRepositoryImpl
    ): ExamRepository

    @Binds @Singleton
    abstract fun bindLearningRepository(
        impl: LearningRepositoryImpl
    ): LearningRepository
}
