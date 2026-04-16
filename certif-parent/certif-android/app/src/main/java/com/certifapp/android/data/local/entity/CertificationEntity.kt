// certif-parent/certif-android/app/src/main/java/com/certifapp/android/data/local/entity/CertificationEntity.kt
package com.certifapp.android.data.local.entity

import androidx.room.Entity
import androidx.room.PrimaryKey

/**
 * Room entity for offline certification cache.
 * Themes are stored as JSON string (serialized with kotlinx.serialization).
 */
@Entity(tableName = "certifications")
data class CertificationEntity(
    @PrimaryKey val id: String,
    val code: String,
    val name: String,
    val description: String?,
    val totalQuestions: Int,
    val examQuestionCount: Int,
    val passingScore: Int,
    val examDurationMin: Int,
    val examType: String,
    val themesJson: String, // JSON array of CertificationTheme
    val isActive: Boolean,
    val cachedAt: Long = System.currentTimeMillis()
)
