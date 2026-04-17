package com.certifapp.domain.model.session;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.assertj.core.api.Assertions.assertThat;

@ExtendWith(MockitoExtension.class)
public class ThemeStatsTest {

    @Mock
    private ScoringService scoringService;

    @InjectMocks
    private ThemeStats themeStats;

    @BeforeEach
    public void setUp() {
        themeStats = new ThemeStats("virtual_threads", "Virtual Threads", 10, 5, 3);
    }

    @Test
    @DisplayName("Should calculate total number of questions correctly")
    public void shouldCalculateTotalNumberOfQuestionsCorrectly() {
        assertThat(themeStats.total()).isEqualTo(18);
    }

    @Test
    @DisplayName("Should calculate percentage of correct answers correctly")
    public void shouldCalculatePercentageOfCorrectAnswersCorrectly() {
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
        // This is a compile-time error, so we can't use Mockito to test it directly.
        // Instead, we'll just check the constructor's validation.
        Exception exception = assertThrows(IllegalArgumentException.class, () -> {
            new ThemeStats("virtual_threads", "Virtual Threads", -1, 0, 0);
        });
        assertThat(exception.getMessage()).isEqualTo("correct must be >= 0");
    }

    @Test
    @DisplayName("Should throw IllegalArgumentException for negative wrong count")
    public void shouldThrowIllegalArgumentExceptionForNegativeWrongCount() {
        // This is a compile-time error, so we can't use Mockito to test it directly.
        Exception exception = assertThrows(IllegalArgumentException.class, () -> {
            new ThemeStats("virtual_threads", "Virtual Threads", 0, -1, 0);
        });
        assertThat(exception.getMessage()).isEqualTo("wrong must be >= 0");
    }

    @Test
    @DisplayName("Should throw IllegalArgumentException for negative skipped count")
    public void shouldThrowIllegalArgumentExceptionForNegativeSkippedCount() {
        // This is a compile-time error, so we can't use Mockito to test it directly.
        Exception exception = assertThrows(IllegalArgumentException.class, () -> {
            new ThemeStats("virtual_threads", "Virtual Threads", 0, 0, -1);
        });
        assertThat(exception.getMessage()).isEqualTo("skipped must be >= 0");
    }
}

