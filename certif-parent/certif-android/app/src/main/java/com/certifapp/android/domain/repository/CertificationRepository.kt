// certif-parent/certif-android/app/src/main/java/com/certifapp/android/domain/repository/CertificationRepository.kt
package com.certifapp.android.domain.repository

import com.certifapp.android.domain.model.Certification
import kotlinx.coroutines.flow.Flow

/**
 * Domain port for certification data.
 * Implemented by CertificationRepositoryImpl (data layer).
 * Uses Flow for offline-first: emits cached data first, then remote.
 */
interface CertificationRepository {
    fun getCertifications(): Flow<List<Certification>>
    suspend fun getCertificationById(id: String): Certification?
    suspend fun refreshCertifications()
}
