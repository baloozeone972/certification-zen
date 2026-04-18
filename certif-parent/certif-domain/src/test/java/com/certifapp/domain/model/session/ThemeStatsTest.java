package com.certifapp.domain.model.session;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;

public class ThemeStatsTest {

    @BeforeEach
    public void setUp() {
        // No need for mocks in this domain test
    }

    @Test
    @DisplayName("Should calculate total number of questions correctly")
    public void shouldCalculateTotalNumberOfQuestionsCorrectly() {
        ThemeStats themeStats = new ThemeStats("virtual_threads", "Virtual Threads", 10, 5, 3);
        assertThat(themeStats.total()).isEqualTo(18);
    }

    @Test
    @DisplayName("Should calculate percentage of correct answers correctly")
    public void shouldCalculatePercentageOfCorrectAnswersCorrectly() {
        ThemeStats themeStats = new ThemeStats("virtual_threads", "Virtual Threads", 10, 5, 3);
        assertThat(themeStats.percentage()).isEqualTo(55.56);
    }

    @Test
    @DisplayName("Should return 0.0 when total is zero")
    public void shouldReturnZeroWhenTotalIsZero() {
        ThemeStats themeStats = new ThemeStats("virtual_threads", "Virtual Threads", 0, 0, 0);
        assertThat(themeStats.percentage()).isEqualTo(0.0);
    }

    @Test
    @DisplayName("Should throw IllegalArgumentException for negative correct count")
    public void shouldThrowIllegalArgumentExceptionForNegativeCorrectCount() {
        Exception exception = assertThrows(IllegalArgumentException.class, () -> {
            new ThemeStats("virtual_threads", "Virtual Threads", -1, 0, 0);
        });
        assertThat(exception.getMessage()).isEqualTo("correct must be >= 0");
    }

    @Test
    @DisplayName("Should throw IllegalArgumentException for negative wrong count")
    public void shouldThrowIllegalArgumentExceptionForNegativeWrongCount() {
        Exception exception = assertThrows(IllegalArgumentException.class, () -> {
            new ThemeStats("virtual_threads", "Virtual Threads", 0, -1, 0);
        });
        assertThat(exception.getMessage()).isEqualTo("wrong must be >= 0");
    }

    @Test
    @DisplayName("Should throw IllegalArgumentException for negative skipped count")
    public void shouldThrowIllegalArgumentExceptionForNegativeSkippedCount() {
        Exception exception = assertThrows(IllegalArgumentException.class, () -> {
            new ThemeStats("virtual_threads", "Virtual Threads", 0, 0, -1);
        });
        assertThat(exception.getMessage()).isEqualTo("skipped must be >= 0");
    }
}