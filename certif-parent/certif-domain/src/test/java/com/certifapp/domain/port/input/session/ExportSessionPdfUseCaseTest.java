package com.certifapp.domain.port.input.session;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

import java.util.UUID;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class ExportSessionPdfUseCaseTest {

    @Mock
    private SessionRepository sessionRepository;

    @InjectMocks
    private ExportSessionPdfUseCase exportSessionPdfUseCase;

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
        when(sessionRepository.findById(sessionId)).thenReturn(Optional.of(new ExamSession()));
        when(pdfGenerator.generatePdf(any(ExamSession.class))).thenReturn(expectedPdfContent);

        byte[] pdfContent = exportSessionPdfUseCase.execute(sessionId, userId);

        assertThat(pdfContent).isEqualTo(expectedPdfContent);
        verify(sessionRepository, times(1)).findById(sessionId);
    }

    @Test
    @DisplayName("Edge case: session not found")
    public void execute_sessionNotFound_throwExamSessionNotFoundException() {
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

        when(userRepository.findBySessionId(eq(sessionId))).thenReturn(Optional.of(user));

        Exception exception = catchThrowable(() -> exportSessionPdfUseCase.execute(sessionId, userId));

        assertThat(exception).isInstanceOf(SubscriptionRequiredException.class)
                            .hasMessage("Subscription required");
        verify(sessionRepository, times(1)).findById(sessionId);
    }
}
