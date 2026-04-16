```java
package com.certifapp.domain.exception;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import org.assertj.core.api.Assertions.assertThat;

@ExtendWith(MockitoExtension.class)
public class ExamAlreadyCompletedExceptionTest {

    @InjectMocks
    private ExamAlreadyCompletedException examAlreadyCompletedException;

    @BeforeEach
    public void setUp() {
        java.util.UUID sessionId = java.util.UUID.randomUUID();
        examAlreadyCompletedException = new ExamAlreadyCompletedException(sessionId);
    }

    @Test
    @DisplayName("Nominal case: get session ID")
    public void testGetSessionId_nominalCase() {
        java.util.UUID sessionId = examAlreadyCompletedException.getSessionId();
        assertThat(sessionId).isNotNull();
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
        ExamAlreadyCompletedException exception = new ExamAlreadyCompletedException(java.util.UUID.randomUUID());
        String message = exception.getMessage();
        assertThat(message).isNotNull().contains("Exam session already completed");
    }
}
```
