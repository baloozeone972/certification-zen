package com.certifapp.domain.exception;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThatThrownBy;

public class QuestionNotFoundExceptionTest {

    @DisplayName("QuestionNotFoundException should be thrown when questionId is null")
    @Test
    public void questionNotFoundException_nullQuestionId_throwsException() {
        UUID nullUuid = null;
        assertThatThrownBy(() -> new QuestionNotFoundException(nullUuid))
                .isInstanceOf(QuestionNotFoundException.class)
                .hasMessage("Question not found: null");
    }

    @DisplayName("QuestionNotFoundException should be thrown when questionId is valid")
    @Test
    public void questionNotFoundException_validQuestionId_throwsException() {
        UUID validUuid = UUID.randomUUID();
        assertThatThrownBy(() -> new QuestionNotFoundException(validUuid))
                .isInstanceOf(QuestionNotFoundException.class)
                .hasMessage("Question not found: " + validUuid.toString());
    }
}