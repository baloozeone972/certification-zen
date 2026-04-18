package com.certifapp.domain.exception;

import java.util.UUID;
import org.junit.jupiter.api.extension.ExtendWith;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.jupiter.MockitoExtension;
import static org.assertj.core.api.Assertions.assertThat;

@ExtendWith(MockitoExtension.class)
public class ExamSessionNotFoundExceptionTest {

    @Mock
    private CertifAppException mockCertifAppException;

    @InjectMocks
    private ExamSessionNotFoundException examSessionNotFoundException;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    @DisplayName("ExamSessionNotFoundException should be created with a specific session ID")
    public void testCreationWithSpecificSessionId() {
        java.util.UUID sessionId = java.util.UUID.randomUUID();
        examSessionNotFoundException = new ExamSessionNotFoundException(sessionId);
        assertThat(examSessionNotFoundException.getSessionId()).isEqualTo(sessionId);
        assertThat(examSessionNotFoundException.getMessage()).isEqualTo("Exam session not found: " + sessionId);
    }

    @Test
    @DisplayName("ExamSessionNotFoundException should throw NullPointerException if sessionId is null")
    public void testCreationWithNullSessionId() {
        java.util.UUID sessionId = null;
        assertThatThrownBy(() -> new ExamSessionNotFoundException(sessionId))
                .isInstanceOf(NullPointerException.class)
                .hasMessage("sessionId must not be null");
    }

    @Test
    @DisplayName("ExamSessionNotFoundException should have the correct class name")
    public void testClassName() {
        java.util.UUID sessionId = java.util.UUID.randomUUID();
        examSessionNotFoundException = new ExamSessionNotFoundException(sessionId);
        assertThat(examSessionNotFoundException.getClass()).isEqualTo(ExamSessionNotFoundException.class);
    }
}
