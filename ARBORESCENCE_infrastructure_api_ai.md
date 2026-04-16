# certif-infrastructure — Arborescence complète
# Développeur responsable : Senior Java + DBA (JPA, Flyway, PostgreSQL)

certif-infrastructure/src/main/java/com/certifapp/infrastructure/
│
├── persistence/
│   ├── entity/   (entités JPA — séparées des Records domain)
│   │   ├── UserEntity.java
│   │   ├── UserPreferencesEntity.java
│   │   ├── CertificationEntity.java
│   │   ├── CertificationThemeEntity.java
│   │   ├── QuestionEntity.java
│   │   ├── QuestionOptionEntity.java
│   │   ├── ExamSessionEntity.java
│   │   ├── UserAnswerEntity.java
│   │   ├── CourseEntity.java
│   │   ├── FlashcardEntity.java
│   │   ├── UserFlashcardProgressEntity.java
│   │   ├── SM2ScheduleEntity.java
│   │   ├── WeeklyChallengeEntity.java
│   │   ├── ChallengeParticipationEntity.java
│   │   ├── StudyGroupEntity.java
│   │   ├── StudyGroupMemberEntity.java
│   │   ├── CertifiedWallProfileEntity.java
│   │   ├── DiagnosticResultEntity.java
│   │   ├── CertificationPathEntity.java
│   │   ├── WeeklyCoachReportEntity.java
│   │   ├── JobMarketDataEntity.java
│   │   ├── InterviewSessionEntity.java
│   │   ├── InterviewAnswerEntity.java
│   │   ├── NotificationEntity.java
│   │   └── PushSubscriptionEntity.java
│   │
│   ├── repository/   (Spring Data JPA — interfaces)
│   │   ├── UserJpaRepository.java
│   │   ├── UserPreferencesJpaRepository.java
│   │   ├── CertificationJpaRepository.java
│   │   ├── CertificationThemeJpaRepository.java
│   │   ├── QuestionJpaRepository.java
│   │   ├── QuestionOptionJpaRepository.java
│   │   ├── ExamSessionJpaRepository.java
│   │   ├── UserAnswerJpaRepository.java
│   │   ├── CourseJpaRepository.java
│   │   ├── FlashcardJpaRepository.java
│   │   ├── UserFlashcardProgressJpaRepository.java
│   │   ├── SM2ScheduleJpaRepository.java
│   │   ├── WeeklyChallengeJpaRepository.java
│   │   ├── ChallengeParticipationJpaRepository.java
│   │   ├── StudyGroupJpaRepository.java
│   │   ├── StudyGroupMemberJpaRepository.java
│   │   ├── CertifiedWallProfileJpaRepository.java
│   │   ├── DiagnosticResultJpaRepository.java
│   │   ├── CertificationPathJpaRepository.java
│   │   ├── WeeklyCoachReportJpaRepository.java
│   │   ├── JobMarketDataJpaRepository.java
│   │   ├── InterviewSessionJpaRepository.java
│   │   └── NotificationJpaRepository.java
│   │
│   ├── mapper/   (MapStruct — entités JPA ↔ Records domain)
│   │   ├── UserMapper.java
│   │   ├── CertificationMapper.java
│   │   ├── QuestionMapper.java
│   │   ├── ExamSessionMapper.java
│   │   ├── CourseMapper.java
│   │   ├── FlashcardMapper.java
│   │   └── CommunityMapper.java
│   │
│   └── adapter/   (implémentations des ports output)
│       ├── CertificationRepositoryAdapter.java
│       ├── QuestionRepositoryAdapter.java
│       ├── ExamSessionRepositoryAdapter.java
│       ├── UserAnswerRepositoryAdapter.java
│       ├── UserRepositoryAdapter.java
│       ├── UserPreferencesRepositoryAdapter.java
│       ├── CourseRepositoryAdapter.java
│       ├── FlashcardRepositoryAdapter.java
│       ├── SM2ScheduleRepositoryAdapter.java
│       ├── WeeklyChallengeRepositoryAdapter.java
│       ├── ChallengeParticipationRepositoryAdapter.java
│       ├── StudyGroupRepositoryAdapter.java
│       ├── CertifiedWallRepositoryAdapter.java
│       ├── DiagnosticResultRepositoryAdapter.java
│       ├── CertificationPathRepositoryAdapter.java
│       ├── WeeklyCoachReportRepositoryAdapter.java
│       ├── JobMarketRepositoryAdapter.java
│       ├── InterviewSessionRepositoryAdapter.java
│       └── NotificationRepositoryAdapter.java
│
├── pdf/
│   ├── IText7PdfExportAdapter.java         — implémentation PdfExportPort avec iText7
│   └── PdfTemplateHelper.java              — helpers tables, couleurs, titres iText7
│
├── mail/
│   ├── SpringMailAdapter.java              — envoi emails via Spring Mail
│   ├── ThymeleafEmailRenderer.java         — rendu HTML des templates Thymeleaf email
│   └── template/                           — répertoire templates Thymeleaf (resources)
│       ├── weekly-coach-report.html
│       ├── challenge-reminder.html
│       └── welcome.html
│
├── cache/
│   └── CaffeineCacheConfig.java            — configuration des caches : certifications, questions, jobMarket
│
├── jobmarket/
│   └── IndeedJobMarketAdapter.java         — appel API Indeed + transformation vers JobMarketData
│
├── scheduling/
│   └── WeeklyCoachScheduler.java           — @Scheduled : génération rapports coach lundi 8h
│
└── config/
    ├── JpaConfig.java                       — @EnableJpaRepositories, @EntityScan
    ├── FlywayConfig.java                    — configuration Flyway (baseline, locations)
    ├── AuditingConfig.java                  — @EnableJpaAuditing, createdAt/updatedAt auto
    └── JsonbTypeConfig.java                 — Hibernate custom type pour colonnes JSONB PostgreSQL

