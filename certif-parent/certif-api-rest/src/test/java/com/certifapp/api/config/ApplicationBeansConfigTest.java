package com.certifapp.api.config;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.beans.factory.annotation.Autowired;
import static org.assertj.core.api.Assertions.assertThat;

@WebMvcTest(ApplicationBeansConfig.class)
public class ApplicationBeansConfigTest {

    @Autowired
    private ApplicationBeansConfig applicationBeansConfig;

    @Test
    @DisplayName("Should create a ScoringService bean")
    public void scoringService_creation() {
        var service = applicationBeansConfig.scoringService();
        assertThat(service).isNotNull();
    }

    @Test
    @DisplayName("Should create an SM2AlgorithmService bean")
    public void sm2AlgorithmService_creation() {
        var service = applicationBeansConfig.sm2AlgorithmService();
        assertThat(service).isNotNull();
    }

    @Test
    @DisplayName("Should create a FreemiumGuardService bean")
    public void freemiumGuardService_creation() {
        var service = applicationBeansConfig.freemiumGuardService();
        assertThat(service).isNotNull();
    }

    @Test
    @DisplayName("Should create a QuestionSelectionService bean")
    public void questionSelectionService_creation() {
        var service = applicationBeansConfig.questionSelectionService();
        assertThat(service).isNotNull();
    }

    @Test
    @DisplayName("Should create a ListCertificationsUseCaseImpl bean with required dependencies")
    public void listCertificationsUseCase_creation() {
        var useCase = applicationBeansConfig.listCertificationsUseCase();
        assertThat(useCase).isNotNull();
    }

    @Test
    @DisplayName("Should create a GetCertificationDetailsUseCaseImpl bean with required dependencies")
    public void getCertificationDetailsUseCase_creation() {
        var useCase = applicationBeansConfig.getCertificationDetailsUseCase();
        assertThat(useCase).isNotNull();
    }

    @Test
    @DisplayName("Should create a StartExamSessionUseCaseImpl bean with required dependencies")
    public void startExamSessionUseCase_creation() {
        var useCase = applicationBeansConfig.startExamSessionUseCase();
        assertThat(useCase).isNotNull();
    }

    @Test
    @DisplayName("Should create a SubmitAnswerUseCaseImpl bean with required dependencies")
    public void submitAnswerUseCase_creation() {
        var useCase = applicationBeansConfig.submitAnswerUseCase();
        assertThat(useCase).isNotNull();
    }

    @Test
    @DisplayName("Should create a SubmitExamUseCaseImpl bean with required dependencies")
    public void submitExamUseCase_creation() {
        var useCase = applicationBeansConfig.submitExamUseCase();
        assertThat(useCase).isNotNull();
    }

    @Test
    @DisplayName("Should create a GetExamResultsUseCaseImpl bean with required dependencies")
    public void getExamResultsUseCase_creation() {
        var useCase = applicationBeansConfig.getExamResultsUseCase();
        assertThat(useCase).isNotNull();
    }

    @Test
    @DisplayName("Should create a GetSessionHistoryUseCaseImpl bean with required dependencies")
    public void getSessionHistoryUseCase_creation() {
        var useCase = applicationBeansConfig.getSessionHistoryUseCase();
        assertThat(useCase).isNotNull();
    }

    @Test
    @DisplayName("Should create an ExportSessionPdfUseCaseImpl bean with required dependencies")
    public void exportSessionPdfUseCase_creation() {
        var useCase = applicationBeansConfig.exportSessionPdfUseCase();
        assertThat(useCase).isNotNull();
    }

    @Test
    @DisplayName("Should create a GetFlashcardsUseCaseImpl bean with required dependencies")
    public void getFlashcardsUseCase_creation() {
        var useCase = applicationBeansConfig.getFlashcardsUseCase();
        assertThat(useCase).isNotNull();
    }

    @Test
    @DisplayName("Should create a ReviewFlashcardUseCaseImpl bean with required dependencies")
    public void reviewFlashcardUseCase_creation() {
        var useCase = applicationBeansConfig.reviewFlashcardUseCase();
        assertThat(useCase).isNotNull();
    }

    @Test
    @DisplayName("Should create a RegisterUserUseCaseImpl bean with required dependencies")
    public void registerUserUseCase_creation() {
        var useCase = applicationBeansConfig.registerUserUseCase();
        assertThat(useCase).isNotNull();
    }

    @Test
    @DisplayName("Should create an AuthenticateUserUseCaseImpl bean with required dependencies")
    public void authenticateUserUseCase_creation() {
        var useCase = applicationBeansConfig.authenticateUserUseCase();
        assertThat(useCase).isNotNull();
    }

    @Test
    @DisplayName("Should create an UpdateUserPreferencesUseCaseImpl bean with required dependencies")
    public void updateUserPreferencesUseCase_creation() {
        var useCase = applicationBeansConfig.updateUserPreferencesUseCase();
        assertThat(useCase).isNotNull();
    }
}