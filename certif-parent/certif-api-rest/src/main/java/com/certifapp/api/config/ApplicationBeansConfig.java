// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/config/ApplicationBeansConfig.java
package com.certifapp.api.config;

import com.certifapp.application.usecase.certification.GetCertificationDetailsUseCaseImpl;
import com.certifapp.application.usecase.certification.ListCertificationsUseCaseImpl;
import com.certifapp.application.usecase.exam.*;
import com.certifapp.application.usecase.learning.*;
import com.certifapp.application.usecase.payment.ProcessStripeWebhookUseCaseImpl;
import com.certifapp.application.usecase.session.*;
import com.certifapp.application.usecase.user.*;
import com.certifapp.domain.port.input.payment.ProcessStripeWebhookUseCase;
import com.certifapp.domain.port.output.*;
import com.certifapp.domain.service.*;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.function.Function;

/**
 * Spring @Bean factory for all application use cases.
 * Keeps Spring out of the domain and application layers.
 */
@Configuration
public class ApplicationBeansConfig {

    // ── Domain services ────────────────────────────────────────────────────────

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

    // ── Use cases ─────────────────────────────────────────────────────────────

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
            ExamSessionRepository sessionRepository,
            QuestionRepository questionRepository,
            UserRepository userRepository,
            FreemiumGuardService freemiumGuardService,
            QuestionSelectionService questionSelectionService) {
        return new StartExamSessionUseCaseImpl(
                sessionRepository, questionRepository, userRepository,
                freemiumGuardService, questionSelectionService);
    }

    @Bean
    public SubmitAnswerUseCaseImpl submitAnswerUseCase(
            ExamSessionRepository sessionRepository,
            UserAnswerRepository userAnswerRepository) {
        return new SubmitAnswerUseCaseImpl(sessionRepository, userAnswerRepository);
    }

    @Bean
    public SubmitExamUseCaseImpl submitExamUseCase(
            ExamSessionRepository sessionRepository,
            UserAnswerRepository userAnswerRepository,
            QuestionRepository questionRepository,
            ScoringService scoringService) {
        return new SubmitExamUseCaseImpl(
                sessionRepository, userAnswerRepository, questionRepository, scoringService);
    }

    @Bean
    public GetExamResultsUseCaseImpl getExamResultsUseCase(
            ExamSessionRepository sessionRepository,
            UserAnswerRepository userAnswerRepository,
            QuestionRepository questionRepository) {
        return new GetExamResultsUseCaseImpl(
                sessionRepository, userAnswerRepository, questionRepository);
    }

    @Bean
    public GetSessionHistoryUseCaseImpl getSessionHistoryUseCase(
            ExamSessionRepository sessionRepository) {
        return new GetSessionHistoryUseCaseImpl(sessionRepository);
    }

    @Bean
    public GetFlashcardsUseCaseImpl getFlashcardsUseCase(
            FlashcardRepository flashcardRepository,
            SM2ScheduleRepository sm2ScheduleRepository) {
        return new GetFlashcardsUseCaseImpl(flashcardRepository, sm2ScheduleRepository);
    }

    @Bean
    public ReviewFlashcardUseCaseImpl reviewFlashcardUseCase(
            SM2ScheduleRepository sm2ScheduleRepository,
            SM2AlgorithmService sm2AlgorithmService) {
        return new ReviewFlashcardUseCaseImpl(sm2ScheduleRepository, sm2AlgorithmService);
    }

    @Bean
    public AuthenticateUserUseCaseImpl authenticateUserUseCase(
            UserRepository userRepository,
            Function<String, String> passwordVerifier) {
        return new AuthenticateUserUseCaseImpl(userRepository, passwordVerifier);
    }

    @Bean
    public RegisterUserUseCaseImpl registerUserUseCase(
            UserRepository userRepository,
            Function<String, String> passwordEncoder) {
        return new RegisterUserUseCaseImpl(userRepository, passwordEncoder);
    }

    @Bean
    public UpdateUserPreferencesUseCaseImpl updateUserPreferencesUseCase(
            UserRepository userRepository,
            UserPreferencesRepository preferencesRepository) {
        return new UpdateUserPreferencesUseCaseImpl(userRepository, preferencesRepository);
    }

    @Bean
    public ProcessStripeWebhookUseCase processStripeWebhookUseCase(
            StripePort stripePort,
            UserRepository userRepository) {
        return new ProcessStripeWebhookUseCaseImpl(stripePort, userRepository);
    }
}
