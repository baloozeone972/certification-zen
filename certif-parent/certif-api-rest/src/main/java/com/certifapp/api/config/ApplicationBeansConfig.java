// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/config/ApplicationBeansConfig.java
package com.certifapp.api.config;

import com.certifapp.application.usecase.certification.*;
import com.certifapp.application.usecase.exam.*;
import com.certifapp.application.usecase.learning.*;
import com.certifapp.application.usecase.session.*;
import com.certifapp.application.usecase.user.*;
import com.certifapp.domain.port.output.*;
import com.certifapp.domain.service.*;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

/**
 * Spring bean wiring for use case implementations.
 *
 * <p>Explicit @Bean declarations keep the use case classes framework-free
 * (no Spring annotations in certif-application).</p>
 */
@Configuration
public class ApplicationBeansConfig {

    // ── Domain Services ───────────────────────────────────────────────────────

    @Bean
    public ScoringService scoringService() {
        return new ScoringService();
    }

    @Bean
    public SM2AlgorithmService sm2AlgorithmService() {
        return new SM2AlgorithmService();
    }

    @Bean
    public FreemiumGuardService freemiumGuardService() {
        return new FreemiumGuardService();
    }

    @Bean
    public QuestionSelectionService questionSelectionService() {
        return new QuestionSelectionService();
    }

    // ── Use Cases ─────────────────────────────────────────────────────────────

    @Bean
    public ListCertificationsUseCaseImpl listCertificationsUseCase(
            CertificationRepository certificationRepository) {
        return new ListCertificationsUseCaseImpl(certificationRepository);
    }

    @Bean
    public GetCertificationDetailsUseCaseImpl getCertificationDetailsUseCase(
            CertificationRepository certificationRepository) {
        return new GetCertificationDetailsUseCaseImpl(certificationRepository);
    }

    @Bean
    public StartExamSessionUseCaseImpl startExamSessionUseCase(
            CertificationRepository  certificationRepository,
            QuestionRepository       questionRepository,
            ExamSessionRepository    sessionRepository,
            UserRepository           userRepository,
            FreemiumGuardService     freemiumGuardService,
            QuestionSelectionService questionSelectionService) {
        return new StartExamSessionUseCaseImpl(
                certificationRepository, questionRepository, sessionRepository,
                userRepository, freemiumGuardService, questionSelectionService);
    }

    @Bean
    public SubmitAnswerUseCaseImpl submitAnswerUseCase(
            ExamSessionRepository sessionRepository,
            QuestionRepository    questionRepository,
            UserAnswerRepository  answerRepository,
            ScoringService        scoringService) {
        return new SubmitAnswerUseCaseImpl(
                sessionRepository, questionRepository, answerRepository, scoringService);
    }

    @Bean
    public SubmitExamUseCaseImpl submitExamUseCase(
            ExamSessionRepository   sessionRepository,
            UserAnswerRepository    answerRepository,
            QuestionRepository      questionRepository,
            CertificationRepository certificationRepository,
            ScoringService          scoringService) {
        return new SubmitExamUseCaseImpl(
                sessionRepository, answerRepository, questionRepository,
                certificationRepository, scoringService);
    }

    @Bean
    public GetExamResultsUseCaseImpl getExamResultsUseCase(ExamSessionRepository sessionRepository) {
        return new GetExamResultsUseCaseImpl(sessionRepository);
    }

    @Bean
    public GetSessionHistoryUseCaseImpl getSessionHistoryUseCase(ExamSessionRepository sessionRepository) {
        return new GetSessionHistoryUseCaseImpl(sessionRepository);
    }

    @Bean
    public ExportSessionPdfUseCaseImpl exportSessionPdfUseCase(
            ExamSessionRepository sessionRepository,
            QuestionRepository    questionRepository,
            UserRepository        userRepository,
            UserAnswerRepository  answerRepository,
            PdfExportPort         pdfExportPort,
            FreemiumGuardService  freemiumGuardService,
            ScoringService        scoringService) {
        return new ExportSessionPdfUseCaseImpl(
                sessionRepository, questionRepository, userRepository,
                answerRepository, pdfExportPort, freemiumGuardService, scoringService);
    }

    @Bean
    public GetFlashcardsUseCaseImpl getFlashcardsUseCase(
            FlashcardRepository  flashcardRepository,
            UserRepository       userRepository,
            FreemiumGuardService freemiumGuardService) {
        return new GetFlashcardsUseCaseImpl(flashcardRepository, userRepository, freemiumGuardService);
    }

    @Bean
    public ReviewFlashcardUseCaseImpl reviewFlashcardUseCase(
            SM2ScheduleRepository sm2Repository,
            SM2AlgorithmService   sm2Service) {
        return new ReviewFlashcardUseCaseImpl(sm2Repository, sm2Service);
    }

    @Bean
    public RegisterUserUseCaseImpl registerUserUseCase(
            UserRepository            userRepository,
            UserPreferencesRepository preferencesRepository,
            PasswordEncoder           passwordEncoder) {
        return new RegisterUserUseCaseImpl(
                userRepository, preferencesRepository, passwordEncoder::encode);
    }

    @Bean
    public AuthenticateUserUseCaseImpl authenticateUserUseCase(
            UserRepository  userRepository,
            PasswordEncoder passwordEncoder) {
        return new AuthenticateUserUseCaseImpl(
                userRepository, passwordEncoder::matches);
    }

    @Bean
    public UpdateUserPreferencesUseCaseImpl updateUserPreferencesUseCase(
            UserRepository            userRepository,
            UserPreferencesRepository preferencesRepository) {
        return new UpdateUserPreferencesUseCaseImpl(userRepository, preferencesRepository);
    }
}
