// certif-parent/certif-android/app/src/main/java/com/certifapp/android/data/repository/CertificationRepositoryImpl.kt
package com.certifapp.android.data.repository

import com.certifapp.android.data.local.dao.CertificationDao
import com.certifapp.android.data.local.entity.CertificationEntity
import com.certifapp.android.data.remote.api.CertificationApi
import com.certifapp.android.domain.model.Certification
import com.certifapp.android.domain.model.CertificationTheme
import com.certifapp.android.domain.repository.CertificationRepository
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import javax.inject.Inject

/**
 * Offline-first repository — emits Room cache immediately,
 * then refreshes from network in background.
 */
class CertificationRepositoryImpl @Inject constructor(
    private val dao: CertificationDao,
    private val api: CertificationApi,
    private val json: Json
) : CertificationRepository {

    override fun getCertifications(): Flow<List<Certification>> =
        dao.getAllActive().map { entities -> entities.map { it.toDomain(json) } }

    override suspend fun getCertificationById(id: String): Certification? =
        dao.getById(id)?.toDomain(json)

    override suspend fun refreshCertifications() {
        val dtos = api.getAll().data
        val entities = dtos.map { dto ->
            CertificationEntity(
                id               = dto.id,
                code             = dto.code,
                name             = dto.name,
                description      = dto.description,
                totalQuestions   = dto.totalQuestions,
                examQuestionCount = dto.examQuestionCount,
                passingScore     = dto.passingScore,
                examDurationMin  = dto.examDurationMin,
                examType         = dto.examType,
                themesJson       = json.encodeToString(dto.themes),
                isActive         = dto.isActive
            )
        }
        dao.refreshAll(entities)
    }

    private fun CertificationEntity.toDomain(json: Json): Certification {
        val themes = try {
            json.decodeFromString<List<com.certifapp.android.data.remote.dto.CertificationThemeDto>>(themesJson)
                .map { CertificationTheme(it.id, it.code, it.label, it.questionCount, it.weightPercent) }
        } catch (e: Exception) { emptyList() }
        return Certification(id, code, name, description, totalQuestions,
            examQuestionCount, passingScore, examDurationMin, examType, themes, isActive)
    }
}
