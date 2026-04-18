package com.certifapp.api.dto.request;

import java.util.UUID;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import org.assertj.core.api.Assertions;

@ExtendWith(MockitoExtension.class)
public class SubmitAnswerRequestTest {

    @InjectMocks
    private SubmitAnswerRequest submitAnswerRequest;

    @BeforeEach
    public void setUp() {
        // Initialization if needed
    }

    @Test
    @DisplayName("should create a valid SubmitAnswerRequest with all fields")
    public void testConstructorWithAllFields_validRequest() {
        UUID questionId = UUID.randomUUID();
        UUID selectedOptionId = UUID.randomUUID();
        long responseTimeMs = 100L;

        submitAnswerRequest = new SubmitAnswerRequest(questionId, selectedOptionId, responseTimeMs);

        Assertions.assertThat(submitAnswerRequest.questionId()).isEqualTo(questionId);
        Assertions.assertThat(submitAnswerRequest.selectedOptionId()).isEqualTo(selectedOptionId);
        Assertions.assertThat(submitAnswerRequest.responseTimeMs()).isEqualTo(responseTimeMs);
    }

    @Test
    @DisplayName("should throw NullPointerException when questionId is null")
    public void testConstructor_withNullQuestionId_exception() {
        UUID selectedOptionId = UUID.randomUUID();
        long responseTimeMs = 100L;

        Assertions.assertThatThrownBy(() -> new SubmitAnswerRequest(null, selectedOptionId, responseTimeMs))
                .isInstanceOf(NullPointerException.class)
                .hasMessage("questionId must not be null");
    }

    @Test
    @DisplayName("should allow selectedOptionId to be null")
    public void testConstructor_withNullSelectedOptionId_validRequest() {
        UUID questionId = UUID.randomUUID();
        long responseTimeMs = 100L;

        submitAnswerRequest = new SubmitAnswerRequest(questionId, null, responseTimeMs);

        Assertions.assertThat(submitAnswerRequest.questionId()).isEqualTo(questionId);
        Assertions.assertThat(submitAnswerRequest.selectedOptionId()).isNull();
        Assertions.assertThat(submitAnswerRequest.responseTimeMs()).isEqualTo(responseTimeMs);
    }

    @Test
    @DisplayName("should throw IllegalArgumentException when responseTimeMs is negative")
    public void testConstructor_withNegativeResponseTime_exception() {
        UUID questionId = UUID.randomUUID();
        long responseTimeMs = -100L;

        Assertions.assertThatThrownBy(() -> new SubmitAnswerRequest(questionId, null, responseTimeMs))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("responseTimeMs must be non-negative");
    }
}
