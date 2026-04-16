# certif-domain — Arborescence complète des fichiers Java
# Développeur responsable : Senior Java (aucune connaissance Spring requise)

certif-domain/src/main/java/com/certifapp/domain/
│
├── model/
│   │
│   ├── certification/
│   │   ├── Certification.java              — Record : id, code, name, description, examQuestionCount, examDurationMin, passingScore, themes[], isActive
│   │   ├── CertificationTheme.java         — Record : id, certificationId, code, label, questionCount, weightPercent, displayOrder
│   │   └── CertificationId.java            — Value Object : wrapper String pour l'id de certification (type-safety)
│   │
│   ├── question/
│   │   ├── Question.java                   — Record : id UUID, legacyId, certificationId, themeId, statement, difficulty, type, options[], explanationOriginal, explanationEnriched, explanationStatus, officialDocUrl, codeExample, aiConfidenceScore, isActive
│   │   ├── QuestionOption.java             — Record : id UUID, questionId, label char, text, isCorrect, displayOrder
│   │   ├── QuestionType.java               — Enum : SINGLE_CHOICE, MULTIPLE_CHOICE, TRUE_FALSE
│   │   ├── DifficultyLevel.java            — Enum : EASY, MEDIUM, HARD
│   │   ├── ExplanationStatus.java          — Enum : ORIGINAL, AI_DRAFT, HUMAN_VALIDATED
│   │   └── QuestionFilter.java             — Record : critères de filtrage pour la sélection de questions (certId, themes[], difficulty, type, excludeIds[])
│   │
│   ├── session/
│   │   ├── ExamSession.java                — Record : id UUID, userId, certificationId, mode, startedAt, endedAt, durationSeconds, totalQuestions, correctCount, percentage, passed, answers[]
│   │   ├── UserAnswer.java                 — Record : id UUID, sessionId, questionId, selectedOptionId (nullable), isCorrect, isSkipped, responseTimeMs, answeredAt
│   │   ├── ExamMode.java                   — Enum : EXAM, FREE, REVISION
│   │   ├── SessionStatus.java              — Enum : IN_PROGRESS, COMPLETED, ABANDONED, EXPIRED
│   │   ├── ThemeStats.java                 — Record : theme, correct, wrong, skipped, total — méthode percentage()
│   │   └── DifficultyStats.java            — Record : difficulty, correct, total — méthode percentage()
│   │
│   ├── user/
│   │   ├── User.java                       — Record : id UUID, email, passwordHash, role, subscriptionTier, locale, timezone, stripeCustomerId, isActive, createdAt, updatedAt
│   │   ├── UserRole.java                   — Enum : USER, ADMIN, PARTNER
│   │   ├── SubscriptionTier.java           — Enum : FREE, PRO, PACK
│   │   ├── UserPreferences.java            — Record : userId, theme, language, defaultMode, notificationsEnabled, lastCertificationId, freeModeQuestionCount, freeModeDurationMin
│   │   └── UiTheme.java                    — Enum : LIGHT, DARK, SYSTEM
│   │
│   ├── learning/
│   │   ├── Course.java                     — Record : id UUID, certificationId, themeId, title, contentMarkdown, contentHtml, aiStatus, version, embedding float[], createdAt, updatedAt
│   │   ├── Flashcard.java                  — Record : id UUID, questionId, courseId, frontText, backText, codeExample, aiGenerated, createdAt
│   │   ├── UserFlashcardProgress.java      — Record : userId, flashcardId, easeFactor double, intervalDays int, repetitions int, nextReviewDate, lastReviewedAt
│   │   ├── SM2Schedule.java                — Record : id UUID, userId, questionId, easeFactor double, intervalDays int, repetitions int, dueDate, lastReviewedAt
│   │   └── SM2Algorithm.java               — Classe pure : implémentation algorithme SM-2 (calcul nextInterval, easeFactor) — AUCUNE dépendance
│   │
│   ├── community/
│   │   ├── WeeklyChallenge.java            — Record : id UUID, certificationId, themeId, title, description, startsAt, endsAt, questionIds[], totalParticipants, createdBy UUID
│   │   ├── ChallengeParticipation.java     — Record : id UUID, userId, challengeId, score, percentage, completedAt, rank, badgeEarned
│   │   ├── StudyGroup.java                 — Record : id UUID, name, certificationId, createdBy, maxMembers, isPublic, inviteCode, createdAt
│   │   ├── StudyGroupMember.java           — Record : groupId, userId, role (OWNER/MEMBER), joinedAt, lastActiveAt
│   │   ├── StudyGroupRole.java             — Enum : OWNER, MODERATOR, MEMBER
│   │   └── CertifiedWallProfile.java       — Record : id UUID, userId, certificationId, examScore, prepDurationWeeks, testimonial, isPublic, linkedinUrl, countryCode, certifiedAt
│   │
│   └── coaching/
│       ├── DiagnosticResult.java           — Record : id UUID, userId, completedAt, totalQuestions, scoreByDomain Map<String,Integer>, skillMap Map<String,Double>, recommendedCertifications[]
│       ├── CertificationPath.java          — Record : id UUID, userId, roleType, projectGoal, generatedPath List<PathStep>, aiRationale, createdAt, updatedAt
│       ├── PathStep.java                   — Record : certificationId, order, rationale, estimatedWeeks
│       ├── WeeklyCoachReport.java          — Record : id UUID, userId, weekStart, reportContent, studyPlan Map, sentAt, openedAt
│       └── JobMarketData.java              — Record : id UUID, certificationId, countryCode, jobCount, medianSalaryEur, topCompanies[], trendData Map, fetchedAt, expiresAt
│
├── port/
│   ├── input/   (interfaces use cases — implémentées dans certif-application)
│   │   ├── certification/
│   │   │   ├── ListCertificationsUseCase.java
│   │   │   ├── GetCertificationDetailsUseCase.java
│   │   │   └── GetCertificationPathUseCase.java
│   │   ├── exam/
│   │   │   ├── StartExamSessionUseCase.java
│   │   │   ├── SubmitAnswerUseCase.java
│   │   │   ├── SubmitExamUseCase.java
│   │   │   └── GetExamResultsUseCase.java
│   │   ├── learning/
│   │   │   ├── GetCourseUseCase.java
│   │   │   ├── GetFlashcardsUseCase.java
│   │   │   ├── ReviewFlashcardUseCase.java
│   │   │   └── GetAdaptivePlanUseCase.java
│   │   ├── session/
│   │   │   ├── GetSessionHistoryUseCase.java
│   │   │   ├── ExportSessionPdfUseCase.java
│   │   │   └── GetUserProgressUseCase.java
│   │   ├── community/
│   │   │   ├── GetCurrentChallengeUseCase.java
│   │   │   ├── JoinChallengeUseCase.java
│   │   │   ├── GetChallengeLeaderboardUseCase.java
│   │   │   ├── CreateStudyGroupUseCase.java
│   │   │   ├── JoinStudyGroupUseCase.java
│   │   │   └── GetCertifiedWallUseCase.java
│   │   ├── coaching/
│   │   │   ├── RunDiagnosticUseCase.java
│   │   │   ├── GetWeeklyCoachReportUseCase.java
│   │   │   └── GetJobMarketDataUseCase.java
│   │   ├── interview/
│   │   │   ├── StartInterviewSessionUseCase.java
│   │   │   └── SubmitInterviewAnswerUseCase.java
│   │   ├── admin/
│   │   │   ├── ImportQuestionsUseCase.java
│   │   │   ├── EnrichQuestionUseCase.java
│   │   │   └── PublishChallengeUseCase.java
│   │   ├── user/
│   │   │   ├── RegisterUserUseCase.java
│   │   │   ├── AuthenticateUserUseCase.java
│   │   │   └── UpdateUserPreferencesUseCase.java
│   │   └── payment/
│   │       ├── ProcessStripeWebhookUseCase.java
│   │       └── CheckSubscriptionUseCase.java
│   │
│   └── output/  (interfaces repositories — implémentées dans certif-infrastructure)
│       ├── CertificationRepository.java
│       ├── QuestionRepository.java
│       ├── ExamSessionRepository.java
│       ├── UserAnswerRepository.java
│       ├── UserRepository.java
│       ├── UserPreferencesRepository.java
│       ├── CourseRepository.java
│       ├── FlashcardRepository.java
│       ├── SM2ScheduleRepository.java
│       ├── WeeklyChallengeRepository.java
│       ├── ChallengeParticipationRepository.java
│       ├── StudyGroupRepository.java
│       ├── CertifiedWallRepository.java
│       ├── DiagnosticResultRepository.java
│       ├── CertificationPathRepository.java
│       ├── WeeklyCoachReportRepository.java
│       ├── JobMarketRepository.java
│       ├── InterviewSessionRepository.java
│       ├── NotificationRepository.java
│       └── PdfExportPort.java              — port pour l'export PDF (implémenté par iText7)
│
├── service/   (logique métier pure, sans framework)
│   ├── ScoringService.java                 — Calcul score, percentage, passed, ThemeStats, DifficultyStats
│   ├── SM2Service.java                     — Orchestration algorithme SM-2 : calcul next review date
│   ├── QuestionSelectionService.java       — Sélection aléatoire, répartition proportionnelle par thème
│   └── FreemiumGuardService.java           — Règles freemium : 2 examens max, 20 questions max en FREE
│
└── exception/
    ├── CertifAppException.java             — Exception de base du domaine (RuntimeException)
    ├── CertificationNotFoundException.java
    ├── QuestionNotFoundException.java
    ├── ExamSessionNotFoundException.java
    ├── UserNotFoundException.java
    ├── DuplicateEmailException.java
    ├── ExamAlreadyCompletedException.java
    ├── FreemiumLimitExceededException.java
    ├── InvalidCredentialsException.java
    ├── StudyGroupFullException.java
    └── SubscriptionRequiredException.java

certif-domain/src/test/java/com/certifapp/domain/
├── service/
│   ├── ScoringServiceTest.java
│   ├── SM2ServiceTest.java
│   ├── QuestionSelectionServiceTest.java
│   └── FreemiumGuardServiceTest.java
└── model/
    ├── ExamSessionTest.java
    └── SM2AlgorithmTest.java
