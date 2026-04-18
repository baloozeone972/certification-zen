package com.certifapp.domain.port.input.exam;

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
import org.mockito.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class SubmitExamUseCaseTest {

    @Mock
    private ExamSessionRepository examSessionRepository;

    @Mock
    private SubmitExamUseCase submitExamUseCase;

    @BeforeEach
    public void setUp() {
        // Setup mock behavior if necessary
    }

    @DisplayName("execute_validSessionAndUser_examSessionIsUpdated")
    @Test
    public void execute_validSessionAndUser_examSessionIsUpdated() throws Exception {
        UUID sessionId = UUID.randomUUID();
        UUID userId = UUID.randomUUID();

        ExamSession examSession = new ExamSession();
        examSession.setId(sessionId);
        examSession.setOwner(userId);

        when(examSessionRepository.findById(sessionId)).thenReturn(java.util.Optional.of(examSession));

        ExamSession updatedSession = submitExamUseCase.execute(sessionId, userId);

        verify(examSessionRepository).save(updatedSession);
        assertThat(updatedSession.getStatus()).isEqualTo(ExamSession.Status.COMPLETED);
    }

    @DisplayName("execute_sessionNotFound_throwsExamSessionNotFoundException")
    @Test
    public void execute_sessionNotFound_throwsExamSessionNotFoundException() throws Exception {
        UUID sessionId = UUID.randomUUID();
        UUID userId = UUID.randomUUID();

        when(examSessionRepository.findById(sessionId)).thenReturn(java.util.Optional.empty());

        assertThatThrownBy(() -> submitExamUseCase.execute(sessionId, userId))
            .isInstanceOf(ExamSessionNotFoundException.class);
    }

    @DisplayName("execute_examAlreadyCompleted_throwsExamAlreadyCompletedException")
    @Test
    public void execute_examAlreadyCompleted_throwsExamAlreadyCompletedException() throws Exception {
        UUID sessionId = UUID.randomUUID();
        UUID userId = UUID.randomUUID();

        ExamSession examSession = new ExamSession();
        examSession.setId(sessionId);
        examSession.setOwner(userId);
        examSession.setStatus(ExamSession.Status.COMPLETED);

        when(examSessionRepository.findById(sessionId)).thenReturn(java.util.Optional.of(examSession));

        assertThatThrownBy(() -> submitExamUseCase.execute(sessionId, userId))
            .isInstanceOf(ExamAlreadyCompletedException.class);
    }

    @DisplayName("execute_userNotOwner_throwsSecurityException")
    @Test
    public void execute_userNotOwner_throwsSecurityException() throws Exception {
        UUID sessionId = UUID.randomUUID();
        UUID userId = UUID.randomUUID();

        ExamSession examSession = new ExamSession();
        examSession.setId(sessionId);
        examSession.setOwner(UUID.randomUUID());

        when(examSessionRepository.findById(sessionId)).thenReturn(java.util.Optional.of(examSession));

        assertThatThrownBy(() -> submitExamUseCase.execute(sessionId, userId))
            .isInstanceOf(SecurityException.class);
    }
}
