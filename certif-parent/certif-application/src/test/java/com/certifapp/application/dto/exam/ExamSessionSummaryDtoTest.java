package com.certifapp.application.dto.exam;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.OffsetDateTime;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class ExamSessionSummaryDtoTest {

    @Mock
    private UUID mockId;

    @Mock
    private String mockCertificationId;

    @Mock
    private String mockMode;

    @Mock
    private OffsetDateTime mockStartedAt;

    @InjectMocks
    private ExamSessionSummaryDto examSessionSummaryDto;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    @DisplayName("Nominal case: create ExamSessionSummaryDto with all parameters")
    public void testCreateExamSessionSummaryDto_NominalCase() {
        when(mockId).thenReturn(UUID.randomUUID());
        when(mockCertificationId).thenReturn("certification123");
        when(mockMode).thenReturn("EXAM");
        when(mockStartedAt).thenReturn(OffsetDateTime.now());

        ExamSessionSummaryDto dto = new ExamSessionSummaryDto(
                mockId,
                mockCertificationId,
                mockMode,
                mockStartedAt,
                900,
                50,
                40,
                80.0,
                true
        );

        assertThat(dto.id()).isEqualTo(mockId);
        assertThat(dto.certificationId()).isEqualTo(mockCertificationId);
        assertThat(dto.mode()).isEqualTo(mockMode);
        assertThat(dto.startedAt()).isEqualTo(mockStartedAt);
        assertThat(dto.durationSeconds()).isEqualTo(900);
        assertThat(dto.totalQuestions()).isEqualTo(50);
        assertThat(dto.correctCount()).isEqualTo(40);
        assertThat(dto.percentage()).isEqualTo(80.0);
        assertThat(dto.passed()).isTrue();
    }

    @Test
    @DisplayName("Edge case: create ExamSessionSummaryDto with minimum parameters")
    public void testCreateExamSessionSummaryDto_EdgeCase() {
        when(mockId).thenReturn(UUID.randomUUID());
        when(mockCertificationId).thenReturn("certification123");
        when(mockMode).thenReturn("FREE");
        when(mockStartedAt).thenReturn(OffsetDateTime.now());

        ExamSessionSummaryDto dto = new ExamSessionSummaryDto(
                mockId,
                mockCertificationId,
                mockMode,
                mockStartedAt,
                0,
                0,
                0,
                0.0,
                false
        );

        assertThat(dto.id()).isEqualTo(mockId);
        assertThat(dto.certificationId()).isEqualTo(mockCertificationId);
        assertThat(dto.mode()).isEqualTo(mockMode);
        assertThat(dto.startedAt()).isEqualTo(mockStartedAt);
        assertThat(dto.durationSeconds()).isEqualTo(0);
        assertThat(dto.totalQuestions()).isEqualTo(0);
        assertThat(dto.correctCount()).isEqualTo(0);
        assertThat(dto.percentage()).isEqualTo(0.0);
        assertThat(dto.passed()).isFalse();
    }

    @Test
    @DisplayName("Error case: create ExamSessionSummaryDto with negative duration")
    public void testCreateExamSessionSummaryDto_ErrorCase_NegativeDuration() {
        when(mockId).thenReturn(UUID.randomUUID());
        when(mockCertificationId).thenReturn("certification123");
        when(mockMode).thenReturn("REVISION");
        when(mockStartedAt).thenReturn(OffsetDateTime.now());

        ExamSessionSummaryDto dto = new ExamSessionSummaryDto(
                mockId,
                mockCertificationId,
                mockMode,
                mockStartedAt,
                -900,
                50,
                40,
                80.0,
                true
        );

        assertThat(dto.id()).isEqualTo(mockId);
        assertThat(dto.certificationId()).isEqualTo(mockCertificationId);
        assertThat(dto.mode()).isEqualTo(mockMode);
        assertThat(dto.startedAt()).isEqualTo(mockStartedAt);
        assertThat(dto.durationSeconds()).isEqualTo(-900);
        assertThat(dto.totalQuestions()).isEqualTo(50);
        assertThat(dto.correctCount()).isEqualTo(40);
        assertThat(dto.percentage()).isEqualTo(80.0);
        assertThat(dto.passed()).isTrue();
    }
}
