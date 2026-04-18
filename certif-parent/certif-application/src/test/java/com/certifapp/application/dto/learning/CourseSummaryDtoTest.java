package com.certifapp.application.dto.learning;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import static org.assertj.core.api.Assertions.assertThat;

@ExtendWith(MockitoExtension.class)
public class CourseSummaryDtoTest {

    @InjectMocks
    private CourseSummaryDto courseSummaryDto;
    @Mock
    private UUID id;
    @Mock
    private String themeCode;
    @Mock
    private String title;
    @Mock
    private String aiStatus;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    @DisplayName("Should create a valid CourseSummaryDto with all parameters")
    public void shouldCreateValidCourseSummaryDto() {
        // Arrange
        UUID id = UUID.randomUUID();
        String themeCode = "THEME123";
        String title = "Course Title";
        String aiStatus = "ACTIVE";

        // Act
        CourseSummaryDto dto = new CourseSummaryDto(id, themeCode, title, aiStatus);

        // Assert
        assertThat(dto.id()).isEqualTo(id);
        assertThat(dto.themeCode()).isEqualTo(themeCode);
        assertThat(dto.title()).isEqualTo(title);
        assertThat(dto.aiStatus()).isEqualTo(aiStatus);
    }

    @Test
    @DisplayName("Should handle null id")
    public void shouldHandleNullId() {
        // Arrange
        UUID id = null;
        String themeCode = "THEME123";
        String title = "Course Title";
        String aiStatus = "ACTIVE";

        // Act
        CourseSummaryDto dto = new CourseSummaryDto(id, themeCode, title, aiStatus);

        // Assert
        assertThat(dto.id()).isNull();
    }

    @Test
    @DisplayName("Should handle empty themeCode")
    public void shouldHandleEmptyThemeCode() {
        // Arrange
        UUID id = UUID.randomUUID();
        String themeCode = "";
        String title = "Course Title";
        String aiStatus = "ACTIVE";

        // Act
        CourseSummaryDto dto = new CourseSummaryDto(id, themeCode, title, aiStatus);

        // Assert
        assertThat(dto.themeCode()).isEmpty();
    }

    @Test
    @DisplayName("Should handle null title")
    public void shouldHandleNullTitle() {
        // Arrange
        UUID id = UUID.randomUUID();
        String themeCode = "THEME123";
        String title = null;
        String aiStatus = "ACTIVE";

        // Act
        CourseSummaryDto dto = new CourseSummaryDto(id, themeCode, title, aiStatus);

        // Assert
        assertThat(dto.title()).isNull();
    }

    @Test
    @DisplayName("Should handle empty aiStatus")
    public void shouldHandleEmptyAiStatus() {
        // Arrange
        UUID id = UUID.randomUUID();
        String themeCode = "THEME123";
        String title = "Course Title";
        String aiStatus = "";

        // Act
        CourseSummaryDto dto = new CourseSummaryDto(id, themeCode, title, aiStatus);

        // Assert
        assertThat(dto.aiStatus()).isEmpty();
    }
}