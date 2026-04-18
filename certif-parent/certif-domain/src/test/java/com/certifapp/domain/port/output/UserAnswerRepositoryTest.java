package com.certifapp.domain.port.output;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import org.mockito.MockitoAnnotations;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class UserAnswerRepositoryTest {

    @Mock
    private UserAnswerRepository userAnswerRepository;

    @InjectMocks
    private UserAnswerRepositoryImpl userAnswerRepositoryImpl;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    @DisplayName("save_userAnswer_savedSuccessfully")
    public void save_UserAnswer_savedSuccessfully() {
        // Arrange
        UserAnswer answer = new UserAnswer(UUID.randomUUID(), UUID.randomUUID(), "answer");

        // Act
        UserAnswer savedAnswer = userAnswerRepositoryImpl.save(answer);

        // Assert
        assertThat(savedAnswer).isEqualTo(answer);
        verify(userAnswerRepository, times(1)).save(answer);
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
        List<UserAnswer> savedAnswers = userAnswerRepositoryImpl.saveAll(answers);

        // Assert
        assertThat(savedAnswers).isEqualTo(answers);
        verify(userAnswerRepository, times(1)).saveAll(answers);
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
        when(userAnswerRepository.findBySessionId(sessionId)).thenReturn(answers);

        // Act
        List<UserAnswer> result = userAnswerRepositoryImpl.findBySessionId(sessionId);

        // Assert
        assertThat(result).isEqualTo(answers);
    }

    @Test
    @DisplayName("findBySessionId_sessionId_mismatch_emptyList_returned")
    public void findBySessionId_sessionId_mismatch_emptyList_returned() {
        // Arrange
        UUID sessionId = UUID.randomUUID();
        when(userAnswerRepository.findBySessionId(sessionId)).thenReturn(List.of());

        // Act
        List<UserAnswer> result = userAnswerRepositoryImpl.findBySessionId(sessionId);

        // Assert
        assertThat(result).isEmpty();
    }
}
