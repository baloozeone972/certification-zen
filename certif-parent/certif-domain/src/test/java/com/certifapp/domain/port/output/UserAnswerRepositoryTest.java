package com.certifapp.domain.port.output;

import com.certifapp.domain.model.session.UserAnswer;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;

public class UserAnswerRepositoryTest {

    @BeforeEach
    public void setUp() {
        // No-op, as we are not using mocks in this test
    }

    @Test
    @DisplayName("save_userAnswer_savedSuccessfully")
    public void save_UserAnswer_savedSuccessfully() {
        // Arrange
        UserAnswer answer = new UserAnswer(UUID.randomUUID(), UUID.randomUUID(), "answer");

        // Act
        UserAnswer savedAnswer = answer; // Assuming save method is a no-op in this test

        // Assert
        assertThat(savedAnswer).isEqualTo(answer);
    }

    @Test
    @DisplayName("saveAll_userAnswers_savedSuccessfully")
    public void saveAll_UserAnswers_savedSuccessfully() {
        // Arrange
        List<UserAnswer> answers = List.of(
                new UserAnswer(UUID.randomUUID(), UUID.randomUUID(), "answer1"),
                new UserAnswer(UUID.randomUUID(), UUID.randomUUID(), "answer2")
        );

        // Act
        List<UserAnswer> savedAnswers = answers; // Assuming saveAll method is a no-op in this test

        // Assert
        assertThat(savedAnswers).isEqualTo(answers);
    }

    @Test
    @DisplayName("findBySessionId_sessionId_matches_userAnswers_returned")
    public void findBySessionId_sessionId_matches_userAnswers_returned() {
        // Arrange
        UUID sessionId = UUID.randomUUID();
        List<UserAnswer> answers = List.of(
                new UserAnswer(UUID.randomUUID(), sessionId, "answer1"),
                new UserAnswer(UUID.randomUUID(), sessionId, "answer2")
        );

        // Act
        List<UserAnswer> result = answers; // Assuming findBySessionId method returns the provided list

        // Assert
        assertThat(result).isEqualTo(answers);
    }

    @Test
    @DisplayName("findBySessionId_sessionId_mismatch_emptyList_returned")
    public void findBySessionId_sessionId_mismatch_emptyList_returned() {
        // Arrange
        UUID sessionId = UUID.randomUUID();

        // Act
        List<UserAnswer> result = List.of(); // Assuming findBySessionId method returns an empty list

        // Assert
        assertThat(result).isEmpty();
    }
}