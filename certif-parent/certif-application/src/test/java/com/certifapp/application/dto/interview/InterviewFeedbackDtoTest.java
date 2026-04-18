package com.certifapp.application.dto.interview;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class InterviewFeedbackDtoTest {

    @Mock
    private SomeDependency someDependency; // Add actual dependencies if any

    @InjectMocks
    private InterviewFeedbackDtoFactory factory; // Assuming a factory class for creating InterviewFeedbackDto instances

    @BeforeEach
    public void setUp() {
        // Initialize mocks and setup any necessary configurations here
    }

    @Test
    @DisplayName("Should create valid InterviewFeedbackDto with all parameters")
    public void create_validParameters_expectedBehavior() {
        String questionText = "What is the capital of France?";
        String userAnswer = "Paris";
        String aiFeedback = "Correct! The capital of France is Paris.";
        int score = 10;
        String domain = "Geography";

        InterviewFeedbackDto feedbackDto = factory.createInterviewFeedbackDto(questionText, userAnswer, aiFeedback, score, domain);

        assertThat(feedbackDto.questionText()).isEqualTo(questionText);
        assertThat(feedbackDto.userAnswer()).isEqualTo(userAnswer);
        assertThat(feedbackDto.aiFeedback()).isEqualTo(aiFeedback);
        assertThat(feedbackDto.score()).isEqualTo(score);
        assertThat(feedbackDto.domain()).isEqualTo(domain);
    }

    @Test
    @DisplayName("Should create valid InterviewFeedbackDto with edge case parameters")
    public void create_edgeCaseParameters_expectedBehavior() {
        String questionText = "";
        String userAnswer = null;
        String aiFeedback = "Please provide an answer.";
        int score = 0;
        String domain = "General";

        InterviewFeedbackDto feedbackDto = factory.createInterviewFeedbackDto(questionText, userAnswer, aiFeedback, score, domain);

        assertThat(feedbackDto.questionText()).isEqualTo(questionText);
        assertThat(feedbackDto.userAnswer()).isNull();
        assertThat(feedbackDto.aiFeedback()).isEqualTo(aiFeedback);
        assertThat(feedbackDto.score()).isEqualTo(score);
        assertThat(feedbackDto.domain()).isEqualTo(domain);
    }

    @Test
    @DisplayName("Should handle null input parameters gracefully")
    public void create_nullInputParameters_expectedBehavior() {
        InterviewFeedbackDto feedbackDto = factory.createInterviewFeedbackDto(null, null, null, -1, null);

        assertThat(feedbackDto.questionText()).isNull();
        assertThat(feedbackDto.userAnswer()).isNull();
        assertThat(feedbackDto.aiFeedback()).isEqualTo("Invalid input");
        assertThat(feedbackDto.score()).isEqualTo(0);
        assertThat(feedbackDto.domain()).isNull();
    }

    @Test
    @DisplayName("Should verify method calls when creating InterviewFeedbackDto")
    public void create_verifyMethodCalls_expectedBehavior() {
        String questionText = "What is the capital of France?";
        String userAnswer = "Paris";
        String aiFeedback = "Correct! The capital of France is Paris.";
        int score = 10;
        String domain = "Geography";

        factory.createInterviewFeedbackDto(questionText, userAnswer, aiFeedback, score, domain);

        verify(someDependency, times(1)).log("Creating InterviewFeedbackDto");
    }
}
