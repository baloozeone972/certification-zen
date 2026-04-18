// certif-parent/certif-android/app/src/main/java/com/certifapp/android/ui/screen/exam/ExamViewModel.kt
package com.certifapp.android.ui.screen.exam

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.certifapp.android.domain.model.ExamMode
import com.certifapp.android.domain.model.ExamSession
import com.certifapp.android.domain.repository.ExamRepository
import com.certifapp.android.domain.usecase.StartExamUseCase
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch
import javax.inject.Inject

sealed interface ExamUiState {
    object Idle : ExamUiState
    object Loading : ExamUiState
    data class SessionStarted(val sessionId: String) : ExamUiState
    data class Submitted(val sessionId: String) : ExamUiState
    data class Error(val message: String) : ExamUiState
}

@HiltViewModel
class ExamViewModel @Inject constructor(
    private val startExamUseCase: StartExamUseCase,
    private val examRepository: ExamRepository
) : ViewModel() {

    private val _uiState = MutableStateFlow<ExamUiState>(ExamUiState.Idle)
    val uiState: StateFlow<ExamUiState> = _uiState.asStateFlow()

    private val _session = MutableStateFlow<ExamSession?>(null)
    val session: StateFlow<ExamSession?> = _session.asStateFlow()

    private val _currentIndex = MutableStateFlow(0)
    val currentIndex: StateFlow<Int> = _currentIndex.asStateFlow()

    private val _answers = MutableStateFlow<Map<String, String>>(emptyMap())
    val answers: StateFlow<Map<String, String>> = _answers.asStateFlow()

    private var startTimeMs = System.currentTimeMillis()

    fun startSession(certId: String, mode: ExamMode) {
        viewModelScope.launch {
            _uiState.value = ExamUiState.Loading
            startExamUseCase(certId, mode).fold(
                onSuccess = { session ->
                    _session.value = session
                    startTimeMs = System.currentTimeMillis()
                    _uiState.value = ExamUiState.SessionStarted(session.id)
                },
                onFailure = { _uiState.value = ExamUiState.Error(it.message ?: "Erreur démarrage") }
            )
        }
    }

    fun loadSession(sessionId: String) {
        viewModelScope.launch {
            _uiState.value = ExamUiState.Loading
            runCatching { examRepository.getResults(sessionId) }.fold(
                onSuccess = { _session.value = it; _uiState.value = ExamUiState.Idle },
                onFailure = { _uiState.value = ExamUiState.Error(it.message ?: "Erreur") }
            )
        }
    }

    fun selectOption(questionId: String, optionId: String) {
        _answers.update { it + (questionId to optionId) }
        val elapsed = System.currentTimeMillis() - startTimeMs
        viewModelScope.launch {
            _session.value?.let { session ->
                examRepository.submitAnswer(session.id, questionId, optionId, elapsed)
            }
        }
    }

    fun skipQuestion() {
        val session = _session.value ?: return
        val qId = session.questions[_currentIndex.value].id
        viewModelScope.launch { examRepository.submitAnswer(session.id, qId, null, 0) }
        nextQuestion()
    }

    fun nextQuestion() {
        val max = (_session.value?.questions?.size ?: 1) - 1
        if (_currentIndex.value < max) _currentIndex.update { it + 1 }
    }

    fun submitExam() {
        val session = _session.value ?: return
        viewModelScope.launch {
            _uiState.value = ExamUiState.Loading
            runCatching { examRepository.submitExam(session.id) }.fold(
                onSuccess = { _uiState.value = ExamUiState.Submitted(session.id) },
                onFailure = { _uiState.value = ExamUiState.Error(it.message ?: "Erreur soumission") }
            )
        }
    }
}
