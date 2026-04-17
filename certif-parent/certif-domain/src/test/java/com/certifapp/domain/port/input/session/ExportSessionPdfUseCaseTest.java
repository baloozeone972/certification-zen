package com.certifapp.domain.port.input.session;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

public class ExportSessionPdfUseCaseTest {

    private UUID sessionId;
    private UUID userId;

    @BeforeEach
    public void setUp() {
        sessionId = UUID.randomUUID();
        userId = UUID.randomUUID();
    }

    @Test
    @DisplayName("Nominal case: export session PDF for a valid user")
    public void execute_validSessionId_andValidUserId_returnPdfContent() throws Exception {
        byte[] expectedPdfContent = new byte[1024];
        // Mocking sessionRepository.findById to return an Optional containing a new ExamSession
        when(sessionRepository.findById(sessionId)).thenReturn(Optional.of(new ExamSession()));
        // Mocking pdfGenerator.generatePdf to return the expected PDF content
        when(pdfGenerator.generatePdf(any(ExamSession.class))).thenReturn(expectedPdfContent);

        byte[] pdfContent = exportSessionPdfUseCase.execute(sessionId, userId);

        assertThat(pdfContent).isEqualTo(expectedPdfContent);
        verify(sessionRepository, times(1)).findById(sessionId);
    }

    @Test
    @DisplayName("Edge case: session not found")
    public void execute_sessionNotFound_throwExamSessionNotFoundException() {
        // Mocking sessionRepository.findById to return an empty Optional
        when(sessionRepository.findById(sessionId)).thenReturn(Optional.empty());

        Exception exception = catchThrowable(() -> exportSessionPdfUseCase.execute(sessionId, userId));

        assertThat(exception).isInstanceOf(ExamSessionNotFoundException.class)
                .hasMessage("Exam session not found");
        verify(sessionRepository, times(1)).findById(sessionId);
    }

    @Test
    @DisplayName("Error case: subscription required for FREE users")
    public void execute_freeUser_throwSubscriptionRequiredException() {
        User user = new User();
        user.setPlan(UserPlan.FREE);

        // Mocking userRepository.findBySessionId to return an Optional containing the user
        when(userRepository.findBySessionId(eq(sessionId))).thenReturn(Optional.of(user));

        Exception exception = catchThrowable(() -> exportSessionPdfUseCase.execute(sessionId, userId));

        assertThat(exception).isInstanceOf(SubscriptionRequiredException.class)
                .hasMessage("Subscription required");
        verify(sessionRepository, times(1)).findById(sessionId);
    }
}