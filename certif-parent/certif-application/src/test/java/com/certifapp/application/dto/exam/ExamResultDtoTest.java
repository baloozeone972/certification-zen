package com.certifapp.application.dto.exam;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

@ExtendWith(MockitoExtension.class)
public class ExamResultDtoTest {

    @Mock
    private List<ThemeStatsDto> themeStats;

    @Mock
    private List<QuestionResultDto> wrongQuestions;

    @InjectMocks
    private ExamResultDto examResultDto;

    @BeforeEach
    public void setUp() {
        examResultDto = new ExamResultDto(
                UUID.randomUUID(),
                "certificationSlug",
                "EXAM",
                OffsetDateTime.now(),
                OffsetDateTime.now().plusHours(1),
                3600,
                50,
                40,
                80.0,
                true,
                themeStats,
                wrongQuestions
        );
    }

    @Test
    @DisplayName("nominal case: getters return correct values")
    public void gettersReturnCorrectValues() {
        assertThat(examResultDto.sessionId()).isNotNull();
        assertThat(examResultDto.certificationId()).isEqualTo("certificationSlug");
        assertThat(examResultDto.mode()).isEqualTo("EXAM");
        assertThat(examResultDto.startedAt()).isNotNull();
        assertThat(examResultDto.endedAt()).isNotNull();
        assertThat(examResultDto.durationSeconds()).isEqualTo(3600);
        assertThat(examResultDto.totalQuestions()).isEqualTo(50);
        assertThat(examResultDto.correctCount()).isEqualTo(40);
        assertThat(examResultDto.percentage()).isEqualTo(80.0);
        assertThat(examResultDto.passed()).isTrue();
        assertThat(examResultDto.themeStats()).isEqualTo(themeStats);
        assertThat(examResultDto.wrongQuestions()).isEqualTo(wrongQuestions);
    }

    @Test
    @DisplayName("edge case: null certificationId")
    public void gettersReturnCorrectValuesWithNullCertificationId() {
        examResultDto = new ExamResultDto(
                UUID.randomUUID(),
                null,
                "EXAM",
                OffsetDateTime.now(),
                OffsetDateTime.now().plusHours(1),
                3600,
                50,
                40,
                80.0,
                true,
                themeStats,
                wrongQuestions
        );

        assertThat(examResultDto.certificationId()).isNull();
    }

    @Test
    @DisplayName("edge case: negative durationSeconds")
    public void gettersReturnCorrectValuesWithNegativeDurationSeconds() {
        examResultDto = new ExamResultDto(
                UUID.randomUUID(),
                "certificationSlug",
                "EXAM",
                OffsetDateTime.now(),
                OffsetDateTime.now().plusHours(1),
                -3600,
                50,
                40,
                80.0,
                true,
                themeStats,
                wrongQuestions
        );

        assertThat(examResultDto.durationSeconds()).isEqualTo(-3600);
    }

    @Test
    @DisplayName("edge case: zero totalQuestions")
    public void gettersReturnCorrectValuesWithZeroTotalQuestions() {
        examResultDto = new ExamResultDto(
                UUID.randomUUID(),
                "certificationSlug",
                "EXAM",
                OffsetDateTime.now(),
                OffsetDateTime.now().plusHours(1),
                3600,
                0,
                40,
                80.0,
                true,
                themeStats,
                wrongQuestions
        );

        assertThat(examResultDto.totalQuestions()).isEqualTo(0);
    }

    @Test
    @DisplayName("edge case: negative correctCount")
    public void gettersReturnCorrectValuesWithNegativeCorrectCount() {
        examResultDto = new ExamResultDto(
                UUID.randomUUID(),
                "certificationSlug",
                "EXAM",
                OffsetDateTime.now(),
                OffsetDateTime.now().plusHours(1),
                3600,
                50,
                -40,
                80.0,
                true,
                themeStats,
                wrongQuestions
        );

        assertThat(examResultDto.correctCount()).isEqualTo(-40);
    }

    @Test
    @DisplayName("edge case: negative percentage")
    public void gettersReturnCorrectValuesWithNegativePercentage() {
        examResultDto = new ExamResultDto(
                UUID.randomUUID(),
                "certificationSlug",
                "EXAM",
                OffsetDateTime.now(),
                OffsetDateTime.now().plusHours(1),
                3600,
                50,
                40,
                -80.0,
                true,
                themeStats,
                wrongQuestions
        );

        assertThat(examResultDto.percentage()).isEqualTo(-80.0);
    }

    @Test
    @DisplayName("error case: null startedAt")
    public void throwsExceptionWhenStartedAtIsNull() {
        ExamResultDto invalidExamResultDto = new ExamResultDto(
                UUID.randomUUID(),
                "certificationSlug",
                "EXAM",
                null,
                OffsetDateTime.now().plusHours(1),
                3600,
                50,
                40,
                80.0,
                true,
                themeStats,
                wrongQuestions
        );

        assertThatThrownBy(() -> invalidExamResultDto.startedAt()).isInstanceOf(NullPointerException.class);
    }

    @Test
    @DisplayName("error case: null endedAt")
    public void throwsExceptionWhenEndedAtIsNull() {
        ExamResultDto invalidExamResultDto = new ExamResultDto(
                UUID.randomUUID(),
                "certificationSlug",
                "EXAM",
                OffsetDateTime.now(),
                null,
                3600,
                50,
                40,
                80.0,
                true,
                themeStats,
                wrongQuestions
        );

        assertThatThrownBy(() -> invalidExamResultDto.endedAt()).isInstanceOf(NullPointerException.class);
    }
}