package com.certifapp.domain.port.input.exam;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

public class SubmitExamUseCaseTest {

    @DisplayName("execute_validSessionAndUser_examSessionIsUpdated")
    @Test
    public void execute_validSessionAndUser_examSessionIsUpdated() {
        UUID sessionId = UUID.randomUUID();
        UUID userId = UUID.randomUUID();

        ExamSession examSession = new ExamSession(sessionId, userId);

        SubmitExamUseCase submitExamUseCase = new SubmitExamUseCase(examSessionRepository);
        ExamSession updatedSession = submitExamUseCase.execute(sessionId, userId);

        assertThat(updatedSession.getStatus()).isEqualTo(ExamSession.Status.COMPLETED);
    }

    @DisplayName("execute_sessionNotFound_throwsExamSessionNotFoundException")
    @Test
    public void execute_sessionNotFound_throwsExamSessionNotFoundException() {
        UUID sessionId = UUID.randomUUID();
        UUID userId = UUID.randomUUID();

        SubmitExamUseCase submitExamUseCase = new SubmitExamUseCase(examSessionRepository);
        assertThatThrownBy(() -> submitExamUseCase.execute(sessionId, userId))
                .isInstanceOf(ExamSessionNotFoundException.class);
    }

    @DisplayName("execute_examAlreadyCompleted_throwsExamAlreadyCompletedException")
    @Test
    public void execute_examAlreadyCompleted_throwsExamAlreadyCompletedException() {
        UUID sessionId = UUID.randomUUID();
        UUID userId = UUID.randomUUID();

        ExamSession examSession = new ExamSession(sessionId, userId, ExamSession.Status.COMPLETED);

        SubmitExamUseCase submitExamUseCase = new SubmitExamUseCase(examSessionRepository);
        assertThatThrownBy(() -> submitExamUseCase.execute(sessionId, userId))
                .isInstanceOf(ExamAlreadyCompletedException.class);
    }

    @DisplayName("execute_userNotOwner_throwsSecurityException")
    @Test
    public void execute_userNotOwner_throwsSecurityException() {
        UUID sessionId = UUID.randomUUID();
        UUID userId = UUID.randomUUID();

        ExamSession examSession = new ExamSession(sessionId, UUID.randomUUID());

        SubmitExamUseCase submitExamUseCase = new SubmitExamUseCase(examSessionRepository);
        assertThatThrownBy(() -> submitExamUseCase.execute(sessionId, userId))
                .isInstanceOf(SecurityException.class);
    }
}