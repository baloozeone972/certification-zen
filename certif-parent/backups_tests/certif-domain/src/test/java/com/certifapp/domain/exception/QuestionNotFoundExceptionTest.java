package com.certifapp.domain.exception;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThatThrownBy;

@ExtendWith(MockitoExtension.class)
public class QuestionNotFoundExceptionTest {

    @BeforeEach
    public void setUp() {
        // Setup code if needed
    }

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

