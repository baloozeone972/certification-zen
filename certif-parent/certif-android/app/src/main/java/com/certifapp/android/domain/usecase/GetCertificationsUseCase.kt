// certif-parent/certif-android/app/src/main/java/com/certifapp/android/domain/usecase/GetCertificationsUseCase.kt
package com.certifapp.android.domain.usecase

import com.certifapp.android.domain.model.Certification
import com.certifapp.android.domain.repository.CertificationRepository
import kotlinx.coroutines.flow.Flow
import javax.inject.Inject

/** Use case: get all certifications (offline-first). */
class GetCertificationsUseCase @Inject constructor(
    private val repository: CertificationRepository
) {
    operator fun invoke(): Flow<List<Certification>> = repository.getCertifications()
}
