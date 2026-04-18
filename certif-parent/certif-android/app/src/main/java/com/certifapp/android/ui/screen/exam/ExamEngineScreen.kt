// certif-parent/certif-android/app/src/main/java/com/certifapp/android/ui/screen/exam/ExamEngineScreen.kt
package com.certifapp.android.ui.screen.exam

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.selection.selectable
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.certifapp.android.ui.components.DifficultyChip

@Composable
fun ExamEngineScreen(
    sessionId: String,
    onExamFinished: (sessionId: String) -> Unit,
    viewModel: ExamViewModel = hiltViewModel()
) {
    val uiState by viewModel.uiState.collectAsState()
    val session by viewModel.session.collectAsState()
    val qIndex by viewModel.currentIndex.collectAsState()
    val answers by viewModel.answers.collectAsState()

    LaunchedEffect(sessionId) { viewModel.loadSession(sessionId) }
    LaunchedEffect(uiState) {
        if (uiState is ExamUiState.Submitted)
            onExamFinished((uiState as ExamUiState.Submitted).sessionId)
    }

    val s = session ?: return
    if (s.questions.isEmpty()) return

    val currentQ = s.questions[qIndex]
    val selected = answers[currentQ.id]

    Column(modifier = Modifier.fillMaxSize()) {
        // Progress header
        LinearProgressIndicator(
            progress = { (qIndex + 1f) / s.questions.size },
            modifier = Modifier.fillMaxWidth()
        )
        Row(Modifier.fillMaxWidth().padding(12.dp), Arrangement.SpaceBetween, Alignment.CenterVertically) {
            Text("${qIndex + 1} / ${s.questions.size}", style = MaterialTheme.typography.labelMedium)
            DifficultyChip(currentQ.difficulty)
        }

        // Question body
        Column(
            modifier = Modifier.weight(1f).verticalScroll(rememberScrollState()).padding(16.dp)
        ) {
            Text(
                currentQ.statement, style = MaterialTheme.typography.bodyLarge,
                modifier = Modifier.padding(bottom = 16.dp)
            )
            currentQ.options.forEach { opt ->
                Card(
                    modifier = Modifier.fillMaxWidth().padding(vertical = 4.dp)
                        .selectable(
                            selected = selected == opt.id,
                            onClick = { viewModel.selectOption(currentQ.id, opt.id) }),
                    colors = if (selected == opt.id)
                        CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.primaryContainer)
                    else CardDefaults.cardColors()
                ) {
                    Row(Modifier.padding(12.dp), verticalAlignment = Alignment.CenterVertically) {
                        RadioButton(selected = selected == opt.id, onClick = null)
                        Spacer(Modifier.width(8.dp))
                        Column {
                            Text(
                                opt.label,
                                fontWeight = FontWeight.Bold,
                                fontSize = androidx.compose.ui.unit.TextUnit.Unspecified
                            )
                            Text(opt.text, style = MaterialTheme.typography.bodyMedium)
                        }
                    }
                }
            }
        }

        // Navigation footer
        Row(Modifier.fillMaxWidth().padding(16.dp), Arrangement.spacedBy(8.dp)) {
            OutlinedButton(onClick = { viewModel.skipQuestion() }, Modifier.weight(1f)) { Text("Passer") }
            if (qIndex < s.questions.size - 1) {
                Button(onClick = { viewModel.nextQuestion() }, Modifier.weight(1f)) { Text("Suivant →") }
            } else {
                Button(
                    onClick = { viewModel.submitExam() }, Modifier.weight(1f),
                    colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.tertiary)
                ) { Text("Terminer ✓") }
            }
        }
    }
}
