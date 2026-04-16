// certif-parent/certif-android/app/src/main/java/com/certifapp/android/ui/screen/learning/FlashcardDeckScreen.kt
package com.certifapp.android.ui.screen.learning

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

/** Flashcards — implémentation complète Phase 4+ */
@Composable
fun FlashcardDeckScreen(certId: String, onFinished: () -> Unit) {
    Box(Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            Text("Flashcards", fontSize = 22.sp, fontWeight = FontWeight.Bold)
            Spacer(Modifier.height(12.dp))
            Text("Disponible prochainement",
                color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.6f))
        }
    }
}
