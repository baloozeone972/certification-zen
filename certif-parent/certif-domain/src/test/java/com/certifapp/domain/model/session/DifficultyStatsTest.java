package com.certifapp.domain.model.session;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static com.certifapp.domain.model.question.DifficultyLevel.EASY;
import static com.certifapp.domain.model.question.DifficultyLevel.MEDIUM;
import static org.assertj.core.api.Assertions.assertThat;

public class DifficultyStatsTest {

    @DisplayName("Constructor initializes with correct values")
    @Test
    public void constructor_initializesWithCorrectValues() {
        DifficultyStats difficultyStats = new DifficultyStats(MEDIUM, 5, 10);
        assertThat(difficultyStats.difficulty()).isEqualTo(MEDIUM);
        assertThat(difficultyStats.correct()).isEqualTo(5);
        assertThat(difficultyStats.total()).isEqualTo(10);
    }

    @DisplayName("Constructor throws IllegalArgumentException for null difficulty")
    @Test
    public void constructor_throwsIllegalArgumentExceptionForNullDifficulty() {
        Exception exception = assertThrows(IllegalArgumentException.class, () -> new DifficultyStats(null, 5, 10));
        assertThat(exception.getMessage()).isEqualTo("difficulty must not be null");
    }

    @DisplayName("Constructor throws IllegalArgumentException for negative correct")
    @Test
    public void constructor_throwsIllegalArgumentExceptionForNegativeCorrect() {
        Exception exception = assertThrows(IllegalArgumentException.class, () -> new DifficultyStats(EASY, -5, 10));
        assertThat(exception.getMessage()).isEqualTo("correct must be >= 0");
    }

    @DisplayName("Constructor throws IllegalArgumentException for negative total")
    @Test
    public void constructor_throwsIllegalArgumentExceptionForNegativeTotal() {
        Exception exception = assertThrows(IllegalArgumentException.class, () -> new DifficultyStats(EASY, 5, -10));
        assertThat(exception.getMessage()).isEqualTo("total must be >= 0");
    }

    @DisplayName("Constructor throws IllegalArgumentException for correct greater than total")
    @Test
    public void constructor_throwsIllegalArgumentExceptionForCorrectGreaterThanTotal() {
        Exception exception = assertThrows(IllegalArgumentException.class, () -> new DifficultyStats(EASY, 15, 10));
        assertThat(exception.getMessage()).isEqualTo("correct (15) cannot exceed total (10)");
    }

    @DisplayName("Percentage calculates correct percentage")
    @Test
    public void percentage_calculatesCorrectPercentage() {
        DifficultyStats difficultyStats = new DifficultyStats(MEDIUM, 5, 10);
        assertThat(difficultyStats.percentage()).isEqualTo(50.0);
    }

    @DisplayName("Percentage returns 0 when no questions answered")
    @Test
    public void percentage_returnsZeroWhenNoQuestionsAnswered() {
        DifficultyStats stats = new DifficultyStats(MEDIUM, 0, 0);
        assertThat(stats.percentage()).isEqualTo(0.0);
    }
}