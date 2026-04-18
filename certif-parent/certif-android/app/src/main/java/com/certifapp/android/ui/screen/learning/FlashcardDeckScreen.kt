// certif-parent/certif-android/app/src/main/java/com/certifapp/android/ui/screen/learning/FlashcardDeckScreen.kt
package com.certifapp.android.ui.screen.learning

import androidx.compose.animation.core.*
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.certifapp.android.domain.model.Flashcard
import com.certifapp.android.domain.repository.LearningRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch
import javax.inject.Inject

// ── ViewModel ─────────────────────────────────────────────────────────────────

sealed interface FlashcardUiState {
    object Loading : FlashcardUiState
    data class Active(val flashcard: Flashcard, val index: Int, val total: Int) : FlashcardUiState
    data class Done(val reviewed: Int) : FlashcardUiState
    data class Error(val message: String) : FlashcardUiState
}

@HiltViewModel
class FlashcardViewModel @Inject constructor(
    private val repository: LearningRepository
) : ViewModel() {

    private val _state = MutableStateFlow<FlashcardUiState>(FlashcardUiState.Loading)
    val state: StateFlow<FlashcardUiState> = _state.asStateFlow()

    private var flashcards: List<Flashcard> = emptyList()
    private var currentIndex = 0
    private var reviewedCount = 0

    fun load(certificationId: String) {
        viewModelScope.launch {
            repository.getFlashcardsDue(certificationId)
                .catch { e -> _state.value = FlashcardUiState.Error(e.message ?: "Erreur") }
                .collect { cards ->
                    flashcards = cards
                    if (cards.isEmpty()) {
                        _state.value = FlashcardUiState.Done(0)
                    } else {
                        currentIndex = 0
                        _state.value = FlashcardUiState.Active(cards[0], 0, cards.size)
                    }
                }
        }
    }

    fun review(flashcardId: String, rating: Int) {
        viewModelScope.launch {
            repository.reviewFlashcard(flashcardId, rating)
            reviewedCount++
            val next = currentIndex + 1
            if (next >= flashcards.size) {
                _state.value = FlashcardUiState.Done(reviewedCount)
            } else {
                currentIndex = next
                _state.value = FlashcardUiState.Active(
                    flashcards[next], next, flashcards.size
                )
            }
        }
    }
}

// ── Composable ────────────────────────────────────────────────────────────────

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun FlashcardDeckScreen(
    certId: String,
    onFinished: () -> Unit,
    viewModel: FlashcardViewModel = hiltViewModel()
) {
    val uiState by viewModel.state.collectAsState()

    LaunchedEffect(certId) { viewModel.load(certId) }

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Flashcards — $certId") },
                navigationIcon = {
                    IconButton(onClick = onFinished) {
                        Icon(Icons.Default.ArrowBack, contentDescription = "Retour")
                    }
                }
            )
        }
    ) { padding ->
        Box(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .padding(16.dp),
            contentAlignment = Alignment.Center
        ) {
            when (val s = uiState) {
                is FlashcardUiState.Loading -> CircularProgressIndicator()

                is FlashcardUiState.Error -> Column(
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    Text("⚠️", fontSize = 40.sp)
                    Spacer(Modifier.height(8.dp))
                    Text(s.message, color = MaterialTheme.colorScheme.error,
                        textAlign = TextAlign.Center)
                    Spacer(Modifier.height(16.dp))
                    Button(onClick = { viewModel.load(certId) }) { Text("Réessayer") }
                }

                is FlashcardUiState.Done -> DoneScreen(s.reviewed, onFinished)

                is FlashcardUiState.Active -> Column(
                    modifier = Modifier.fillMaxSize(),
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    // Progress
                    LinearProgressIndicator(
                        progress = { (s.index + 1f) / s.total },
                        modifier = Modifier.fillMaxWidth()
                    )
                    Text(
                        "${s.index + 1} / ${s.total} cartes",
                        style = MaterialTheme.typography.labelMedium,
                        color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.6f),
                        modifier = Modifier.padding(vertical = 8.dp)
                    )

                    // Flashcard flip
                    FlashcardView(
                        flashcard = s.flashcard,
                        onRate = { rating -> viewModel.review(s.flashcard.id, rating) },
                        modifier = Modifier.weight(1f)
                    )
                }
            }
        }
    }
}

