# certif-ios — CertifApp iOS
<!-- certif-ios/README.md -->

## Responsabilité

Module iOS natif de CertifApp. Application SwiftUI ciblant iOS 17+ avec les mêmes
fonctionnalités que l'application Android : examens de certification, flashcards SM-2,
coaching adaptatif, communauté, assistant IA, mode offline complet et achat in-app
via StoreKit 2 (App Store Connect).

## Stack technique

| Composant        | Technologie                                  |
|------------------|----------------------------------------------|
| UI               | SwiftUI 5 + Swift Concurrency (async/await)  |
| Architecture     | MVVM + Clean Architecture (Data/Domain/Presentation) |
| DI               | Swift `@EnvironmentObject` + `DIContainer`   |
| Réseau           | URLSession + Async/Await                     |
| Persistance      | SwiftData (iOS 17+) — équivalent Room        |
| Authentification | JWT stocké dans Keychain                     |
| Paiement         | StoreKit 2 (abonnement + achat unique)       |
| Notifications    | UserNotifications + BGTaskScheduler         |
| Tests            | XCTest + Swift Testing framework             |
| CI/CD            | GitHub Actions → Fastlane → TestFlight       |
| Min iOS          | iOS 17.0                                     |

## Architecture des couches

```
certif-ios/CertifApp/
├── Data/          — API REST (URLSession), DTOs, SwiftData entities, repositories
├── Domain/        — Modèles métier, Use Cases, interfaces Repository
└── Presentation/  — Vues SwiftUI, ViewModels (@Observable)
```

## Pré-requis

- Xcode 15.4+
- iOS 17.0+ (cible de déploiement)
- Swift 5.10+
- Un compte Apple Developer (pour StoreKit 2 et push notifications)
- Accès au backend `certif-api-rest` (URL configurée dans `Config.xcconfig`)

## Configuration

Créer `certif-ios/Config.xcconfig` (non versionné) :

```
API_BASE_URL = https://api.certifapp.com
STRIPE_PUBLISHABLE_KEY = pk_live_xxx
```

Pour le développement local :

```
API_BASE_URL = http://localhost:8080
STRIPE_PUBLISHABLE_KEY = pk_test_xxx
```

## Fonctionnalités

| Feature                     | Statut | Équivalent Android              |
|-----------------------------|--------|---------------------------------|
| Catalogue certifications    | ✅      | HomeScreen.kt                   |
| Examen (timer + navigation) | ✅      | ExamEngineScreen.kt             |
| Résultats + stats           | ✅      | ExamResultsScreen.kt            |
| Flashcards SM-2 (swipe)     | ✅      | FlashcardScreen.kt              |
| Cours Markdown              | ✅      | CourseScreen.kt                 |
| Plan adaptatif              | ✅      | AdaptivePlanScreen.kt           |
| Challenge hebdomadaire      | ✅      | ChallengeScreen.kt              |
| Mur des certifiés           | ✅      | CertifiedWallScreen.kt          |
| Coach dashboard             | ✅      | CoachDashboardScreen.kt         |
| Marché emploi               | ✅      | JobMarketScreen.kt              |
| Simulation entretien        | ✅      | InterviewScreen.kt              |
| Chat assistant IA           | ✅      | ChatScreen.kt                   |
| Profil + abonnement         | ✅      | ProfileScreen.kt                |
| Mode offline (SwiftData)    | ✅      | Room + SyncWorker               |
| Sync différée               | ✅      | SyncWorker (WorkManager)        |
| Achat in-app (StoreKit 2)   | ✅      | Google Play Billing             |
| Notifications locales       | ✅      | CoachNotificationWorker         |
| Thème clair/sombre          | ✅      | Material3 DarkTheme             |

## Build & Run

```bash
# Ouvrir dans Xcode
open certif-ios/CertifApp.xcodeproj

# Build en ligne de commande (CI)
xcodebuild -scheme CertifApp -destination 'platform=iOS Simulator,name=iPhone 15 Pro' build

# Tests
xcodebuild test -scheme CertifApp -destination 'platform=iOS Simulator,name=iPhone 15 Pro'
```

## Déploiement via Fastlane

```bash
cd certif-ios
bundle exec fastlane beta   # Déploie sur TestFlight
bundle exec fastlane release # Déploie sur l'App Store
```

## Développeur responsable

**Développeur iOS senior** — Swift 5.10, SwiftUI 5, SwiftData, StoreKit 2.
Aucune connaissance du backend Java requise (consommation REST uniquement).

## Modèle freemium (identique Android)

| Tier    | Accès                                                      | Prix         |
|---------|------------------------------------------------------------|--------------|
| FREE    | 2 examens/certification, 20 questions max                  | Gratuit      |
| PRO     | Illimité + historique + offline + IA                       | 9,99 €/mois  |
| PACK    | Accès permanent à une certification                        | 4,99 €/achat |

Les entitlements StoreKit sont vérifiés côté serveur via le webhook `/api/v1/payments/apple`.
