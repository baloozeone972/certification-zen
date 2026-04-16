// certif-parent/certif-android/app/src/main/java/com/certifapp/android/ui/screen/auth/LoginScreen.kt
package com.certifapp.android.ui.screen.auth

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.hilt.navigation.compose.hiltViewModel

@Composable
fun LoginScreen(
    onLoginSuccess: () -> Unit,
    onNavigateToRegister: () -> Unit,
    viewModel: AuthViewModel = hiltViewModel()
) {
    val uiState by viewModel.uiState.collectAsState()
    var email by remember { mutableStateOf("") }
    var password by remember { mutableStateOf("") }

    LaunchedEffect(uiState) {
        if (uiState is AuthUiState.Success) onLoginSuccess()
    }

    Column(
        modifier            = Modifier.fillMaxSize().padding(24.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text("Connexion", fontSize = 28.sp, fontWeight = FontWeight.Bold,
            modifier = Modifier.padding(bottom = 32.dp))

        OutlinedTextField(value = email, onValueChange = { email = it },
            label = { Text("Email") }, modifier = Modifier.fillMaxWidth(),
            singleLine = true)
        Spacer(Modifier.height(12.dp))
        OutlinedTextField(value = password, onValueChange = { password = it },
            label = { Text("Mot de passe") }, modifier = Modifier.fillMaxWidth(),
            visualTransformation = PasswordVisualTransformation(), singleLine = true)

        if (uiState is AuthUiState.Error) {
            Text((uiState as AuthUiState.Error).message,
                color = MaterialTheme.colorScheme.error,
                modifier = Modifier.padding(top = 8.dp))
        }

        Spacer(Modifier.height(24.dp))
        Button(
            onClick = { viewModel.login(email, password) },
            modifier = Modifier.fillMaxWidth().height(50.dp),
            enabled = email.isNotBlank() && password.length >= 8 && uiState !is AuthUiState.Loading
        ) {
            if (uiState is AuthUiState.Loading) CircularProgressIndicator(Modifier.size(20.dp), strokeWidth = 2.dp)
            else Text("Se connecter")
        }
        TextButton(onClick = onNavigateToRegister) { Text("Créer un compte gratuit") }
    }
}
