package com.certifapp.domain.model.question;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class QuestionTypeTest {

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