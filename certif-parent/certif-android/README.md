# certif-android

Module **Android** — Kotlin + Jetpack Compose + Hilt.

## Prérequis

- Android Studio Iguana (2024.1+)
- JDK 21
- Android SDK API 35
- Gradle 8.5

## Ouvrir le projet

```
File → Open → certification-zen/certif-parent/certif-android
```

## Architecture

- **Clean Architecture MVVM** (domain / data / ui)
- **Hilt** pour l'injection de dépendances
- **Room** pour la persistence offline-first
- **Retrofit + kotlinx.serialization** pour le réseau
- **WorkManager** pour la sync offline
- **Google Play Billing 7.x** pour les achats in-app

## Builds

```bash
# Debug
./gradlew assembleDebug

# Release (nécessite keystore)
./gradlew assembleRelease

# Tests
./gradlew test
```

## Flavors (à venir)

| Flavor | Usage |
|---|---|
| `dev` | Pointe sur http://10.0.2.2:8080 (émulateur) |
| `prod` | Pointe sur https://api.certifapp.com |