certif-infrastructure/src/main/resources/
├── db/migration/
│   ├── V1__init_schema.sql
│   ├── V2__seed_certifications.sql
│   ├── V3__seed_questions_ocp21.sql
│   ├── V4__seed_questions_autres.sql
│   └── V5__add_pgvector.sql
└── templates/
    └── email/
        ├── weekly-coach-report.html
        ├── challenge-reminder.html
        └── welcome.html

certif-infrastructure/src/test/java/com/certifapp/infrastructure/
├── persistence/
│   ├── QuestionRepositoryAdapterIT.java     — Testcontainers PostgreSQL
│   ├── ExamSessionRepositoryAdapterIT.java
│   └── FlashcardRepositoryAdapterIT.java
└── pdf/
    └── IText7PdfExportAdapterTest.java

═══════════════════════════════════════════════════════════════

# certif-api-rest — Arborescence complète
# Développeur responsable : Senior Spring Boot

certif-api-rest/src/main/java/com/certifapp/api/
│
├── CertifAppApplication.java               — @SpringBootApplication, Virtual Threads config
│
├── controller/
│   ├── AuthController.java                 — POST /auth/register, /auth/login, /auth/refresh, /auth/logout
│   ├── UserController.java                 — GET/PATCH /users/me, GET/PATCH /users/me/preferences
│   ├── CertificationController.java        — GET /certifications, GET /certifications/{id}, GET /certifications/{id}/themes
│   ├── ExamController.java                 — POST /exams/sessions, GET/POST /exams/sessions/{id}/answers, POST /exams/sessions/{id}/submit, GET /exams/sessions/{id}/results, GET /exams/history
│   ├── LearningController.java             — GET /learning/courses/{certId}, GET /learning/courses/{certId}/{themeCode}, GET /learning/flashcards/{certId}, POST /learning/flashcards/{id}/review, GET /learning/adaptive-plan
│   ├── CommunityController.java            — GET /community/challenges/current, POST /community/challenges/{id}/join, GET /community/challenges/{id}/leaderboard, CRUD /community/groups, POST /community/groups/{id}/join, GET /community/certified-wall
│   ├── CoachingController.java             — POST /coaching/diagnostic/start, POST /coaching/diagnostic/submit, GET /coaching/certification-path, GET /coaching/weekly-report
│   ├── InterviewController.java            — POST /interview/sessions, POST /interview/sessions/{id}/answer, GET /interview/sessions/{id}/feedback
│   ├── AiController.java                   — POST /ai/chat, GET /ai/explain/{questionId}, POST /ai/generate-flashcards/{courseId}
│   ├── AdminController.java                — POST /admin/questions/import, POST /admin/questions/{id}/enrich, GET /admin/questions, POST /admin/challenges
│   ├── JobMarketController.java            — GET /certifications/{id}/job-market
│   └── WebhookController.java              — POST /webhooks/stripe
│
├── dto/
│   ├── request/
│   │   ├── RegisterRequest.java            — email, password, locale, timezone
│   │   ├── LoginRequest.java               — email, password
│   │   ├── StartExamRequest.java           — certificationId, mode, selectedThemes[], questionCount, durationMinutes
│   │   ├── SubmitAnswerRequest.java        — questionId, selectedOptionId, responseTimeMs
│   │   ├── ReviewFlashcardRequest.java     — rating (0-5)
│   │   ├── CreateGroupRequest.java         — name, certificationId, maxMembers, isPublic
│   │   ├── JoinGroupRequest.java           — inviteCode
│   │   ├── PublishChallengeRequest.java    — certificationId, themeCode, title, questionIds[], startsAt, endsAt
│   │   ├── ImportQuestionsRequest.java     — certificationId, questions[]
│   │   ├── ChatMessageRequest.java         — message, sessionId (optionnel)
│   │   ├── DiagnosticSubmitRequest.java    — answers[]
│   │   ├── InterviewAnswerRequest.java     — questionText, userAnswer, domain
│   │   └── UpdatePreferencesRequest.java   — theme, language, defaultMode, notificationsEnabled
│   └── response/
│       ├── ApiResponse.java               — wrapper générique : data, message, timestamp
│       ├── ErrorResponse.java             — status, message, errors[], timestamp
│       ├── PageResponse.java              — content[], totalElements, totalPages, page, size
│       ├── TokenResponse.java             — accessToken, refreshToken, expiresIn, tokenType
│       └── ValidationErrorResponse.java   — field, message par champ en erreur
│
├── security/
│   ├── JwtTokenProvider.java               — génération/validation access+refresh tokens
│   ├── JwtAuthenticationFilter.java        — filtre Spring Security (OncePerRequestFilter)
│   ├── SecurityConfig.java                 — @EnableWebSecurity, CORS, CSRF, filtres
│   ├── UserPrincipal.java                  — implémentation UserDetails
│   └── RateLimitingFilter.java             — limitation de débit par IP/user (Redis ou in-memory)
│
├── websocket/
│   ├── WebSocketConfig.java                — @EnableWebSocketMessageBroker, STOMP config
│   ├── GroupStudyWebSocketController.java  — /app/group/{groupId}/message, /topic/group/{groupId}
│   └── ChallengeWebSocketController.java   — /app/challenge/{id}/progress, /topic/challenge/{id}/leaderboard
│
├── config/
│   ├── OpenApiConfig.java                  — titre, version, schémas de sécurité JWT
│   ├── WebConfig.java                      — CORS configuration, MVC config
│   └── AsyncConfig.java                    — @EnableAsync, Virtual Threads Executor
│
└── exception/
    └── GlobalExceptionHandler.java         — @RestControllerAdvice, handlers par type d'exception

