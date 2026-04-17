// certif-parent/certif-android/app/src/main/java/com/certifapp/android/ui/components/SharedComponents.kt
package com.certifapp.android.ui.components

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

/** Reusable difficulty chip: Easy (green), Medium (orange), Hard (red). */
@Composable
fun DifficultyChip(difficulty: String, modifier: Modifier = Modifier) {
    val (label, color) = when (difficulty.lowercase()) {
        "easy" -> "Facile" to Color(0xFF27AE60)
        "hard" -> "Difficile" to Color(0xFFE74C3C)
        else -> "Moyen" to Color(0xFFF39C12)
    }
    Surface(
        modifier = modifier,
        shape = RoundedCornerShape(12.dp),
        color = color.copy(alpha = 0.15f)
    ) {
        Text(
            text = label,
            color = color,
            fontWeight = FontWeight.Bold,
            fontSize = 11.sp,
            modifier = Modifier.padding(horizontal = 8.dp, vertical = 3.dp)
        )
    }
}

/** Loading spinner centered in available space. */
@Composable
fun CenteredLoading(message: String = "Chargement...") {
    Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            CircularProgressIndicator(modifier = Modifier.size(40.dp))
            Spacer(Modifier.height(12.dp))
            Text(text = message, color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.6f))
        }
    }
}

/** Error state with retry button. */
@Composable
fun ErrorState(message: String, onRetry: () -> Unit) {
    Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
        Column(horizontalAlignment = Alignment.CenterHorizontally, modifier = Modifier.padding(32.dp)) {
            Text("⚠️", fontSize = 40.sp)
            Spacer(Modifier.height(8.dp))
            Text(
                text = message,
                color = MaterialTheme.colorScheme.error,
                textAlign = androidx.compose.ui.text.style.TextAlign.Center
            )
            Spacer(Modifier.height(16.dp))
            Button(onClick = onRetry) { Text("Réessayer") }
        }
    }
}

/** Score ring indicator. */
@Composable
fun ScoreIndicator(percentage: Double, passed: Boolean, modifier: Modifier = Modifier) {
    val color = if (passed) Color(0xFF27AE60) else Color(0xFFE74C3C)
    Surface(modifier = modifier, shape = RoundedCornerShape(8.dp), color = color.copy(alpha = 0.1f)) {
        Column(
            horizontalAlignment = Alignment.CenterHorizontally,
            modifier = Modifier.padding(16.dp)
        ) {
            Text(
                text = String.format("%.1f%%", percentage),
                fontSize = 32.sp,
                fontWeight = FontWeight.ExtraBold,
                color = color
            )
            Text(
                text = if (passed) "RÉUSSI ✓" else "ÉCHEC ✗",
                color = color,
                fontWeight = FontWeight.Bold,
                fontSize = 12.sp
            )
        }
    }
}
