# certif-application — Arborescence complète + signatures des use cases
# Développeur responsable : Senior Java (architecture hexagonale)

certif-application/src/main/java/com/certifapp/application/
│
├── usecase/
│   │
│   ├── certification/
│   │   ├── ListCertificationsUseCase.java
│   │   │   // interface ListCertificationsUseCase {
│   │   │   //   List<CertificationSummaryDto> execute(boolean activeOnly);
│   │   │   // }
│   │   ├── ListCertificationsUseCaseImpl.java
│   │   ├── GetCertificationDetailsUseCase.java
│   │   │   // interface GetCertificationDetailsUseCase {
│   │   │   //   CertificationDetailDto execute(String certificationId);
│   │   │   // }
│   │   ├── GetCertificationDetailsUseCaseImpl.java
│   │   ├── GetCertificationPathUseCase.java
│   │   │   // interface GetCertificationPathUseCase {
│   │   │   //   CertificationPath execute(UUID userId);
│   │   │   // }
│   │   └── GetCertificationPathUseCaseImpl.java
│   │
│   ├── exam/
│   │   ├── StartExamSessionUseCase.java
│   │   │   // interface StartExamSessionUseCase {
│   │   │   //   ExamSessionDto execute(StartExamCommand command);
│   │   │   // }
│   │   │   // record StartExamCommand(UUID userId, String certificationId, ExamMode mode,
│   │   │   //                         List<String> selectedThemes, int questionCount,
│   │   │   //                         int durationMinutes) {}
│   │   ├── StartExamSessionUseCaseImpl.java
│   │   ├── SubmitAnswerUseCase.java
│   │   │   // interface SubmitAnswerUseCase {
│   │   │   //   UserAnswerDto execute(SubmitAnswerCommand command);
│   │   │   // }
│   │   │   // record SubmitAnswerCommand(UUID sessionId, UUID userId, UUID questionId,
│   │   │   //                            UUID selectedOptionId, long responseTimeMs) {}
│   │   ├── SubmitAnswerUseCaseImpl.java
│   │   ├── SubmitExamUseCase.java
│   │   │   // interface SubmitExamUseCase {
│   │   │   //   ExamResultDto execute(SubmitExamCommand command);
│   │   │   // }
│   │   │   // record SubmitExamCommand(UUID sessionId, UUID userId) {}
│   │   ├── SubmitExamUseCaseImpl.java
│   │   ├── GetExamResultsUseCase.java
│   │   │   // interface GetExamResultsUseCase {
│   │   │   //   ExamResultDto execute(UUID sessionId, UUID userId);
│   │   │   // }
│   │   └── GetExamResultsUseCaseImpl.java
│   │
│   ├── learning/
│   │   ├── GetCourseUseCase.java
│   │   │   // interface GetCourseUseCase {
│   │   │   //   CourseDto execute(String certificationId, String themeCode);
│   │   │   // }
│   │   ├── GetCourseUseCaseImpl.java
│   │   ├── GetFlashcardsUseCase.java
│   │   │   // interface GetFlashcardsUseCase {
│   │   │   //   List<FlashcardDto> execute(UUID userId, String certificationId, int limit);
│   │   │   // }
│   │   ├── GetFlashcardsUseCaseImpl.java
│   │   ├── ReviewFlashcardUseCase.java
│   │   │   // interface ReviewFlashcardUseCase {
│   │   │   //   SM2ProgressDto execute(ReviewFlashcardCommand command);
│   │   │   // }
│   │   │   // record ReviewFlashcardCommand(UUID userId, UUID flashcardId, int rating) {}
│   │   │   // rating : 0=blackout, 1=wrong, 2=wrong+hint, 3=correct+hard, 4=correct, 5=perfect
│   │   ├── ReviewFlashcardUseCaseImpl.java
│   │   ├── GetAdaptivePlanUseCase.java
│   │   │   // interface GetAdaptivePlanUseCase {
│   │   │   //   AdaptivePlanDto execute(UUID userId, String certificationId);
│   │   │   // }
│   │   └── GetAdaptivePlanUseCaseImpl.java
│   │
│   ├── session/
│   │   ├── GetSessionHistoryUseCase.java
│   │   │   // interface GetSessionHistoryUseCase {
│   │   │   //   Page<ExamSessionSummaryDto> execute(UUID userId, HistoryFilter filter, Pageable pageable);
│   │   │   // }
│   │   │   // record HistoryFilter(String certificationId, ExamMode mode,
│   │   │   //                       LocalDate from, LocalDate to) {}
│   │   ├── GetSessionHistoryUseCaseImpl.java
│   │   ├── ExportSessionPdfUseCase.java
│   │   │   // interface ExportSessionPdfUseCase {
│   │   │   //   byte[] execute(UUID sessionId, UUID userId);
│   │   │   // }
│   │   ├── ExportSessionPdfUseCaseImpl.java
│   │   ├── GetUserProgressUseCase.java
│   │   │   // interface GetUserProgressUseCase {
│   │   │   //   UserProgressDto execute(UUID userId, String certificationId);
│   │   │   // }
│   │   └── GetUserProgressUseCaseImpl.java
│   │
│   ├── community/
│   │   ├── GetCurrentChallengeUseCase.java
│   │   │   // interface GetCurrentChallengeUseCase {
│   │   │   //   WeeklyChallengeDto execute(String certificationId);
│   │   │   // }
│   │   ├── GetCurrentChallengeUseCaseImpl.java
│   │   ├── JoinChallengeUseCase.java
│   │   │   // interface JoinChallengeUseCase {
│   │   │   //   ChallengeParticipationDto execute(UUID userId, UUID challengeId);
│   │   │   // }
│   │   ├── JoinChallengeUseCaseImpl.java
│   │   ├── GetChallengeLeaderboardUseCase.java
│   │   │   // interface GetChallengeLeaderboardUseCase {
│   │   │   //   List<LeaderboardEntryDto> execute(UUID challengeId, int topN);
│   │   │   // }
│   │   ├── GetChallengeLeaderboardUseCaseImpl.java
│   │   ├── CreateStudyGroupUseCase.java
│   │   │   // interface CreateStudyGroupUseCase {
│   │   │   //   StudyGroupDto execute(CreateStudyGroupCommand command);
│   │   │   // }
│   │   │   // record CreateStudyGroupCommand(UUID creatorId, String name,
│   │   │   //   String certificationId, int maxMembers, boolean isPublic) {}
│   │   ├── CreateStudyGroupUseCaseImpl.java
│   │   ├── JoinStudyGroupUseCase.java
│   │   │   // interface JoinStudyGroupUseCase {
│   │   │   //   StudyGroupMemberDto execute(UUID userId, String inviteCode);
│   │   │   // }
│   │   ├── JoinStudyGroupUseCaseImpl.java
│   │   ├── GetCertifiedWallUseCase.java
│   │   │   // interface GetCertifiedWallUseCase {
│   │   │   //   Page<CertifiedWallProfileDto> execute(String certificationId, String countryCode, Pageable pageable);
│   │   │   // }
│   │   └── GetCertifiedWallUseCaseImpl.java
│   │
│   ├── coaching/
│   │   ├── RunDiagnosticUseCase.java
│   │   │   // interface RunDiagnosticUseCase {
│   │   │   //   DiagnosticResultDto execute(SubmitDiagnosticCommand command);
│   │   │   // }
│   │   │   // record SubmitDiagnosticCommand(UUID userId, List<DiagnosticAnswerDto> answers) {}
│   │   ├── RunDiagnosticUseCaseImpl.java
│   │   ├── GetWeeklyCoachReportUseCase.java
│   │   │   // interface GetWeeklyCoachReportUseCase {
│   │   │   //   WeeklyCoachReportDto execute(UUID userId, LocalDate weekStart);
│   │   │   // }
│   │   ├── GetWeeklyCoachReportUseCaseImpl.java
│   │   ├── GetJobMarketDataUseCase.java
│   │   │   // interface GetJobMarketDataUseCase {
│   │   │   //   JobMarketDto execute(String certificationId, String countryCode);
│   │   │   // }
│   │   └── GetJobMarketDataUseCaseImpl.java
│   │
│   ├── interview/
│   │   ├── StartInterviewSessionUseCase.java
│   │   │   // interface StartInterviewSessionUseCase {
│   │   │   //   InterviewSessionDto execute(UUID userId, String certificationId, String mode);
│   │   │   // }
│   │   ├── StartInterviewSessionUseCaseImpl.java
│   │   ├── SubmitInterviewAnswerUseCase.java
│   │   │   // interface SubmitInterviewAnswerUseCase {
│   │   │   //   InterviewFeedbackDto execute(SubmitInterviewAnswerCommand command);
│   │   │   // }
│   │   │   // record SubmitInterviewAnswerCommand(UUID sessionId, UUID userId,
│   │   │   //   String questionText, String userAnswer, String domain) {}
│   │   └── SubmitInterviewAnswerUseCaseImpl.java
│   │
│   ├── admin/
│   │   ├── ImportQuestionsUseCase.java
│   │   │   // interface ImportQuestionsUseCase {
│   │   │   //   ImportResultDto execute(ImportQuestionsCommand command);
│   │   │   // }
│   │   │   // record ImportQuestionsCommand(String certificationId, List<QuestionImportDto> questions, UUID adminId) {}
│   │   ├── ImportQuestionsUseCaseImpl.java
│   │   ├── EnrichQuestionUseCase.java
│   │   │   // interface EnrichQuestionUseCase {
│   │   │   //   EnrichedQuestionDto execute(UUID questionId, UUID adminId, boolean saveImmediately);
│   │   │   // }
│   │   ├── EnrichQuestionUseCaseImpl.java
│   │   ├── PublishChallengeUseCase.java
│   │   │   // interface PublishChallengeUseCase {
│   │   │   //   WeeklyChallengeDto execute(PublishChallengeCommand command);
│   │   │   // }
│   │   │   // record PublishChallengeCommand(UUID adminId, String certificationId,
│   │   │   //   String themeCode, String title, List<UUID> questionIds,
│   │   │   //   OffsetDateTime startsAt, OffsetDateTime endsAt) {}
│   │   └── PublishChallengeUseCaseImpl.java
│   │
│   ├── user/
│   │   ├── RegisterUserUseCase.java
│   │   │   // interface RegisterUserUseCase {
│   │   │   //   UserDto execute(RegisterUserCommand command);
│   │   │   // }
│   │   │   // record RegisterUserCommand(String email, String password,
│   │   │   //   String locale, String timezone) {}
│   │   ├── RegisterUserUseCaseImpl.java
│   │   ├── AuthenticateUserUseCase.java
│   │   │   // interface AuthenticateUserUseCase {
│   │   │   //   TokenPairDto execute(String email, String password);
│   │   │   // }
│   │   ├── AuthenticateUserUseCaseImpl.java
│   │   ├── UpdateUserPreferencesUseCase.java
│   │   │   // interface UpdateUserPreferencesUseCase {
│   │   │   //   UserPreferencesDto execute(UUID userId, UpdatePreferencesCommand command);
│   │   │   // }
│   │   └── UpdateUserPreferencesUseCaseImpl.java
│   │
│   └── payment/
│       ├── ProcessStripeWebhookUseCase.java
│       │   // interface ProcessStripeWebhookUseCase {
│       │   //   void execute(String payload, String signature);
│       │   // }
│       ├── ProcessStripeWebhookUseCaseImpl.java
│       ├── CheckSubscriptionUseCase.java
│       │   // interface CheckSubscriptionUseCase {
│       │   //   SubscriptionStatusDto execute(UUID userId);
│       │   // }
│       └── CheckSubscriptionUseCaseImpl.java
│
└── dto/   (Records Java 21 — immutables, pas de setters)
    ├── certification/
    │   ├── CertificationSummaryDto.java    — id, name, code, totalQuestions, passingScore, examDurationMin
    │   ├── CertificationDetailDto.java     — tout + themes[], userStats si authentifié
    │   └── CertificationThemeDto.java      — id, code, label, questionCount, weightPercent
    ├── exam/
    │   ├── StartExamCommand.java           — userId, certificationId, mode, selectedThemes[], questionCount, durationMinutes
    │   ├── ExamSessionDto.java             — id, certificationId, mode, questions[], startedAt, durationSeconds, timerEnabled
    │   ├── QuestionDto.java                — id, statement, options[], themeCode, difficulty (SANS isCorrect)
    │   ├── QuestionOptionDto.java          — id, label, text (SANS isCorrect — envoyé seulement après soumission)
    │   ├── SubmitAnswerCommand.java        — sessionId, userId, questionId, selectedOptionId, responseTimeMs
    │   ├── UserAnswerDto.java              — questionId, selectedOptionId, isCorrect, isSkipped
    │   ├── SubmitExamCommand.java          — sessionId, userId
    │   └── ExamResultDto.java             — session + themeStats[] + difficultyStats[] + wrongQuestions[]
    ├── learning/
    │   ├── CourseDto.java                  — id, certificationId, themeCode, title, contentMarkdown, contentHtml
    │   ├── FlashcardDto.java               — id, frontText, backText, codeExample, nextReviewDate, easeFactor
    │   ├── ReviewFlashcardCommand.java     — userId, flashcardId, rating (0-5)
    │   ├── SM2ProgressDto.java             — flashcardId, nextReviewDate, intervalDays, easeFactor
    │   └── AdaptivePlanDto.java            — userId, certificationId, weakThemes[], dueTodayCount, predictedScore
    ├── session/
    │   ├── ExamSessionSummaryDto.java      — id, certificationId, mode, startedAt, score, percentage, passed
    │   ├── HistoryFilter.java              — certificationId, mode, from, to
    │   └── UserProgressDto.java            — certificationId, totalSessions, bestScore, averageScore, progressByTheme[]
    ├── community/
    │   ├── WeeklyChallengeDto.java         — id, title, certificationId, endsAt, totalParticipants
    │   ├── ChallengeParticipationDto.java  — challengeId, userId, score, rank, badgeEarned
    │   ├── LeaderboardEntryDto.java        — rank, userId, displayName, score, percentage
    │   ├── StudyGroupDto.java              — id, name, certificationId, memberCount, inviteCode, isPublic
    │   ├── StudyGroupMemberDto.java        — userId, role, joinedAt
    │   └── CertifiedWallProfileDto.java    — userId, certificationId, examScore, testimonial, countryCode, certifiedAt
    ├── coaching/
    │   ├── DiagnosticAnswerDto.java        — questionId, selectedOptionId
    │   ├── DiagnosticResultDto.java        — scoreByDomain, skillMap, recommendedCertifications[]
    │   ├── WeeklyCoachReportDto.java       — weekStart, reportContent, studyPlan
    │   └── JobMarketDto.java               — certificationId, countryCode, jobCount, medianSalaryEur, topCompanies[]
    ├── interview/
    │   ├── InterviewSessionDto.java        — id, certificationId, mode, startedAt
    │   └── InterviewFeedbackDto.java       — questionText, userAnswer, aiFeedback, score, domain
    ├── user/
    │   ├── RegisterUserCommand.java        — email, password, locale, timezone
    │   ├── UserDto.java                    — id, email, role, subscriptionTier, locale, createdAt
    │   ├── TokenPairDto.java               — accessToken, refreshToken, expiresIn
    │   ├── UpdatePreferencesCommand.java   — theme, language, defaultMode, notificationsEnabled
    │   └── UserPreferencesDto.java         — theme, language, defaultMode, notificationsEnabled, lastCertificationId
    └── payment/
        ├── SubscriptionStatusDto.java      — tier, stripeCustomerId, currentPeriodEnd, isActive
        └── ImportResultDto.java            — imported, skipped, errors[]

certif-application/src/test/java/com/certifapp/application/usecase/
├── exam/
│   ├── StartExamSessionUseCaseTest.java
│   ├── SubmitAnswerUseCaseTest.java
│   └── SubmitExamUseCaseTest.java
├── learning/
│   ├── GetFlashcardsUseCaseTest.java
│   └── ReviewFlashcardUseCaseTest.java
├── session/
│   └── GetSessionHistoryUseCaseTest.java
├── user/
│   ├── RegisterUserUseCaseTest.java
│   └── AuthenticateUserUseCaseTest.java
└── payment/
    └── ProcessStripeWebhookUseCaseTest.java
