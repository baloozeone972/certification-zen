package com.certifapp.application.dto.learning;

import java.util.UUID;
import org.junit.jupiter.api.extension.ExtendWith;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class CourseSummaryDtoTest {

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

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

    @Test
    @DisplayName("Should create a valid CourseSummaryDto with all parameters")
    public void shouldCreateValidCourseSummaryDto() {
        CourseSummaryDto dto = new CourseSummaryDto(id, themeCode, title, aiStatus);
        assertThat(dto.id()).isEqualTo(id);
        assertThat(dto.themeCode()).isEqualTo(themeCode);
        assertThat(dto.title()).isEqualTo(title);
        assertThat(dto.aiStatus()).isEqualTo(aiStatus);
    }

    @Test
    @DisplayName("Should handle null id")
    public void shouldHandleNullId() {
        CourseSummaryDto dto = new CourseSummaryDto(null, themeCode, title, aiStatus);
        assertThat(dto.id()).isNull();
    }

    @Test
    @DisplayName("Should handle empty themeCode")
    public void shouldHandleEmptyThemeCode() {
        CourseSummaryDto dto = new CourseSummaryDto(id, "", title, aiStatus);
        assertThat(dto.themeCode()).isEmpty();
    }

    @Test
    @DisplayName("Should handle null title")
    public void shouldHandleNullTitle() {
        CourseSummaryDto dto = new CourseSummaryDto(id, themeCode, null, aiStatus);
        assertThat(dto.title()).isNull();
    }

    @Test
    @DisplayName("Should handle empty aiStatus")
    public void shouldHandleEmptyAiStatus() {
        CourseSummaryDto dto = new CourseSummaryDto(id, themeCode, title, "");
        assertThat(dto.aiStatus()).isEmpty();
    }
}
