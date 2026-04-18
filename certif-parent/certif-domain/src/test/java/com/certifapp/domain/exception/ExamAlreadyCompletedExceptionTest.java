package com.certifapp.domain.exception;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class ExamAlreadyCompletedExceptionTest {

    @Test
    @DisplayName("Nominal case: get session ID")
    public void testGetSessionId_nominalCase() {
        var sessionId = java.util.UUID.randomUUID();
        ExamAlreadyCompletedException exception = new ExamAlreadyCompletedException(sessionId);
        assertThat(exception.getSessionId()).isEqualTo(sessionId);
    }

    @Test
    @DisplayName("Edge case: null session ID")
    public void testGetSessionId_edgeCase_null() {
        ExamAlreadyCompletedException exception = new ExamAlreadyCompletedException(null);
        assertThat(exception.getSessionId()).isNull();
    }

    @Test
    @DisplayName("Error case: empty string message")
    public void testGetMessage_errorCase_emptyString() {
        var sessionId = java.util.UUID.randomUUID();
        ExamAlreadyCompletedException exception = new ExamAlreadyCompletedException(sessionId);
        String message = exception.getMessage();
        assertThat(message).isNotNull().contains("Exam session already completed");
    }
}