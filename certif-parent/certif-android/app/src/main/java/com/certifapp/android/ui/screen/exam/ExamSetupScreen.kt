// certif-parent/certif-android/app/src/main/java/com/certifapp/android/ui/screen/exam/ExamSetupScreen.kt
package com.certifapp.android.ui.screen.exam

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.selection.selectable
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.certifapp.android.domain.model.ExamMode

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ExamSetupScreen(
    certId: String,
    onSessionStarted: (sessionId: String) -> Unit,
    onBack: () -> Unit,
    viewModel: ExamViewModel = hiltViewModel()
) {
    val uiState by viewModel.uiState.collectAsState()
    var mode by remember { mutableStateOf(ExamMode.EXAM) }

    LaunchedEffect(uiState) {
        if (uiState is ExamUiState.SessionStarted)
            onSessionStarted((uiState as ExamUiState.SessionStarted).sessionId)
    }

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Configurer l'examen") },
                navigationIcon = {
                    IconButton(onClick = onBack) {
                        Icon(Icons.Default.ArrowBack, null)
                    }
                }
            )
        }
    ) { padding ->
        Column(modifier = Modifier.padding(padding).padding(16.dp)) {

            Card(modifier = Modifier.fillMaxWidth()) {
                Column(modifier = Modifier.padding(16.dp)) {
                    Text("Certification : $certId", fontWeight = FontWeight.Bold)
                }
            }

            Spacer(Modifier.height(20.dp))
            Text("Mode d'examen", fontWeight = FontWeight.SemiBold, modifier = Modifier.padding(bottom = 8.dp))

            ExamMode.entries.forEach { m ->
                val label = when (m) {
                    ExamMode.EXAM -> "📝 Examen officiel" to "Conditions réelles, correction à la fin"
                    ExamMode.FREE -> "🎯 Mode libre" to "Choisissez vos thèmes"
                    ExamMode.REVISION -> "📚 Révision" to "Correction immédiate"
                }
                Row(
                    Modifier.fillMaxWidth().selectable(
                        selected = mode == m,
                        onClick = { mode = m }).padding(vertical = 8.dp)
                ) {
                    RadioButton(selected = mode == m, onClick = { mode = m })
                    Column(Modifier.padding(start = 8.dp)) {
                        Text(label.first, fontWeight = FontWeight.Medium)
                        Text(
                            label.second, style = MaterialTheme.typography.bodySmall,
                            color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.6f)
                        )
                    }
                }
            }

            Spacer(Modifier.weight(1f))

            Button(
                onClick = { viewModel.startSession(certId, mode) },
                modifier = Modifier.fillMaxWidth().height(50.dp),
                enabled = uiState !is ExamUiState.Loading
            ) {
                if (uiState is ExamUiState.Loading) CircularProgressIndicator(Modifier.size(20.dp), strokeWidth = 2.dp)
                else Text("Démarrer l'examen →")
            }
        }
    }
}
