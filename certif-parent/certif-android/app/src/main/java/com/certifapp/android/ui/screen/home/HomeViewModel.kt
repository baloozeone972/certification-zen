// certif-parent/certif-android/app/src/main/java/com/certifapp/android/ui/screen/home/HomeViewModel.kt
package com.certifapp.android.ui.screen.home

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.certifapp.android.domain.model.Certification
import com.certifapp.android.domain.repository.CertificationRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch
import javax.inject.Inject

sealed interface HomeUiState {
    object Loading : HomeUiState
    data class Success(val certifications: List<Certification>) : HomeUiState
    data class Error(val message: String) : HomeUiState
}

@HiltViewModel
class HomeViewModel @Inject constructor(
    private val repository: CertificationRepository
) : ViewModel() {

    private val _uiState = MutableStateFlow<HomeUiState>(HomeUiState.Loading)
    val uiState: StateFlow<HomeUiState> = _uiState.asStateFlow()

    init { loadCertifications() }

    fun loadCertifications() {
        viewModelScope.launch {
            _uiState.value = HomeUiState.Loading
            repository.getCertifications()
                .catch { e -> _uiState.value = HomeUiState.Error(e.message ?: "Erreur") }
                .collect { certs ->
                    _uiState.value = if (certs.isEmpty()) HomeUiState.Loading
                    else HomeUiState.Success(certs)
                }
            // Refresh from network in background
            try { repository.refreshCertifications() } catch (_: Exception) {}
        }
    }
}
