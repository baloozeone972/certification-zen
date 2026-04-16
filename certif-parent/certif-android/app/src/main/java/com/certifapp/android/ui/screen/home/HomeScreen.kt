// certif-parent/certif-android/app/src/main/java/com/certifapp/android/ui/screen/home/HomeScreen.kt
package com.certifapp.android.ui.screen.home

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.AccountCircle
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.hilt.navigation.compose.hiltViewModel
import com.certifapp.android.domain.model.Certification
import com.certifapp.android.ui.components.CenteredLoading
import com.certifapp.android.ui.components.ErrorState

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun HomeScreen(
    onNavigateToExamSetup: (certId: String) -> Unit,
    onNavigateToLogin: () -> Unit,
    onNavigateToProfile: () -> Unit,
    viewModel: HomeViewModel = hiltViewModel()
) {
    val uiState by viewModel.uiState.collectAsState()

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("🎓 CertifApp", fontWeight = FontWeight.Bold) },
                actions = {
                    IconButton(onClick = onNavigateToProfile) {
                        Icon(Icons.Default.AccountCircle, contentDescription = "Profil")
                    }
                },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor = MaterialTheme.colorScheme.primary,
                    titleContentColor = MaterialTheme.colorScheme.onPrimary,
                    actionIconContentColor = MaterialTheme.colorScheme.onPrimary
                )
            )
        }
    ) { padding ->
        when (val state = uiState) {
            is HomeUiState.Loading -> CenteredLoading()
            is HomeUiState.Error   -> ErrorState(state.message) { viewModel.loadCertifications() }
            is HomeUiState.Success -> CertificationList(
                certifications = state.certifications,
                onCertClick    = onNavigateToExamSetup,
                modifier       = Modifier.padding(padding)
            )
        }
    }
}

@Composable
private fun CertificationList(
    certifications: List<Certification>,
    onCertClick: (String) -> Unit,
    modifier: Modifier = Modifier
) {
    LazyColumn(
        modifier            = modifier.fillMaxSize(),
        contentPadding      = PaddingValues(16.dp),
        verticalArrangement = Arrangement.spacedBy(12.dp)
    ) {
        item {
            Text("Certifications disponibles", fontSize = 20.sp, fontWeight = FontWeight.Bold,
                modifier = Modifier.padding(bottom = 4.dp))
        }
        items(certifications) { cert ->
            CertificationCard(cert = cert, onClick = { onCertClick(cert.id) })
        }
    }
}

@Composable
private fun CertificationCard(cert: Certification, onClick: () -> Unit) {
    Card(
        modifier  = Modifier.fillMaxWidth().clickable(onClick = onClick),
        elevation = CardDefaults.cardElevation(2.dp)
    ) {
        Column(modifier = Modifier.padding(16.dp)) {
            Text(text = cert.name, fontWeight = FontWeight.SemiBold, fontSize = 16.sp)
            Text(text = cert.code, fontSize = 13.sp,
                color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.6f),
                modifier = Modifier.padding(top = 2.dp, bottom = 8.dp))
            Row(horizontalArrangement = Arrangement.spacedBy(16.dp)) {
                InfoChip("${cert.totalQuestions} questions")
                InfoChip("${cert.passingScore}% requis")
                InfoChip("${cert.examDurationMin} min")
            }
        }
    }
}

@Composable
private fun InfoChip(text: String) {
    Surface(
        shape = MaterialTheme.shapes.small,
        color = MaterialTheme.colorScheme.surfaceVariant
    ) {
        Text(text = text, fontSize = 11.sp, modifier = Modifier.padding(horizontal = 8.dp, vertical = 4.dp))
    }
}
