package com.certifapp.application.dto.exam;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class UserAnswerDtoTest {

    @Mock
    private UUID mockQuestionId;

    @Mock
    private UUID mockSelectedOptionId;

    @InjectMocks
    private UserAnswerDto userAnswerDto;

    @BeforeEach
    public void setUp() {
        when(mockQuestionId).thenReturn(UUID.randomUUID());
        when(mockSelectedOptionId).thenReturn(UUID.randomUUID());
    }

    @Test
    @DisplayName("Should create UserAnswerDto with selected option")
    public void testCreateUserAnswerDtoWithSelectedOption() {
        // Arrange
        UUID questionId = mockQuestionId;
        UUID selectedOptionId = mockSelectedOptionId;
        boolean isCorrect = true;
        boolean isSkipped = false;

        // Act
        userAnswerDto = new UserAnswerDto(questionId, selectedOptionId, isCorrect, isSkipped);

        // Assert
        assertThat(userAnswerDto.questionId()).isEqualTo(questionId);
        assertThat(userAnswerDto.selectedOptionId()).isEqualTo(selectedOptionId);
        assertThat(userAnswerDto.isCorrect()).isTrue();
        assertThat(userAnswerDto.isSkipped()).isFalse();
    }

    @Test
    @DisplayName("Should create UserAnswerDto with no selected option")
    public void testCreateUserAnswerDtoWithNoSelectedOption() {
        // Arrange
        UUID questionId = mockQuestionId;
        UUID selectedOptionId = null;
        boolean isCorrect = false;
        boolean isSkipped = true;

        // Act
        userAnswerDto = new UserAnswerDto(questionId, selectedOptionId, isCorrect, isSkipped);

        // Assert
        assertThat(userAnswerDto.questionId()).isEqualTo(questionId);
        assertThat(userAnswerDto.selectedOptionId()).isNull();
        assertThat(userAnswerDto.isCorrect()).isFalse();
        assertThat(userAnswerDto.isSkipped()).isTrue();
    }

    @Test
    @DisplayName("Should throw NullPointerException if questionId is null")
    public void testCreateUserAnswerDtoWithNullQuestionId() {
        // Arrange
        UUID selectedOptionId = mockSelectedOptionId;
        boolean isCorrect = true;
        boolean isSkipped = false;

        // Act & Assert
        assertThatThrownBy(() -> new UserAnswerDto(null, selectedOptionId, isCorrect, isSkipped))
                .isInstanceOf(NullPointerException.class)
                .hasMessageContaining("questionId must not be null");
    }

    @Test
    @DisplayName("Should throw IllegalArgumentException if isCorrect and isSkipped are both true")
    public void testCreateUserAnswerDtoWithIncorrectAndSkipped() {
        // Arrange
        UUID questionId = mockQuestionId;
        UUID selectedOptionId = mockSelectedOptionId;
        boolean isCorrect = true;
        boolean isSkipped = true;

        // Act & Assert
        assertThatThrownBy(() -> new UserAnswerDto(questionId, selectedOptionId, isCorrect, isSkipped))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessageContaining("either isCorrect or isSkipped must be true");
    }
}