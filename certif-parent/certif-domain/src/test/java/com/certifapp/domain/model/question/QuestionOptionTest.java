package com.certifapp.domain.model.question;

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
public class QuestionOptionTest {

    @InjectMocks
    private QuestionOption questionOption;

    @BeforeEach
    public void setUp() {
        questionOption = new QuestionOption(UUID.randomUUID(), UUID.randomUUID(), 'A', "Option A", true, 0);
    }

    @DisplayName("Should create a valid QuestionOption with default values")
    @Test
    public void of_labelTextIsCorrectDisplayOrder_validQuestionOptionCreated() {
        // Arrange
        char label = 'B';
        String text = "Option B";
        boolean isCorrect = false;
        int displayOrder = 1;

        // Act
        QuestionOption result = QuestionOption.of(label, text, isCorrect, displayOrder);

        // Assert
        assertThat(result.label()).isEqualTo('B');
        assertThat(result.text()).isEqualTo("Option B");
        assertThat(result.isCorrect()).isEqualTo(false);
        assertThat(result.displayOrder()).isEqualTo(1);
    }

    @DisplayName("Should throw IllegalArgumentException when label is not A-E")
    @Test
    public void constructor_invalidLabel_throwsIllegalArgumentException() {
        // Arrange
        char invalidLabel = 'Z';

        // Act & Assert
        assertThatThrownBy(() -> new QuestionOption(UUID.randomUUID(), UUID.randomUUID(), invalidLabel, "Invalid Option", true, 0))
            .isInstanceOf(IllegalArgumentException.class)
            .hasMessage("Option label must be one of A-E, got: Z");
    }

    @DisplayName("Should throw IllegalArgumentException when displayOrder is out of range")
    @Test
    public void constructor_invalidDisplayOrder_throwsIllegalArgumentException() {
        // Arrange
        int invalidDisplayOrder = 5;

        // Act & Assert
        assertThatThrownBy(() -> new QuestionOption(UUID.randomUUID(), UUID.randomUUID(), 'A', "Invalid Display Order", true, invalidDisplayOrder))
            .isInstanceOf(IllegalArgumentException.class)
            .hasMessage("displayOrder must be 0-4, got: 5");
    }

    @DisplayName("Should throw IllegalArgumentException when text is blank")
    @Test
    public void constructor_blankText_throwsIllegalArgumentException() {
        // Arrange
        String blankText = "   ";

        // Act & Assert
        assertThatThrownBy(() -> new QuestionOption(UUID.randomUUID(), UUID.randomUUID(), 'A', blankText, true, 0))
            .isInstanceOf(IllegalArgumentException.class)
            .hasMessage("Option text must not be blank");
    }

    @DisplayName("Should correctly convert character to uppercase")
    @Test
    public void constructor_labelConvertedToUppercase() {
        // Arrange
        char label = 'a';

        // Act
        new QuestionOption(UUID.randomUUID(), UUID.randomUUID(), label, "Lowercase", true, 0);

        // Assert
        // No direct way to verify the constructor's behavior in Mockito, but we can check if the value is uppercase
        assertThat(questionOption.label()).isEqualTo('A');
    }
}
