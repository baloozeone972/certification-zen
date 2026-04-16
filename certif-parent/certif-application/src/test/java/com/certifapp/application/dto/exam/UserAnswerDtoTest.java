package com.certifapp.application.dto.exam;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

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
        userAnswerDto = new UserAnswerDto(mockQuestionId, mockSelectedOptionId, true, false);
        assertThat(userAnswerDto.questionId()).isEqualTo(mockQuestionId);
        assertThat(userAnswerDto.selectedOptionId()).isEqualTo(mockSelectedOptionId);
        assertThat(userAnswerDto.isCorrect()).isTrue();
        assertThat(userAnswerDto.isSkipped()).isFalse();
    }

    @Test
    @DisplayName("Should create UserAnswerDto with no selected option")
    public void testCreateUserAnswerDtoWithNoSelectedOption() {
        userAnswerDto = new UserAnswerDto(mockQuestionId, null, false, true);
        assertThat(userAnswerDto.questionId()).isEqualTo(mockQuestionId);
        assertThat(userAnswerDto.selectedOptionId()).isNull();
        assertThat(userAnswerDto.isCorrect()).isFalse();
        assertThat(userAnswerDto.isSkipped()).isTrue();
    }

    @Test
    @DisplayName("Should throw NullPointerException if questionId is null")
    public void testCreateUserAnswerDtoWithNullQuestionId() {
        assertThatThrownBy(() -> new UserAnswerDto(null, mockSelectedOptionId, true, false))
                .isInstanceOf(NullPointerException.class)
                .hasMessageContaining("questionId must not be null");
    }

    @Test
    @DisplayName("Should throw IllegalArgumentException if isCorrect and isSkipped are both true")
    public void testCreateUserAnswerDtoWithIncorrectAndSkipped() {
        assertThatThrownBy(() -> new UserAnswerDto(mockQuestionId, mockSelectedOptionId, true, true))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessageContaining("either isCorrect or isSkipped must be true");
    }
}
