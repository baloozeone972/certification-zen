// certif-parent/certif-android/app/src/main/java/com/certifapp/android/domain/usecase/LoginUseCase.kt
package com.certifapp.android.domain.usecase

import com.certifapp.android.domain.model.TokenPair
import com.certifapp.android.domain.repository.AuthRepository
import javax.inject.Inject

/** Use case: authenticate user with email and password. */
class LoginUseCase @Inject constructor(
    private val repository: AuthRepository
) {
    suspend operator fun invoke(email: String, password: String): Result<TokenPair> =
        runCatching { repository.login(email, password) }
}