@Composable
private fun FlashcardView(
    flashcard: Flashcard,
    onRate: (Int) -> Unit,
    modifier: Modifier = Modifier
) {
    var isFlipped by remember(flashcard.id) { mutableStateOf(false) }
    val rotation by animateFloatAsState(
        targetValue = if (isFlipped) 180f else 0f,
        animationSpec = tween(400, easing = FastOutSlowInEasing),
        label = "card_flip"
    )

    Column(
        modifier = modifier,
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.spacedBy(16.dp)
    ) {
        // Card
        Card(
            modifier = Modifier
                .fillMaxWidth()
                .weight(1f)
                .clickable { isFlipped = !isFlipped }
                .graphicsLayer {
                    rotationY = rotation
                    cameraDistance = 12f * density
                },
            elevation = CardDefaults.cardElevation(4.dp)
        ) {
            Box(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(24.dp)
                    .graphicsLayer { rotationY = if (rotation > 90f) 180f else 0f },
                contentAlignment = Alignment.Center
            ) {
                if (rotation <= 90f) {
                    // Front
                    Column(horizontalAlignment = Alignment.CenterHorizontally) {
                        Text(
                            text = flashcard.frontText,
                            style = MaterialTheme.typography.bodyLarge,
                            textAlign = TextAlign.Center,
                            lineHeight = 28.sp
                        )
                        Spacer(Modifier.height(16.dp))
                        Text(
                            "Appuyer pour voir la réponse →",
                            style = MaterialTheme.typography.labelSmall,
                            color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.4f)
                        )
                    }
                } else {
                    // Back
                    Column(horizontalAlignment = Alignment.CenterHorizontally) {
                        Text(
                            text = flashcard.backText,
                            style = MaterialTheme.typography.bodyLarge,
                            textAlign = TextAlign.Center
                        )
                        flashcard.codeExample?.let { code ->
                            Spacer(Modifier.height(12.dp))
                            Surface(
                                shape = MaterialTheme.shapes.small,
                                color = MaterialTheme.colorScheme.surfaceVariant,
                                modifier = Modifier.fillMaxWidth()
                            ) {
                                Text(
                                    text = code,
                                    fontFamily = FontFamily.Monospace,
                                    fontSize = 12.sp,
                                    modifier = Modifier.padding(12.dp)
                                )
                            }
                        }
                    }
                }
            }
        }

        // Rating buttons (visible only when flipped)
        if (isFlipped) {
            Text("Quelle facilité ?", fontWeight = FontWeight.SemiBold)
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(8.dp)
            ) {
                listOf(
                    Triple(0, "😰 Oublié",  MaterialTheme.colorScheme.error),
                    Triple(1, "😕 Difficile", MaterialTheme.colorScheme.tertiary),
                    Triple(3, "🙂 Correct",  MaterialTheme.colorScheme.secondary),
                    Triple(5, "😊 Parfait",  MaterialTheme.colorScheme.primary),
                ).forEach { (rating, label, color) ->
                    @Suppress("NAME_SHADOWING")
                    val color2 = color
                    OutlinedButton(
                        onClick = { onRate(rating) },
                        modifier = Modifier.weight(1f),
                        colors = ButtonDefaults.outlinedButtonColors(contentColor = color2)
                    ) {
                        Text(label, fontSize = 11.sp, textAlign = TextAlign.Center)
                    }
                }
            }
        }
    }
}

@Composable
private fun DoneScreen(reviewed: Int, onFinished: () -> Unit) {
    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text("🎉", fontSize = 64.sp)
        Spacer(Modifier.height(16.dp))
        Text("Session terminée !", style = MaterialTheme.typography.headlineMedium,
            fontWeight = FontWeight.Bold)
        Spacer(Modifier.height(8.dp))
        Text(
            if (reviewed > 0) "$reviewed cartes révisées aujourd'hui."
            else "Aucune carte à réviser pour l'instant.",
            color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.6f)
        )
        Spacer(Modifier.height(24.dp))
        Button(onClick = onFinished) { Text("Retour aux révisions") }
    }
}
