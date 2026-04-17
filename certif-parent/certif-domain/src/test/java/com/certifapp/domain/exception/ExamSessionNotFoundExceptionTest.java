package com.certifapp.domain.exception;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

public class ExamSessionNotFoundExceptionTest {

    @Test
    @DisplayName("ExamSessionNotFoundException should be created with a specific session ID")
    public void testCreationWithSpecificSessionId() {
        var sessionId = java.util.UUID.randomUUID();
        var exception = new ExamSessionNotFoundException(sessionId);
        assertThat(exception.getSessionId()).isEqualTo(sessionId);
        assertThat(exception.getMessage()).isEqualTo("Exam session not found: " + sessionId);
    }

    @Test
    @DisplayName("ExamSessionNotFoundException should throw IllegalArgumentException if sessionId is null")
    public void testCreationWithNullSessionId() {
        var sessionId = (java.util.UUID) null;
        assertThatThrownBy(() -> new ExamSessionNotFoundException(sessionId))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("sessionId must not be null");
    }

    @Test
    @DisplayName("ExamSessionNotFoundException should have the correct class name")
    public void testClassName() {
        var sessionId = java.util.UUID.randomUUID();
        var exception = new ExamSessionNotFoundException(sessionId);
        assertThat(exception.getClass()).isEqualTo(ExamSessionNotFoundException.class);
    }
}