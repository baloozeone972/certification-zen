// certif-parent/certif-android/app/src/main/java/com/certifapp/android/ui/screen/results/ResultsViewModel.kt
package com.certifapp.android.ui.screen.results

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.certifapp.android.domain.model.ExamSession
import com.certifapp.android.domain.repository.ExamRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch
import javax.inject.Inject

sealed interface ResultsUiState {
    object Loading : ResultsUiState
    data class Success(val session: ExamSession) : ResultsUiState
    data class Error(val message: String) : ResultsUiState
}

@HiltViewModel
class ResultsViewModel @Inject constructor(
    private val repository: ExamRepository
) : ViewModel() {

    private val _uiState = MutableStateFlow<ResultsUiState>(ResultsUiState.Loading)
    val uiState: StateFlow<ResultsUiState> = _uiState.asStateFlow()

    fun loadResults(sessionId: String) {
        viewModelScope.launch {
            _uiState.value = ResultsUiState.Loading
            runCatching { repository.getResults(sessionId) }.fold(
                onSuccess = { _uiState.value = ResultsUiState.Success(it) },
                onFailure = { _uiState.value = ResultsUiState.Error(it.message ?: "Erreur") }
            )
        }
    }
}
