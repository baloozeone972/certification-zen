package com.certifapp.application.dto.exam;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import org.assertj.core.api.Assertions;

import java.time.OffsetDateTime;
import java.util.Collections;
import java.util.List;
import java.util.UUID;

@ExtendWith(MockitoExtension.class)
public class ExamSessionDtoTest {

    @InjectMocks
    private ExamSessionDto examSessionDto;

    @BeforeEach
    public void setUp() {
        UUID id = UUID.randomUUID();
        String certificationId = "cert123";
        String mode = "EXAM";
        List<QuestionDto> questions = Collections.emptyList();
        OffsetDateTime startedAt = OffsetDateTime.now();
        int durationSeconds = 3600;
        boolean timerEnabled = true;

        examSessionDto = new ExamSessionDto(id, certificationId, mode, questions, startedAt, durationSeconds, timerEnabled);
    }

    @Test
    @DisplayName("should create an ExamSessionDto with nominal values")
    public void createExamSessionDto_nominalCase() {
        Assertions.assertThat(examSessionDto.id()).isNotNull();
        Assertions.assertThat(examSessionDto.certificationId()).isEqualTo("cert123");
        Assertions.assertThat(examSessionDto.mode()).isEqualTo("EXAM");
        Assertions.assertThat(examSessionDto.questions()).isEmpty();
        Assertions.assertThat(examSessionDto.startedAt()).isNotNull();
        Assertions.assertThat(examSessionDto.durationSeconds()).isEqualTo(3600);
        Assertions.assertThat(examSessionDto.timerEnabled()).isTrue();
    }

    @Test
    @DisplayName("should handle an empty questions list")
    public void createExamSessionDto_emptyQuestionsList() {
        List<QuestionDto> questions = Collections.emptyList();
        examSessionDto = new ExamSessionDto(UUID.randomUUID(), "cert123", "EXAM", questions, OffsetDateTime.now(), 3600, true);
        Assertions.assertThat(examSessionDto.questions()).isEmpty();
    }

    @Test
    @DisplayName("should handle a null mode value")
    public void createExamSessionDto_nullMode() {
        examSessionDto = new ExamSessionDto(UUID.randomUUID(), "cert123", null, Collections.emptyList(), OffsetDateTime.now(), 3600, true);
        Assertions.assertThat(examSessionDto.mode()).isNull();
    }

    @Test
    @DisplayName("should handle a negative duration seconds value")
    public void createExamSessionDto_negativeDurationSeconds() {
        examSessionDto = new ExamSessionDto(UUID.randomUUID(), "cert123", "EXAM", Collections.emptyList(), OffsetDateTime.now(), -1, true);
        Assertions.assertThat(examSessionDto.durationSeconds()).isEqualTo(-1);
    }

    @Test
    @DisplayName("should handle a zero duration seconds value")
    public void createExamSessionDto_zeroDurationSeconds() {
        examSessionDto = new ExamSessionDto(UUID.randomUUID(), "cert123", "EXAM", Collections.emptyList(), OffsetDateTime.now(), 0, true);
        Assertions.assertThat(examSessionDto.durationSeconds()).isEqualTo(0);
    }

    @Test
    @DisplayName("should handle a null startedAt value")
    public void createExamSessionDto_nullStartedAt() {
        examSessionDto = new ExamSessionDto(UUID.randomUUID(), "cert123", "EXAM", Collections.emptyList(), null, 3600, true);
        Assertions.assertThat(examSessionDto.startedAt()).isNull();
    }

    @Test
    @DisplayName("should handle a false timerEnabled value")
    public void createExamSessionDto_falseTimerEnabled() {
        examSessionDto = new ExamSessionDto(UUID.randomUUID(), "cert123", "EXAM", Collections.emptyList(), OffsetDateTime.now(), 3600, false);
        Assertions.assertThat(examSessionDto.timerEnabled()).isFalse();
    }
}
