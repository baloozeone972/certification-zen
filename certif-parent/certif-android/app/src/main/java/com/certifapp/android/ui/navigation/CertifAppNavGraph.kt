// certif-parent/certif-android/app/src/main/java/com/certifapp/android/ui/navigation/CertifAppNavGraph.kt
package com.certifapp.android.ui.navigation

import androidx.compose.runtime.Composable
import androidx.navigation.*
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.certifapp.android.ui.screen.auth.LoginScreen
import com.certifapp.android.ui.screen.auth.RegisterScreen
import com.certifapp.android.ui.screen.exam.ExamEngineScreen
import com.certifapp.android.ui.screen.exam.ExamSetupScreen
import com.certifapp.android.ui.screen.home.HomeScreen
import com.certifapp.android.ui.screen.learning.FlashcardDeckScreen
import com.certifapp.android.ui.screen.profile.ProfileScreen
import com.certifapp.android.ui.screen.results.ResultsScreen

/** Sealed class for type-safe navigation routes. */
sealed class Screen(val route: String) {
    object Home          : Screen("home")
    object Login         : Screen("auth/login")
    object Register      : Screen("auth/register")
    object ExamSetup     : Screen("exam/setup/{certId}") {
        fun createRoute(certId: String) = "exam/setup/$certId"
    }
    object ExamEngine    : Screen("exam/session/{sessionId}") {
        fun createRoute(sessionId: String) = "exam/session/$sessionId"
    }
    object Results       : Screen("results/{sessionId}") {
        fun createRoute(sessionId: String) = "results/$sessionId"
    }
    object FlashcardDeck : Screen("learning/flashcards/{certId}") {
        fun createRoute(certId: String) = "learning/flashcards/$certId"
    }
    object Profile       : Screen("profile")
}

/**
 * Root navigation graph for CertifApp.
 * Single NavController — screens push/pop on the back stack.
 */
@Composable
fun CertifAppNavGraph() {
    val navController = rememberNavController()

    NavHost(navController = navController, startDestination = Screen.Home.route) {

        composable(Screen.Home.route) {
            HomeScreen(
                onNavigateToExamSetup  = { certId -> navController.navigate(Screen.ExamSetup.createRoute(certId)) },
                onNavigateToLogin      = { navController.navigate(Screen.Login.route) },
                onNavigateToProfile    = { navController.navigate(Screen.Profile.route) }
            )
        }

        composable(Screen.Login.route) {
            LoginScreen(
                onLoginSuccess  = { navController.navigate(Screen.Home.route) { popUpTo(0) } },
                onNavigateToRegister = { navController.navigate(Screen.Register.route) }
            )
        }

        composable(Screen.Register.route) {
            RegisterScreen(
                onRegisterSuccess = { navController.navigate(Screen.Home.route) { popUpTo(0) } },
                onNavigateToLogin = { navController.navigate(Screen.Login.route) }
            )
        }

        composable(
            Screen.ExamSetup.route,
            arguments = listOf(navArgument("certId") { type = NavType.StringType })
        ) { back ->
            ExamSetupScreen(
                certId = back.arguments?.getString("certId") ?: "",
                onSessionStarted = { sessionId -> navController.navigate(Screen.ExamEngine.createRoute(sessionId)) },
                onBack = { navController.popBackStack() }
            )
        }

        composable(
            Screen.ExamEngine.route,
            arguments = listOf(navArgument("sessionId") { type = NavType.StringType })
        ) { back ->
            ExamEngineScreen(
                sessionId = back.arguments?.getString("sessionId") ?: "",
                onExamFinished = { sessionId -> navController.navigate(Screen.Results.createRoute(sessionId)) { popUpTo(Screen.Home.route) } }
            )
        }

        composable(
            Screen.Results.route,
            arguments = listOf(navArgument("sessionId") { type = NavType.StringType })
        ) { back ->
            ResultsScreen(
                sessionId = back.arguments?.getString("sessionId") ?: "",
                onBack = { navController.navigate(Screen.Home.route) { popUpTo(0) } }
            )
        }

        composable(
            Screen.FlashcardDeck.route,
            arguments = listOf(navArgument("certId") { type = NavType.StringType })
        ) { back ->
            FlashcardDeckScreen(
                certId = back.arguments?.getString("certId") ?: "",
                onFinished = { navController.popBackStack() }
            )
        }

        composable(Screen.Profile.route) {
            ProfileScreen(onBack = { navController.popBackStack() })
        }
    }
}
