package com.certifapp.domain.model.question;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

public class DifficultyLevelTest {

    @Test
    @DisplayName("fromJson_easy_ReturnsEASY")
    public void fromJson_easy_ReturnsEASY() {
        // Arrange
        String input = "easy";

        // Act
        DifficultyLevel result = DifficultyLevel.fromJson(input);

        // Assert
        assertThat(result).isEqualTo(DifficultyLevel.EASY);
    }

    @Test
    @DisplayName("fromJson_medium_ReturnsMEDIUM")
    public void fromJson_medium_ReturnsMEDIUM() {
        // Arrange
        String input = "medium";

        // Act
        DifficultyLevel result = DifficultyLevel.fromJson(input);

        // Assert
        assertThat(result).isEqualTo(DifficultyLevel.MEDIUM);
    }

    @Test
    @DisplayName("fromJson_hard_ReturnsHARD")
    public void fromJson_hard_ReturnsHARD() {
        // Arrange
        String input = "hard";

        // Act
        DifficultyLevel result = DifficultyLevel.fromJson(input);

        // Assert
        assertThat(result).isEqualTo(DifficultyLevel.HARD);
    }

    @Test
    @DisplayName("fromJson_invalidValue_ThrowsIllegalArgumentException")
    public void fromJson_invalidValue_ThrowsIllegalArgumentException() {
        // Arrange
        String input = "unknown";

        // Act & Assert
        assertThrows(IllegalArgumentException.class, () -> DifficultyLevel.fromJson(input));
    }

    @Test
    @DisplayName("toJson_EASY_Returns\"easy\"")
    public void toJson_EASY_ReturnsEasy() {
        // Arrange
        DifficultyLevel difficulty = DifficultyLevel.EASY;

        // Act
        String result = difficulty.toJson();

        // Assert
        assertThat(result).isEqualTo("easy");
    }

    @Test
    @DisplayName("toJson_MEDIUM_Returns\"medium\"")
    public void toJson_MEDIUM_ReturnsMedium() {
        // Arrange
        DifficultyLevel difficulty = DifficultyLevel.MEDIUM;

        // Act
        String result = difficulty.toJson();

        // Assert
        assertThat(result).isEqualTo("medium");
    }

    @Test
    @DisplayName("toJson_HARD_Returns\"hard\"")
    public void toJson_HARD_ReturnsHard() {
        // Arrange
        DifficultyLevel difficulty = DifficultyLevel.HARD;

        // Act
        String result = difficulty.toJson();

        // Assert
        assertThat(result).isEqualTo("hard");
    }
}