package com.certifapp.domain.model.session;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;

public class ExamSessionTest {

    private UUID userId = UUID.randomUUID();
    private String certificationId = "test-certification";
    private ExamMode mode = ExamMode.NORMAL;
    private OffsetDateTime startedAt = OffsetDateTime.now();

    @BeforeEach
    public void setUp() {
        // Arrange
        examSession = new ExamSession(
                UUID.randomUUID(), userId, certificationId, mode,
                SessionStatus.IN_PROGRESS,
                startedAt, null, null,
                10, 5, 50.0, false, List.of());
    }

    @Test
    @DisplayName("should create a new in-progress session")
    public void start_examSession_creation() {
        // Arrange
        ExamSession session = ExamSession.start(userId, certificationId, mode, 10);

        // Act & Assert
        assertThat(session.status()).isEqualTo(SessionStatus.IN_PROGRESS);
        assertThat(session.userId()).isEqualTo(userId);
        assertThat(session.certificationId()).isEqualTo(certificationId);
        assertThat(session.mode()).isEqualTo(mode);
        assertThat(session.startedAt()).isNotNull();
        assertThat(session.durationSeconds()).isNull();
        assertThat(session.totalQuestions()).isEqualTo(10);
        assertThat(session.correctCount()).isEqualTo(0);
        assertThat(session.percentage()).isEqualTo(0.0);
        assertThat(session.passed()).isEqualTo(false);
        assertThat(session.answers()).isEmpty();
    }

    @Test
    @DisplayName("should be in progress")
    public void isInProgress_statusInProgress() {
        // Arrange
        examSession = new ExamSession(
                UUID.randomUUID(), userId, certificationId, mode,
                SessionStatus.IN_PROGRESS,
                startedAt, null, null,
                10, 5, 50.0, false, List.of());

        // Act & Assert
        assertThat(examSession.isInProgress()).isTrue();
    }

    @Test
    @DisplayName("should not be in progress")
    public void isInProgress_statusNotInProgress() {
        // Arrange
        examSession = new ExamSession(
                UUID.randomUUID(), userId, certificationId, mode,
                SessionStatus.SUBMITTED,
                startedAt, null, null,
                10, 5, 50.0, false, List.of());

        // Act & Assert
        assertThat(examSession.isInProgress()).isFalse();
    }

    @Test
    @DisplayName("should return answer for a specific question")
    public void answerFor_existingQuestion() {
        // Arrange
        UserAnswer answer = new UserAnswer(UUID.randomUUID(), UUID.randomUUID(), "A");
        examSession.addAnswer(answer);

        // Act
        UserAnswer result = examSession.answerFor(answer.questionId());

        // Assert
        assertThat(result).isNotNull();
    }

    @Test
    @DisplayName("should return null for a non-existing question")
    public void answerFor_nonExistingQuestion() {
        // Arrange
        UUID nonExistingQuestionId = UUID.randomUUID();

        // Act
        UserAnswer result = examSession.answerFor(nonExistingQuestionId);

        // Assert
        assertThat(result).isNull();
    }
}