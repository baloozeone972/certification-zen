// certif-parent/certif-android/app/src/main/java/com/certifapp/android/ui/theme/Theme.kt
package com.certifapp.android.ui.theme

import android.app.Activity
import android.os.Build
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.SideEffect
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalView
import androidx.core.view.WindowCompat

private val CertifLightColors = lightColorScheme(
    primary = Color(0xFF2C3E50),
    onPrimary = Color.White,
    primaryContainer = Color(0xFF3498DB),
    secondary = Color(0xFF3498DB),
    onSecondary = Color.White,
    tertiary = Color(0xFFE74C3C),
    background = Color(0xFFF8F9FA),
    surface = Color.White,
    error = Color(0xFFE74C3C)
)

private val CertifDarkColors = darkColorScheme(
    primary = Color(0xFF3498DB),
    onPrimary = Color.White,
    secondary = Color(0xFF5DADE2),
    onSecondary = Color.White,
    background = Color(0xFF1A1A2E),
    surface = Color(0xFF16213E),
    error = Color(0xFFE74C3C)
)

/**
 * CertifApp Material 3 theme with dynamic color support (Android 12+).
 */
@Composable
fun CertifAppTheme(
    darkTheme: Boolean = isSystemInDarkTheme(),
    dynamicColor: Boolean = true,
    content: @Composable () -> Unit
) {
    val colorScheme = when {
        dynamicColor && Build.VERSION.SDK_INT >= Build.VERSION_CODES.S -> {
            val ctx = LocalContext.current
            if (darkTheme) dynamicDarkColorScheme(ctx) else dynamicLightColorScheme(ctx)
        }

        darkTheme -> CertifDarkColors
        else -> CertifLightColors
    }

    val view = LocalView.current
    if (!view.isInEditMode) {
        SideEffect {
            val window = (view.context as Activity).window
            window.statusBarColor = colorScheme.primary.toArgb()
            WindowCompat.getInsetsController(window, view)
                .isAppearanceLightStatusBars = !darkTheme
        }
    }

    MaterialTheme(
        colorScheme = colorScheme,
        typography = Typography,
        content = content
    )
}
