# ARBORESCENCE iOS — certif-ios
<!-- ARBORESCENCE_iOS.md -->
# =============================================================================
# iOS Swift/SwiftUI — certif-ios
# =============================================================================

certif-ios/
├── Package.swift                              — SPM dependencies: MarkdownUI, KeychainAccess, Lottie
├── Gemfile                                    — Ruby deps: fastlane, xcpretty
├── README.md                                  — Documentation module complet
├── CHANGELOG.md                               — Historique des versions
│
├── fastlane/
│   ├── Fastfile                               — Lanes: beta (TestFlight), release (App Store), tests
│   └── Appfile                                — App identifier, Team ID, Apple ID
│
├── .github/
│   └── workflows/
│       └── ios.yml                            — CI/CD: build + test + TestFlight sur push main
│
└── CertifApp/
    ├── CertifAppApp.swift                     — @main : ModelContainer SwiftData + DIContainer inject
    ├── Info.plist                             — BGTaskScheduler, permissions, URL schemes, ATS
    │
    ├── Data/
    │   ├── Remote/
    │   │   ├── APIClient.swift                — URLSession async/await : JWT inject + retry + error mapping
    │   │   └── DTO/
    │   │       └── CertifDTOs.swift           — Tous les DTOs Codable miroir des DTOs Java
    │   │
    │   ├── Local/
    │   │   ├── KeychainService.swift          — Stockage sécurisé JWT (KeychainAccess SPM)
    │   │   └── SwiftDataEntities.swift        — @Model entities (= Room @Entity) : offline persistence
    │   │       ├── CertificationEntity        — Cache certifications
    │   │       ├── QuestionEntity             — Questions offline
    │   │       ├── ExamSessionEntity          — Sessions en attente de sync
    │   │       ├── FlashcardEntity            — Flashcards offline
    │   │       ├── SM2ScheduleEntity          — Planning SM-2 local
    │   │       └── PendingSyncEntity          — File d'actions à synchroniser
    │   │
    │   ├── Repository/
    │   │   └── Repositories.swift             — Implémentations concrètes (online + offline fallback)
    │   │       ├── CertificationRepository    — fetchAll() : API → SwiftData cache
    │   │       ├── ExamRepository             — start/submit/complete + queue offline
    │   │       ├── LearningRepository         — courses, flashcards SM-2, plan adaptatif
    │   │       ├── UserRepository             — login, register, profile, preferences
    │   │       ├── CommunityRepository        — challenges, certified wall
    │   │       ├── CoachingRepository         — diagnostic, rapport, job market
    │   │       ├── AIRepository               — chat, explain, generate flashcards
    │   │       └── PaymentRepository          — subscription status, Apple receipt validation
    │   │
    │   └── Payment/
    │       └── StoreKitService.swift          — StoreKit 2 : abonnement Pro + Pack (= Google Play Billing)
    │           ├── loadProducts()             — Chargement App Store Connect
    │           ├── purchase(_:)              — Achat avec vérification signature
    │           ├── restorePurchases()         — Restauration (obligation App Store)
    │           └── updateEntitlements()       — Vérification droits depuis Transaction.currentEntitlements
    │
    ├── Domain/
    │   ├── Models/
    │   │   └── DomainModels.swift             — Value types Swift (= Java Records certif-domain)
    │   │       ├── Certification + ExamType
    │   │       ├── Question + QuestionOption + DifficultyLevel
    │   │       ├── ExamSession + ThemeStats + ExamMode + SessionStatus
    │   │       ├── AppUser + UserRole + SubscriptionTier
    │   │       ├── Flashcard
    │   │       └── SM2Schedule
    │   │
    │   └── Port/
    │       └── RepositoryProtocols.swift      — Interfaces protocols (= Java port/output interfaces)
    │           ├── CertificationRepositoryProtocol
    │           ├── ExamRepositoryProtocol
    │           ├── LearningRepositoryProtocol
    │           ├── UserRepositoryProtocol
    │           ├── CommunityRepositoryProtocol
    │           ├── CoachingRepositoryProtocol
    │           ├── AIRepositoryProtocol
    │           ├── PaymentRepositoryProtocol
    │           ├── SM2Calculator              — Algorithme SM-2 pur (= Java SM2Algorithm.java)
    │           └── FreemiumGuard              — Règles freemium client (= Java FreemiumGuardService)
    │
    ├── DI/
    │   └── DIContainer.swift                  — Container DI manuel (= Hilt @Module Android)
    │       ├── DIContainer (@Observable)      — Factory de tous les ViewModels + repositories
    │       ├── AuthService (@Observable)       — État auth global : login/register/logout/currentUser
    │       └── ThemeManager (@Observable)      — Thème clair/sombre/système
    │
    ├── Background/
    │   ├── SyncBackgroundTask.swift           — BGTaskScheduler (= WorkManager SyncWorker.kt)
    │   │   ├── registerAll()                  — Enregistrement au démarrage
    │   │   ├── scheduleSync()                 — Prochaine exécution dans 15 min min
    │   │   ├── flushPendingSync()             — Flush PendingSyncEntity → API
    │   │   └── NetworkMonitor                 — Détection reconnexion réseau
    │   │
    │   └── NotificationService.swift          — UNUserNotificationCenter (= CoachNotificationWorker.kt)
    │       ├── scheduleWeeklyCoachReport()    — Lundi 08:00 récurrent
    │       ├── scheduleFlashcardReminder()    — Quotidien à heure configurable
    │       ├── scheduleChallengeReminder()    — 24h avant fin challenge
    │       ├── scheduleStreakReminder()        — 48h d'inactivité
    │       └── deep link handlers             — Navigation depuis notification tap
    │
    └── Presentation/
        ├── Navigation/
        │   └── RootView.swift                 — Auth gate + AppTabView (= NavGraph.kt)
        │       └── AppTabView                 — 5 tabs : Accueil, Apprendre, Communauté, Coach, Profil
        │
        ├── Auth/
        │   └── AuthView.swift                 — Login + Register avec validation inline
        │
        ├── Home/
        │   └── HomeView.swift                 — Catalogue certifications (grid) + search (= HomeScreen.kt)
        │
        ├── Exam/
        │   └── ExamViews.swift                — Exam flow complet (= ExamConfig/Engine/ResultsScreen.kt)
        │       ├── ExamConfigView             — Sélection mode/thème/nb questions + freemium check
        │       ├── ExamEngineView             — Timer + options + validation + explication
        │       └── ExamResultsView            — Score radial + stats par thème
        │
        ├── Learning/
        │   └── LearningViews.swift            — (= FlashcardScreen + CourseScreen + AdaptivePlanScreen)
        │       ├── LearningHubView            — Hub navigation
        │       ├── FlashcardView              — Swipe left/right + flip + SM-2 rating (0-5)
        │       ├── CourseView                 — Rendu Markdown (MarkdownUI SPM)
        │       └── AdaptivePlanView           — Score prédit + plan du jour + thèmes faibles
        │
        ├── Community/
        │   └── CommunityViews.swift           — (= ChallengeScreen + CertifiedWallScreen)
        │       ├── ChallengeView              — Challenge semaine + classement pagination
        │       └── CertifiedWallView          — Infinite scroll profils certifiés
        │
        ├── Coach/
        │   └── CoachViews.swift               — Coach + Interview + Chat + Profile
        │       ├── CoachView                  — Rapport hebdo + job market (= CoachDashboardScreen)
        │       ├── InterviewView              — Simulation entretien Q/R + feedback IA
        │       ├── ChatView                   — Messagerie assistant IA (= ChatScreen.kt)
        │       └── ProfileView                — Profil + abonnement + préférences + déconnexion
        │
        ├── History/
        │   └── HistoryView.swift              — Historique sessions + filtres + pagination
        │
        ├── Payment/
        │   └── PaywallView.swift              — Offres Pro + Pack + StoreKit 2 purchase flow
        │
        └── Shared/
            └── SharedComponents.swift         — Composants réutilisables
                ├── ErrorBannerView
                ├── ShimmeringModifier
                ├── LoadingOverlay
                ├── EmptyStateView
                ├── ProBadge
                ├── DifficultyBadge
                └── ContentView

