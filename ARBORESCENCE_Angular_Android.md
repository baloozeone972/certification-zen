# ARBORESCENCES FRONTEND — Angular 18 PWA + Android Kotlin/Compose
# =============================================================================

# =============================================================================
# ANGULAR 18 — certif-web
# =============================================================================

certif-web/
├── src/
│   ├── app/
│   │   ├── core/
│   │   │   ├── auth/
│   │   │   │   ├── auth.guard.ts              — CanActivate : vérifie JWT valide
│   │   │   │   ├── admin.guard.ts             — CanActivate : vérifie rôle ADMIN
│   │   │   │   ├── pro.guard.ts               — CanActivate : vérifie tier PRO/PACK
│   │   │   │   ├── auth.interceptor.ts        — HttpInterceptor : ajoute Bearer token + refresh automatique
│   │   │   │   └── auth.service.ts            — gestion tokens, login/logout, refreshToken, isAuthenticated signal
│   │   │   ├── models/                        — interfaces TypeScript miroir exact des DTOs Java
│   │   │   │   ├── certification.model.ts
│   │   │   │   ├── exam.model.ts
│   │   │   │   ├── question.model.ts
│   │   │   │   ├── user.model.ts
│   │   │   │   ├── learning.model.ts
│   │   │   │   ├── coaching.model.ts
│   │   │   │   ├── community.model.ts
│   │   │   │   ├── interview.model.ts
│   │   │   │   └── api-response.model.ts      — ApiResponse<T>, PageResponse<T>, ErrorResponse
│   │   │   ├── services/
│   │   │   │   ├── certification.service.ts   — GET /certifications, GET /certifications/{id}
│   │   │   │   ├── exam.service.ts            — CRUD sessions d'examen
│   │   │   │   ├── learning.service.ts        — cours, flashcards, plan adaptatif
│   │   │   │   ├── coaching.service.ts        — diagnostic, path, coach report, job market
│   │   │   │   ├── community.service.ts       — challenges, groupes, mur certifiés
│   │   │   │   ├── interview.service.ts       — sessions entretien
│   │   │   │   ├── ai.service.ts              — chat, explain, generate-flashcards
│   │   │   │   ├── user.service.ts            — profil, préférences, RGPD
│   │   │   │   ├── notification.service.ts    — notifications in-app
│   │   │   │   └── payment.service.ts         — Stripe Checkout redirect
│   │   │   └── websocket/
│   │   │       └── websocket.service.ts       — STOMP over SockJS : groupes + challenges live
│   │   │
│   │   ├── shared/
│   │   │   ├── components/
│   │   │   │   ├── question-card/
│   │   │   │   │   ├── question-card.component.ts       — affichage question + options radio
│   │   │   │   │   └── question-card.component.html
│   │   │   │   ├── progress-bar/
│   │   │   │   │   └── progress-bar.component.ts        — barre de progression animée avec %
│   │   │   │   ├── cert-badge/
│   │   │   │   │   └── cert-badge.component.ts          — badge certification coloré par type
│   │   │   │   ├── score-widget/
│   │   │   │   │   └── score-widget.component.ts        — affichage score circulaire avec couleur seuil
│   │   │   │   ├── flashcard-swipe/
│   │   │   │   │   └── flashcard-swipe.component.ts     — carte flip + swipe gauche/droite SM-2
│   │   │   │   ├── timer-widget/
│   │   │   │   │   └── timer-widget.component.ts        — décompte HH:MM:SS, rouge < 5min, signal Angular
│   │   │   │   ├── difficulty-badge/
│   │   │   │   │   └── difficulty-badge.component.ts    — badge easy/medium/hard coloré
│   │   │   │   ├── pagination/
│   │   │   │   │   └── pagination.component.ts          — composant de pagination réutilisable
│   │   │   │   └── theme-stats-chart/
│   │   │   │       └── theme-stats-chart.component.ts   — graphique barres par thème (Chart.js)
│   │   │   ├── pipes/
│   │   │   │   ├── duration.pipe.ts                     — seconds → HH:MM:SS
│   │   │   │   └── percentage.pipe.ts                   — 0.857 → "85.7%"
│   │   │   └── directives/
│   │   │       └── auto-focus.directive.ts              — focus automatique sur premier champ
│   │   │
│   │   └── features/
│   │       ├── home/                          — catalogue certifications + recherche
│   │       │   ├── home.component.ts          — liste certifications avec search signal, filtres, stats user
│   │       │   ├── home.routes.ts
│   │       │   └── certification-card.component.ts      — carte certification avec progression user
│   │       │
│   │       ├── onboarding/                    — bilan compétences + parcours certifications
│   │       │   ├── onboarding.component.ts    — stepper : profil → diagnostic → path recommandé
│   │       │   ├── diagnostic-exam.component.ts         — 20 questions diagnostic
│   │       │   ├── skill-map.component.ts               — visualisation carte de compétences radar
│   │       │   ├── cert-path.component.ts               — affichage parcours ordonné avec timeline
│   │       │   └── onboarding.routes.ts
│   │       │
│   │       ├── exam/                          — moteur d'examen (EXAM/FREE/REVISION)
│   │       │   ├── exam-config.component.ts   — config avant démarrage (thèmes, nb questions, durée)
│   │       │   ├── exam-engine.component.ts   — moteur principal : questions + timer + palette + navigation
│   │       │   ├── question-palette.component.ts        — grille numéros questions colorés (répondu/marqué/ignoré)
│   │       │   ├── revision-engine.component.ts         — mode révision avec correction immédiate
│   │       │   └── exam.routes.ts
│   │       │
│   │       ├── results/                       — résultats post-examen
│   │       │   ├── results.component.ts       — score global + statut RÉUSSI/ÉCHEC + durée
│   │       │   ├── theme-breakdown.component.ts         — tableau détail par thème
│   │       │   ├── wrong-questions.component.ts         — révision des erreurs avec explications
│   │       │   ├── export-pdf.component.ts              — bouton export PDF (PRO uniquement)
│   │       │   └── results.routes.ts
│   │       │
│   │       ├── history/                       — historique des sessions
│   │       │   ├── history.component.ts       — liste sessions avec filtres certification/mode/date
│   │       │   ├── session-detail.component.ts          — détail session archivée question par question
│   │       │   └── history.routes.ts
│   │       │
│   │       ├── learning/                      — cours + flashcards + SM-2 dashboard
│   │       │   ├── learning-dashboard.component.ts      — tableau de bord : dues, progression, recommandations
│   │       │   ├── course-list.component.ts             — liste fiches de cours par certification
│   │       │   ├── course-detail.component.ts           — fiche de cours Markdown rendu + navigation
│   │       │   ├── flashcard-deck.component.ts          — deck de flashcards du jour (SM-2)
│   │       │   ├── adaptive-plan.component.ts           — planning hebdomadaire adaptatif + prédiction score
│   │       │   └── learning.routes.ts
│   │       │
│   │       ├── coaching/                      — coach IA + parcours + job market
│   │       │   ├── coach-dashboard.component.ts         — rapport hebdo + alertes révision
│   │       │   ├── weekly-report.component.ts           — rapport coach formaté
│   │       │   ├── job-market.component.ts              — offres emploi + salaires par pays
│   │       │   └── coaching.routes.ts
│   │       │
│   │       ├── community/                     — challenges + groupes + mur certifiés
│   │       │   ├── challenge-list.component.ts          — challenges actifs + à venir
│   │       │   ├── challenge-engine.component.ts        — examen challenge avec timer compte à rebours live
│   │       │   ├── leaderboard.component.ts             — classement live WebSocket + badges
│   │       │   ├── group-list.component.ts              — groupes publics + création/rejoindre
│   │       │   ├── group-dashboard.component.ts         — tableau de bord groupe : progression membres, chat
│   │       │   ├── certified-wall.component.ts          — mur des certifiés filtrable
│   │       │   └── community.routes.ts
│   │       │
│   │       ├── interview/                     — simulateur d'entretien technique
│   │       │   ├── interview-config.component.ts        — choix certification + mode
│   │       │   ├── interview-engine.component.ts        — Q/R avec feedback IA en temps réel
│   │       │   ├── interview-report.component.ts        — rapport final par domaine
│   │       │   └── interview.routes.ts
│   │       │
│   │       ├── chat/                          — assistant IA conversationnel
│   │       │   ├── chat.component.ts          — interface messagerie avec historique session
│   │       │   └── chat.routes.ts
│   │       │
│   │       ├── profile/                       — profil + abonnement + préférences
│   │       │   ├── profile.component.ts       — infos compte + photo + stats globales
│   │       │   ├── subscription.component.ts  — plan actuel + upgrade Stripe Checkout
│   │       │   ├── preferences.component.ts   — thème, langue, notifications
│   │       │   ├── certified-wall-form.component.ts     — formulaire publication mur certifiés
│   │       │   └── profile.routes.ts
│   │       │
│   │       └── admin/                         — back-office admin
│   │           ├── questions-list.component.ts          — liste questions avec statut enrichissement
│   │           ├── question-enrich.component.ts         — enrichissement IA côte à côte original vs enrichi
│   │           ├── challenge-create.component.ts        — création/publication challenge
│   │           ├── import-questions.component.ts        — upload JSON bulk import
│   │           └── admin.routes.ts
│   │
│   ├── app.component.ts                       — shell : router-outlet + nav + theme signal
│   ├── app.config.ts                          — provideRouter, provideHttpClient, provideAnimations
│   └── app.routes.ts                          — routes racine avec lazy loading par feature
│
├── ngsw-config.json                           — Service Worker PWA : stratégie cache examens offline
├── manifest.webmanifest                       — PWA manifest : icônes, thème, orientation
├── angular.json
└── tsconfig.json

