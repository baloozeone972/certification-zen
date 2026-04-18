package com.certifapp.domain.model.session;

import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

import java.time.OffsetDateTime;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class ExamSessionTest {

    @Mock
    private List<UserAnswer> answers;

    @InjectMocks
    private ExamSession examSession;

    private UUID userId = UUID.randomUUID();
    private String certificationId = "test-certification";
    private ExamMode mode = ExamMode.NORMAL;
    private OffsetDateTime startedAt = OffsetDateTime.now();

    @BeforeEach
    public void setUp() {
        examSession = new ExamSession(
                UUID.randomUUID(), userId, certificationId, mode,
                SessionStatus.IN_PROGRESS,
                startedAt, null, null,
                10, 5, 50.0, false, List.of());
    }

    @Test
    @DisplayName("should create a new in-progress session")
    public void start_examSession_creation() {
        ExamSession session = ExamSession.start(userId, certificationId, mode, 10);
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
        examSession = new ExamSession(
                UUID.randomUUID(), userId, certificationId, mode,
                SessionStatus.IN_PROGRESS,
                startedAt, null, null,
                10, 5, 50.0, false, List.of());
        assertThat(examSession.isInProgress()).isTrue();
    }

    @Test
    @DisplayName("should not be in progress")
    public void isInProgress_statusNotInProgress() {
        examSession = new ExamSession(
                UUID.randomUUID(), userId, certificationId, mode,
                SessionStatus.SUBMITTED,
                startedAt, null, null,
                10, 5, 50.0, false, List.of());
        assertThat(examSession.isInProgress()).isFalse();
    }

    @Test
    @DisplayName("should return answer for a specific question")
    public void answerFor_existingQuestion() {
        UserAnswer answer = new UserAnswer(UUID.randomUUID(), UUID.randomUUID(), "A");
        answers.add(answer);
        examSession = new ExamSession(
                UUID.randomUUID(), userId, certificationId, mode,
                SessionStatus.IN_PROGRESS,
                startedAt, null, null,
                10, 5, 50.0, false, List.of(answer));

        UserAnswer result = examSession.answerFor(answer.questionId());
        assertThat(result).isNotNull();
    }

    @Test
    @DisplayName("should return null for a non-existing question")
    public void answerFor_nonExistingQuestion() {
        UUID nonExistingQuestionId = UUID.randomUUID();
        UserAnswer result = examSession.answerFor(nonExistingQuestionId);
        assertThat(result).isNull();
    }
}
