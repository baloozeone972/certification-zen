// certif-parent/certif-android/app/src/main/java/com/certifapp/android/domain/model/User.kt
package com.certifapp.android.domain.model

/** Domain model for the authenticated user. */
data class User(
    val id: String,
    val email: String,
    val role: String,
    val subscriptionTier: SubscriptionTier,
    val locale: String,
    val timezone: String
)

enum class SubscriptionTier { FREE, PRO, PACK }

/** JWT token pair returned after authentication. */
data class TokenPair(
    val accessToken: String,
    val refreshToken: String,
    val expiresIn: Int
)