# =============================================================================
# Tests
# =============================================================================

CertifAppTests/
├── Domain/
│   └── SM2CalculatorTests.swift               — 12 tests algo SM-2 + FreemiumGuard (15 tests)
├── Presentation/
│   └── ExamEngineViewModelTests.swift         — Tests ViewModel avec mock repositories (15 tests)
└── Data/
    └── APIClientTests.swift                   — Tests APIClient via URLProtocol stubbing (8 tests)

# Total : ~38 tests unitaires, 0 dépendances réseau

# =============================================================================
# Comparaison Android ↔ iOS
# =============================================================================

# Android (Kotlin/Compose/Hilt)        iOS (Swift/SwiftUI)
# ─────────────────────────────────    ─────────────────────────────────
# @HiltViewModel                   ↔   @Observable ViewModel
# @Inject constructor              ↔   DIContainer.makeXxxViewModel()
# StateFlow<UiState>               ↔   @Observable properties
# Room @Entity / @Dao              ↔   SwiftData @Model
# WorkManager                      ↔   BGTaskScheduler
# Google Play Billing              ↔   StoreKit 2
# EncryptedSharedPreferences       ↔   Keychain (KeychainAccess)
# Retrofit                         ↔   URLSession async/await
# Jetpack Compose                  ↔   SwiftUI
# Hilt @Module                     ↔   DIContainer (manuel)
# NavHost + NavGraph               ↔   NavigationStack + navigationDestination
# LazyColumn                       ↔   List / LazyVStack
# BottomNavigation                 ↔   TabView
# Material3 ColorScheme            ↔   SwiftUI .colorScheme + tint
