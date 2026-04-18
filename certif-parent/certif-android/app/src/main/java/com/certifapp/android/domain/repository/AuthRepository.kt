// certif-parent/certif-android/app/src/main/java/com/certifapp/android/domain/repository/AuthRepository.kt
package com.certifapp.android.domain.repository

import com.certifapp.android.domain.model.TokenPair
import com.certifapp.android.domain.model.User

/** Domain port for authentication operations. */
interface AuthRepository {
    suspend fun login(email: String, password: String): TokenPair
    suspend fun register(email: String, password: String): TokenPair
    suspend fun logout()
    fun getStoredUser(): User?
    fun isLoggedIn(): Boolean
}
