package com.certifapp.domain.port.input.exam;

import com.certifapp.domain.exception.ExamSessionNotFoundException;
import com.certifapp.domain.model.session.ExamSession;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThatThrownBy;

public class GetExamResultsUseCaseTest {

    private GetExamResultsUseCase getExamResultsUseCase;

    @BeforeEach
    public void setUp() {
        getExamResultsUseCase = new GetExamResultsUseCase();
    }

    @Test
    @DisplayName("getExamResultsBySessionId_nominalCase_sessionFound")
    public void getExamResultsBySessionId_nominalCase_sessionFound() throws ExamSessionNotFoundException {
        UUID sessionId = UUID.randomUUID();
        UUID userId = UUID.randomUUID();
        ExamSession expectedSession = new ExamSession(sessionId, userId);

        getExamResultsUseCase.setExamSessionRepository(examSessionRepository);
        when(examSessionRepository.findById(any(UUID.class))).thenReturn(Optional.of(expectedSession));

        ExamSession actualSession = getExamResultsUseCase.execute(sessionId, userId);

        assertThat(actualSession).isEqualTo(expectedSession);
    }

    @Test
    @DisplayName("getExamResultsBySessionId_edgeCase_sessionIdNull")
    public void getExamResultsBySessionId_edgeCase_sessionIdNull() {
        UUID sessionId = null;
        UUID userId = UUID.randomUUID();

        assertThatThrownBy(() -> getExamResultsUseCase.execute(sessionId, userId))
                .isInstanceOf(NullPointerException.class);
    }

    @Test
    @DisplayName("getExamResultsBySessionId_errorCase_sessionNotFound")
    public void getExamResultsBySessionId_errorCase_sessionNotFound() throws ExamSessionNotFoundException {
        UUID sessionId = UUID.randomUUID();
        UUID userId = UUID.randomUUID();

        getExamResultsUseCase.setExamSessionRepository(examSessionRepository);
        when(examSessionRepository.findById(any(UUID.class))).thenReturn(Optional.empty());

        assertThatThrownBy(() -> getExamResultsUseCase.execute(sessionId, userId))
                .isInstanceOf(ExamSessionNotFoundException.class)
                .withNoCause();
    }

    @Test
    @DisplayName("getExamResultsBySessionId_errorCase_userNotOwner")
    public void getExamResultsBySessionId_errorCase_userNotOwner() throws ExamSessionNotFoundException {
        UUID sessionId = UUID.randomUUID();
        UUID userId = UUID.randomUUID();
        ExamSession session = new ExamSession(sessionId, UUID.randomUUID());

        getExamResultsUseCase.setExamSessionRepository(examSessionRepository);
        when(examSessionRepository.findById(any(UUID.class))).thenReturn(Optional.of(session));

        assertThatThrownBy(() -> getExamResultsUseCase.execute(sessionId, userId))
                .isInstanceOf(ExamSessionNotFoundException.class)
                .withNoCause();
    }
}