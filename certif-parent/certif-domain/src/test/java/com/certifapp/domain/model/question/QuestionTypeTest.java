package com.certifapp.domain.model.question;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class QuestionTypeTest {

    @InjectMocks
    private QuestionType questionType;

    @BeforeEach
    public void setUp() {
        // Not needed in this case as there are no dependencies to mock
    }

    @AfterEach
    public void tearDown() {
        // Not needed in this case as there are no dependencies to reset
    }

    @Test
    @DisplayName("SINGLE_CHOICE_allowsMultipleCorrectAnswers_false")
    public void single_choice_allows_multiple_correct_answers_false() {
        assertThat(QuestionType.SINGLE_CHOICE.allowsMultipleCorrectAnswers()).isFalse();
    }

    @Test
    @DisplayName("MULTIPLE_CHOICE_allowsMultipleCorrectAnswers_true")
    public void multiple_choice_allows_multiple_correct_answers_true() {
        assertThat(QuestionType.MULTIPLE_CHOICE.allowsMultipleCorrectAnswers()).isTrue();
    }

    @Test
    @DisplayName("TRUE_FALSE_allowsMultipleCorrectAnswers_false")
    public void true_false_allows_multiple_correct_answers_false() {
        assertThat(QuestionType.TRUE_FALSE.allowsMultipleCorrectAnswers()).isFalse();
    }
}
