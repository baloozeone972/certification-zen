```java
package com.certifapp.domain.model.question;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class DifficultyLevelTest {

    @InjectMocks
    private DifficultyLevel difficultyLevel;

    @BeforeEach
    public void setUp() {
        // Initialize any mocks if needed
    }

    @AfterEach
    public void tearDown() {
        // Clean up after each test if needed
    }

    @Test
    @DisplayName("fromJson_easy_ReturnsEASY")
    public void fromJson_easy_ReturnsEASY() {
        assertThat(DifficultyLevel.fromJson("easy")).isEqualTo(DifficultyLevel.EASY);
    }

    @Test
    @DisplayName("fromJson_medium_ReturnsMEDIUM")
    public void fromJson_medium_ReturnsMEDIUM() {
        assertThat(DifficultyLevel.fromJson("medium")).isEqualTo(DifficultyLevel.MEDIUM);
    }

    @Test
    @DisplayName("fromJson_hard_ReturnsHARD")
    public void fromJson_hard_ReturnsHARD() {
        assertThat(DifficultyLevel.fromJson("hard")).isEqualTo(DifficultyLevel.HARD);
    }

    @Test
    @DisplayName("fromJson_invalidValue_ThrowsIllegalArgumentException")
    public void fromJson_invalidValue_ThrowsIllegalArgumentException() {
        assertThrows(IllegalArgumentException.class, () -> DifficultyLevel.fromJson("unknown"));
    }

    @Test
    @DisplayName("toJson_EASY_Returns\"easy\"")
    public void toJson_EASY_ReturnsEasy() {
        assertThat(DifficultyLevel.EASY.toJson()).isEqualTo("easy");
    }

    @Test
    @DisplayName("toJson_MEDIUM_Returns\"medium\"")
    public void toJson_MEDIUM_ReturnsMedium() {
        assertThat(DifficultyLevel.MEDIUM.toJson()).isEqualTo("medium");
    }

    @Test
    @DisplayName("toJson_HARD_Returns\"hard\"")
    public void toJson_HARD_ReturnsHard() {
        assertThat(DifficultyLevel.HARD.toJson()).isEqualTo("hard");
    }
}
```
