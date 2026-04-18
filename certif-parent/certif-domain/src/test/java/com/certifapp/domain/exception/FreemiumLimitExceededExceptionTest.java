package com.certifapp.domain.exception;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.MockitoExtension;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class FreemiumLimitExceededExceptionTest {

    @BeforeEach
    public void setUp() {
        // Setup code if needed
    }

    @DisplayName("dailyExams_nominalCase_expectedErrorMessage")
    @Test
    public void dailyExams_nominalCase_expectedErrorMessage() {
        // Act
        FreemiumLimitExceededException exception = FreemiumLimitExceededException.dailyExams();

        // Assert
        assertThat(exception.getMessage()).isEqualTo("FREE tier: maximum 2 exams per day per certification reached");
    }

    @DisplayName("questionCount_nominalCase_expectedErrorMessage")
    @Test
    public void questionCount_nominalCase_expectedErrorMessage() {
        // Act
        FreemiumLimitExceededException exception = FreemiumLimitExceededException.questionCount();

        // Assert
        assertThat(exception.getMessage()).isEqualTo("FREE tier: maximum 20 questions per session");
    }
}
