// certif-parent/certif-android/app/src/main/java/com/certifapp/android/MainActivity.kt
package com.certifapp.android

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.ui.Modifier
import com.certifapp.android.ui.navigation.CertifAppNavGraph
import com.certifapp.android.ui.theme.CertifAppTheme
import dagger.hilt.android.AndroidEntryPoint

/**
 * Single Activity — Compose navigation handles all screens.
 */
@AndroidEntryPoint
class MainActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            CertifAppTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    CertifAppNavGraph()
                }
            }
        }
    }
}
