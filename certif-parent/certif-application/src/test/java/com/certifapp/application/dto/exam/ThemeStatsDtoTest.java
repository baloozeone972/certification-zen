```java
package com.certifapp.application.dto.exam;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

public class ThemeStatsDtoTest {

    @InjectMocks
    private ThemeStatsDto themeStatsDto;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    @DisplayName("Nominal case: Verify getters return expected values")
    public void testGetters_nominalCase() {
        ThemeStatsDto dto = new ThemeStatsDto("TC1", "Theme 1", 5, 3, 2, 10, 50.0);
        
        assertThat(dto.themeCode()).isEqualTo("TC1");
        assertThat(dto.themeLabel()).isEqualTo("Theme 1");
        assertThat(dto.correct()).isEqualTo(5);
        assertThat(dto.wrong()).isEqualTo(3);
        assertThat(dto.skipped()).isEqualTo(2);
        assertThat(dto.total()).isEqualTo(10);
        assertThat(dto.percentage()).isEqualTo(50.0);
    }

    @Test
    @DisplayName("Edge case: Verify percentage is correctly calculated when total is zero")
    public void testGetters_edgeCaseTotalZero() {
        ThemeStatsDto dto = new ThemeStatsDto("TC2", "Theme 2", 0, 0, 0, 0, 0.0);
        
        assertThat(dto.percentage()).isEqualTo(0.0);
    }

    @Test
    @DisplayName("Error case: Verify IllegalArgumentException when negative values are provided")
    public void testGetters_errorCaseNegativeValues() {
        try {
            new ThemeStatsDto("TC3", "Theme 3", -1, 2, 3, 5, -50.0);
        } catch (IllegalArgumentException e) {
            assertThat(e.getMessage()).isEqualTo("Percentage must be between 0 and 100");
        }
    }

    @Test
    @DisplayName("Error case: Verify IllegalArgumentException when percentage is greater than 100")
    public void testGetters_errorCasePercentageGreaterThan100() {
        try {
            new ThemeStatsDto("TC4", "Theme 4", 6, 2, 3, 5, 110.0);
        } catch (IllegalArgumentException e) {
            assertThat(e.getMessage()).isEqualTo("Percentage must be between 0 and 100");
        }
    }

    @Test
    @DisplayName("Error case: Verify IllegalArgumentException when percentage is less than zero")
    public void testGetters_errorCasePercentageLessThanZero() {
        try {
            new ThemeStatsDto("TC5", "Theme 5", 4, 2, 3, 5, -10.0);
        } catch (IllegalArgumentException e) {
            assertThat(e.getMessage()).isEqualTo("Percentage must be between 0 and 100");
        }
    }
}
```
