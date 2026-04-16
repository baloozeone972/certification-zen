// certif-parent/certif-android/app/src/main/java/com/certifapp/android/domain/model/Certification.kt
package com.certifapp.android.domain.model

/**
 * Domain model for a certification — pure Kotlin data class, no Android/Room dependencies.
 */
data class Certification(
    val id: String,
    val code: String,
    val name: String,
    val description: String?,
    val totalQuestions: Int,
    val examQuestionCount: Int,
    val passingScore: Int,
    val examDurationMin: Int,
    val examType: String,
    val themes: List<CertificationTheme>,
    val isActive: Boolean
)

data class CertificationTheme(
    val id: String,
    val code: String,
    val label: String,
    val questionCount: Int,
    val weightPercent: Double?
)