# =============================================================================
# ANDROID KOTLIN/COMPOSE — certif-android
# =============================================================================

certif-android/
├── app/
│   ├── src/main/java/com/certifapp/android/
│   │   ├── data/
│   │   │   ├── remote/
│   │   │   │   ├── api/
│   │   │   │   │   └── CertifAppApiService.kt       — Retrofit interface : tous les endpoints REST
│   │   │   │   ├── dto/                              — data classes Kotlin miroir des DTOs Java
│   │   │   │   │   ├── CertificationDto.kt
│   │   │   │   │   ├── ExamSessionDto.kt
│   │   │   │   │   ├── QuestionDto.kt
│   │   │   │   │   ├── UserDto.kt
│   │   │   │   │   ├── FlashcardDto.kt
│   │   │   │   │   └── CommunityDto.kt
│   │   │   │   └── interceptor/
│   │   │   │       └── AuthInterceptor.kt            — ajoute Bearer token + refresh automatique
│   │   │   │
│   │   │   ├── local/
│   │   │   │   ├── database/
│   │   │   │   │   ├── CertifAppDatabase.kt          — @Database Room : toutes les entités
│   │   │   │   │   └── Converters.kt                 — TypeConverters : List<String>, LocalDate
│   │   │   │   ├── entity/
│   │   │   │   │   ├── CertificationEntity.kt        — @Entity : cache certifications offline
│   │   │   │   │   ├── QuestionEntity.kt             — @Entity : questions téléchargées pour offline
│   │   │   │   │   ├── ExamSessionEntity.kt          — @Entity : sessions en cours (sync différée)
│   │   │   │   │   ├── FlashcardEntity.kt            — @Entity : flashcards offline
│   │   │   │   │   └── SM2ScheduleEntity.kt          — @Entity : planning SM-2 local
│   │   │   │   └── dao/
│   │   │   │       ├── CertificationDao.kt
│   │   │   │       ├── QuestionDao.kt
│   │   │   │       ├── ExamSessionDao.kt
│   │   │   │       ├── FlashcardDao.kt
│   │   │   │       └── SM2ScheduleDao.kt
│   │   │   │
│   │   │   └── repository/
│   │   │       ├── CertificationRepository.kt        — online/offline fallback : Room cache + Retrofit
│   │   │       ├── ExamRepository.kt
│   │   │       ├── FlashcardRepository.kt
│   │   │       ├── UserRepository.kt
│   │   │       └── CommunityRepository.kt
│   │   │
│   │   ├── domain/
│   │   │   ├── model/
│   │   │   │   ├── Certification.kt                  — data class domaine
│   │   │   │   ├── Question.kt
│   │   │   │   ├── ExamSession.kt
│   │   │   │   ├── Flashcard.kt
│   │   │   │   └── User.kt
│   │   │   └── usecase/
│   │   │       ├── StartExamUseCase.kt
│   │   │       ├── SubmitAnswerUseCase.kt
│   │   │       ├── GetFlashcardsDueUseCase.kt
│   │   │       ├── ReviewFlashcardUseCase.kt
│   │   │       └── SyncOfflineSessionsUseCase.kt     — sync sessions Room → API quand reconnecté
│   │   │
│   │   ├── presentation/
│   │   │   ├── navigation/
│   │   │   │   └── NavGraph.kt                       — NavHost Compose avec routes typées
│   │   │   │
│   │   │   ├── home/
│   │   │   │   ├── HomeScreen.kt                     — catalogue certifications + search
│   │   │   │   └── HomeViewModel.kt
│   │   │   │
│   │   │   ├── exam/
│   │   │   │   ├── ExamConfigScreen.kt               — config avant démarrage
│   │   │   │   ├── ExamEngineScreen.kt               — moteur examen avec timer + navigation
│   │   │   │   ├── ExamResultsScreen.kt              — résultats + stats par thème
│   │   │   │   └── ExamViewModel.kt
│   │   │   │
│   │   │   ├── learning/
│   │   │   │   ├── FlashcardScreen.kt                — deck swipe (gauche/droite + flip) SM-2
│   │   │   │   ├── CourseScreen.kt                   — fiche de cours Markdown rendu
│   │   │   │   ├── AdaptivePlanScreen.kt             — planning du jour + prédiction score
│   │   │   │   └── LearningViewModel.kt
│   │   │   │
│   │   │   ├── community/
│   │   │   │   ├── ChallengeScreen.kt                — challenge hebdomadaire + classement
│   │   │   │   ├── CertifiedWallScreen.kt            — mur des certifiés
│   │   │   │   └── CommunityViewModel.kt
│   │   │   │
│   │   │   ├── coaching/
│   │   │   │   ├── CoachDashboardScreen.kt           — rapport hebdo + alertes
│   │   │   │   ├── JobMarketScreen.kt                — marché emploi par pays
│   │   │   │   └── CoachViewModel.kt
│   │   │   │
│   │   │   ├── interview/
│   │   │   │   ├── InterviewScreen.kt                — simulation entretien Q/R avec feedback
│   │   │   │   └── InterviewViewModel.kt
│   │   │   │
│   │   │   ├── chat/
│   │   │   │   ├── ChatScreen.kt                     — interface messagerie assistant IA
│   │   │   │   └── ChatViewModel.kt
│   │   │   │
│   │   │   └── profile/
│   │   │       ├── ProfileScreen.kt                  — infos + abonnement + préférences
│   │   │       └── ProfileViewModel.kt
│   │   │
│   │   ├── di/
│   │   │   ├── NetworkModule.kt                      — @Module Hilt : Retrofit, OkHttp, Gson
│   │   │   ├── DatabaseModule.kt                     — @Module Hilt : Room database + DAOs
│   │   │   ├── RepositoryModule.kt                   — @Module Hilt : bindings repositories
│   │   │   └── UseCaseModule.kt                      — @Module Hilt : use cases
│   │   │
│   │   └── worker/
│   │       ├── SyncWorker.kt                         — WorkManager : sync sessions offline → API
│   │       └── CoachNotificationWorker.kt            — WorkManager : notification rapport lundi matin
│   │
│   └── build.gradle.kts
