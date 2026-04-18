// certif-parent/certif-android/app/src/main/java/com/certifapp/android/ui/screen/results/ResultsScreen.kt
package com.certifapp.android.ui.screen.results

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.certifapp.android.ui.components.CenteredLoading
import com.certifapp.android.ui.components.ScoreIndicator
import com.certifapp.android.domain.model.ExamSession

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ResultsScreen(
    sessionId: String,
    onBack: () -> Unit,
    viewModel: ResultsViewModel = hiltViewModel()
) {
    val uiState by viewModel.uiState.collectAsState()
    LaunchedEffect(sessionId) { viewModel.loadResults(sessionId) }

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Résultats") },
                navigationIcon = { IconButton(onClick = onBack) { Icon(Icons.Default.ArrowBack, null) } }
            )
        }
    ) { padding ->
        when (val state = uiState) {
            is ResultsUiState.Loading -> CenteredLoading()
            is ResultsUiState.Error -> Text(state.message, Modifier.padding(padding))
            is ResultsUiState.Success -> ResultsContent(state.session, Modifier.padding(padding))
        }
    }
}

@Composable
private fun ResultsContent(session: ExamSession, modifier: Modifier = Modifier) {
    LazyColumn(
        modifier = modifier.fillMaxSize(), contentPadding = PaddingValues(16.dp),
        verticalArrangement = Arrangement.spacedBy(12.dp)
    ) {

        item {
            Card(modifier = Modifier.fillMaxWidth()) {
                Column(Modifier.padding(16.dp)) {
                    ScoreIndicator(session.percentage, session.passed)
                    Spacer(Modifier.height(8.dp))
                    Text(
                        "${session.correctCount} / ${session.totalQuestions} questions",
                        fontWeight = FontWeight.Medium
                    )
                    Text(
                        session.certificationId,
                        color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.6f)
                    )
                }
            }
        }

        item {
            Text(
                "Résultats par thème", fontWeight = FontWeight.SemiBold,
                modifier = Modifier.padding(top = 8.dp)
            )
        }
    }
}
