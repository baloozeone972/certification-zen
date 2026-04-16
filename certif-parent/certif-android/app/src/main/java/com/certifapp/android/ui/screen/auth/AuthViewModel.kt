// certif-parent/certif-android/app/src/main/java/com/certifapp/android/ui/screen/auth/AuthViewModel.kt
package com.certifapp.android.ui.screen.auth

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.certifapp.android.domain.usecase.LoginUseCase
import com.certifapp.android.domain.repository.AuthRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch
import javax.inject.Inject

sealed interface AuthUiState {
    object Idle    : AuthUiState
    object Loading : AuthUiState
    object Success : AuthUiState
    data class Error(val message: String) : AuthUiState
}

@HiltViewModel
class AuthViewModel @Inject constructor(
    private val loginUseCase: LoginUseCase,
    private val authRepository: AuthRepository
) : ViewModel() {

    private val _uiState = MutableStateFlow<AuthUiState>(AuthUiState.Idle)
    val uiState: StateFlow<AuthUiState> = _uiState.asStateFlow()

    fun login(email: String, password: String) {
        viewModelScope.launch {
            _uiState.value = AuthUiState.Loading
            loginUseCase(email, password).fold(
                onSuccess = { _uiState.value = AuthUiState.Success },
                onFailure = { _uiState.value = AuthUiState.Error("Email ou mot de passe incorrect.") }
            )
        }
    }

    fun register(email: String, password: String) {
        viewModelScope.launch {
            _uiState.value = AuthUiState.Loading
            runCatching { authRepository.register(email, password) }.fold(
                onSuccess = { _uiState.value = AuthUiState.Success },
                onFailure = { _uiState.value = AuthUiState.Error(it.message ?: "Erreur inscription") }
            )
        }
    }
}