certif-api-rest/src/main/resources/
├── application.yml                         — config commune
├── application-local.yml                   — Ollama, PostgreSQL locale, logs DEBUG
├── application-test.yml                    — Testcontainers, logs minimal
└── application-prod.yml                    — Claude API, Supabase, logs INFO

certif-api-rest/src/test/java/com/certifapp/api/
├── controller/
│   ├── AuthControllerIT.java
│   ├── ExamControllerIT.java
│   └── CertificationControllerIT.java
└── security/
    └── JwtTokenProviderTest.java

═══════════════════════════════════════════════════════════════

# certif-ai — Arborescence complète
# Développeur responsable : Senior Java + expertise LLM / LangChain4j

certif-ai/src/main/java/com/certifapp/ai/
│
├── config/
│   ├── ModelRouterConfig.java              — @ConditionalOnProfile : Ollama (local) vs Claude (prod)
│   ├── OllamaConfig.java                   — @Profile("local") : LangChain4j Ollama client
│   ├── AnthropicConfig.java                — @Profile("prod") : LangChain4j Claude client
│   └── EmbeddingConfig.java                — configuration du modèle d'embeddings (all-minilm-l6-v2 local ou text-embedding-3-small prod)
│
├── service/
│   ├── ExplanationEnricher.java            — enrichissement section explanation des questions via LLM
│   ├── CourseGenerator.java                — génération fiches de cours Markdown par thème
│   ├── FlashcardGenerator.java             — génération flashcards recto/verso depuis questions + cours
│   ├── ChatAssistant.java                  — assistant conversationnel RAG (questions sur les certifications)
│   ├── CertPathAdvisor.java                — recommandation de parcours certifications selon profil
│   ├── WeeklyCoachReport.java              — génération rapport coach personnalisé lundi matin
│   ├── InterviewSimulator.java             — simulation entretien technique avec feedback LLM
│   └── DiagnosticAnalyzer.java             — analyse du bilan de compétences initial, carte de compétences
│
├── rag/
│   ├── DocumentIngester.java               — ingestion corpus JSON questions + cours Markdown → embeddings
│   ├── VectorStoreAdapter.java             — stockage/recherche embeddings dans PostgreSQL pgvector
│   └── RetrievalService.java               — recherche sémantique : top-K questions/cours similaires
│
└── prompt/
    └── PromptTemplates.java                — constantes de templates Mustache pour chaque use case IA

certif-ai/src/main/resources/prompts/
├── explanation_enrichment.mustache         — template enrichissement explication
├── course_generation.mustache              — template génération fiche de cours
├── flashcard_generation.mustache           — template génération flashcards
├── chat_assistant_system.mustache          — system prompt assistant conversationnel
├── cert_path_advisor.mustache              — template recommandation parcours
├── weekly_coach_report.mustache            — template rapport coach
├── interview_question.mustache             — template question entretien
├── interview_feedback.mustache             — template feedback réponse entretien
└── diagnostic_analysis.mustache           — template analyse bilan compétences

certif-ai/src/test/java/com/certifapp/ai/
├── service/
│   ├── ExplanationEnricherTest.java        — mock LangChain4j, test enrichissement
│   ├── FlashcardGeneratorTest.java
│   └── ChatAssistantTest.java
└── rag/
    └── VectorStoreAdapterIT.java           — Testcontainers pgvector
