package com.certifapp.application.dto.coaching;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.lenient;

@ExtendWith(MockitoExtension.class)
public class WeeklyCoachReportDtoTest {

    @InjectMocks
    private WeeklyCoachReportDto weeklyCoachReportDto;

    @Mock
    private WeeklyCoachService weeklyCoachService;

    @BeforeEach
    public void setUp() {
        UUID reportId = UUID.randomUUID();
        UUID userId = UUID.randomUUID();
        LocalDate weekStart = LocalDate.now().with(java.time.temporal.ChronoField.DAY_OF_WEEK, java.time.DayOfWeek.MONDAY.getValue());
        String reportContent = "Weekly report content";
        Map<String, Object> studyPlan = new HashMap<>();

        weeklyCoachReportDto = new WeeklyCoachReportDto(reportId, userId, weekStart, reportContent, studyPlan);
    }

    @Test
    @DisplayName("Should return correct report ID")
    public void getReportId_stateUnderTest_expectedBehavior() {
        UUID expectedReportId = UUID.randomUUID();
        lenient().when(weeklyCoachService.getReportId()).thenReturn(expectedReportId);
        assertThat(weeklyCoachReportDto.reportId()).isEqualTo(expectedReportId);
    }

    @Test
    @DisplayName("Should return correct user ID")
    public void getUserId_stateUnderTest_expectedBehavior() {
        UUID expectedUserId = UUID.randomUUID();
        lenient().when(weeklyCoachService.getUserId()).thenReturn(expectedUserId);
        assertThat(weeklyCoachReportDto.userId()).isEqualTo(expectedUserId);
    }

    @Test
    @DisplayName("Should return correct week start date")
    public void getWeekStart_stateUnderTest_expectedBehavior() {
        LocalDate expectedDate = LocalDate.now().with(java.time.temporal.ChronoField.DAY_OF_WEEK, java.time.DayOfWeek.MONDAY.getValue());
        lenient().when(weeklyCoachService.getWeekStart()).thenReturn(expectedDate);
        assertThat(weeklyCoachReportDto.weekStart()).isEqualTo(expectedDate);
    }

    @Test
    @DisplayName("Should return correct report content")
    public void getReportContent_stateUnderTest_expectedBehavior() {
        String expectedContent = "Weekly report content";
        lenient().when(weeklyCoachService.getReportContent()).thenReturn(expectedContent);
        assertThat(weeklyCoachReportDto.reportContent()).isEqualTo(expectedContent);
    }

    @Test
    @DisplayName("Should return correct study plan")
    public void getStudyPlan_stateUnderTest_expectedBehavior() {
        Map<String, Object> expectedStudyPlan = new HashMap<>();
        lenient().when(weeklyCoachService.getStudyPlan()).thenReturn(expectedStudyPlan);
        assertThat(weeklyCoachReportDto.studyPlan()).isEqualTo(expectedStudyPlan);
    }
}