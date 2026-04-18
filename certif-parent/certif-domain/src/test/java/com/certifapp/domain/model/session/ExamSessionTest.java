// certif-parent/certif-domain/src/test/java/com/certifapp/domain/model/session/ExamSessionTest.java
package com.certifapp.domain.model.session;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.*;

/**
 * Unit tests for {@link ExamSession} record.
 * Covers: factory method, compact constructor invariants, utility methods.
 */
@DisplayName("ExamSession")
class ExamSessionTest {

    private static final UUID      USER_ID         = UUID.randomUUID();
    private static final String    CERT_ID         = "ocp21";
    private static final ExamMode  MODE            = ExamMode.EXAM;
    private static final OffsetDateTime STARTED_AT = OffsetDateTime.now();

    // ── Helpers ──────────────────────────────────────────────────────────────

    private ExamSession buildSession(SessionStatus status, int total, int correct, double pct) {
        return new ExamSession(
                UUID.randomUUID(), USER_ID, CERT_ID, MODE, status,
                STARTED_AT, null, null,
                total, correct, pct, pct >= 68, List.of()
        );
    }

    // ── Factory: start() ─────────────────────────────────────────────────────

    @Nested
    @DisplayName("start() factory")
    class StartFactory {

        @Test
        @DisplayName("creates IN_PROGRESS session with zero scores")
        void start_shouldCreateInProgressWithZeroScores() {
            ExamSession session = ExamSession.start(USER_ID, CERT_ID, MODE, 80);

            assertThat(session.status()).isEqualTo(SessionStatus.IN_PROGRESS);
            assertThat(session.userId()).isEqualTo(USER_ID);
            assertThat(session.certificationId()).isEqualTo(CERT_ID);
            assertThat(session.mode()).isEqualTo(MODE);
            assertThat(session.totalQuestions()).isEqualTo(80);
            assertThat(session.correctCount()).isZero();
            assertThat(session.percentage()).isZero();
            assertThat(session.passed()).isFalse();
            assertThat(session.durationSeconds()).isNull();
            assertThat(session.endedAt()).isNull();
            assertThat(session.answers()).isEmpty();
        }

        @Test
        @DisplayName("generates unique IDs on each call")
        void start_shouldGenerateUniqueIds() {
            ExamSession s1 = ExamSession.start(USER_ID, CERT_ID, MODE, 10);
            ExamSession s2 = ExamSession.start(USER_ID, CERT_ID, MODE, 10);
            assertThat(s1.id()).isNotEqualTo(s2.id());
        }
    }

    // ── Compact constructor invariants ────────────────────────────────────────

    @Nested
    @DisplayName("compact constructor validations")
    class ConstructorValidations {

        @Test
        @DisplayName("null userId → IllegalArgumentException")
        void nullUserId_shouldThrow() {
            assertThatThrownBy(() ->
                new ExamSession(UUID.randomUUID(), null, CERT_ID, MODE,
                        SessionStatus.IN_PROGRESS, STARTED_AT, null, null,
                        10, 0, 0.0, false, List.of())
            ).isInstanceOf(IllegalArgumentException.class)
             .hasMessageContaining("userId");
        }

        @Test
        @DisplayName("blank certificationId → IllegalArgumentException")
        void blankCertId_shouldThrow() {
            assertThatThrownBy(() ->
                new ExamSession(UUID.randomUUID(), USER_ID, "  ", MODE,
                        SessionStatus.IN_PROGRESS, STARTED_AT, null, null,
                        10, 0, 0.0, false, List.of())
            ).isInstanceOf(IllegalArgumentException.class)
             .hasMessageContaining("certificationId");
        }

        @Test
        @DisplayName("totalQuestions = 0 → IllegalArgumentException")
        void zeroTotalQuestions_shouldThrow() {
            assertThatThrownBy(() ->
                new ExamSession(UUID.randomUUID(), USER_ID, CERT_ID, MODE,
                        SessionStatus.IN_PROGRESS, STARTED_AT, null, null,
                        0, 0, 0.0, false, List.of())
            ).isInstanceOf(IllegalArgumentException.class)
             .hasMessageContaining("totalQuestions");
        }

        @Test
        @DisplayName("correctCount > totalQuestions → IllegalArgumentException")
        void correctCountExceedsTotal_shouldThrow() {
            assertThatThrownBy(() ->
                new ExamSession(UUID.randomUUID(), USER_ID, CERT_ID, MODE,
                        SessionStatus.IN_PROGRESS, STARTED_AT, null, null,
                        10, 11, 0.0, false, List.of())
            ).isInstanceOf(IllegalArgumentException.class)
             .hasMessageContaining("correctCount");
        }

        @Test
        @DisplayName("percentage = 101.0 → IllegalArgumentException")
        void percentageOver100_shouldThrow() {
            assertThatThrownBy(() ->
                new ExamSession(UUID.randomUUID(), USER_ID, CERT_ID, MODE,
                        SessionStatus.IN_PROGRESS, STARTED_AT, null, null,
                        10, 5, 101.0, false, List.of())
            ).isInstanceOf(IllegalArgumentException.class)
             .hasMessageContaining("percentage");
        }

        @Test
        @DisplayName("null answers → defaults to empty list")
        void nullAnswers_shouldDefaultToEmpty() {
            ExamSession s = new ExamSession(UUID.randomUUID(), USER_ID, CERT_ID, MODE,
                    SessionStatus.IN_PROGRESS, STARTED_AT, null, null,
                    10, 0, 0.0, false, null);
            assertThat(s.answers()).isEmpty();
        }
    }

    // ── isInProgress() ───────────────────────────────────────────────────────

    @Nested
    @DisplayName("isInProgress()")
    class IsInProgress {

        @Test
        @DisplayName("IN_PROGRESS → true")
        void inProgress_shouldReturnTrue() {
            assertThat(buildSession(SessionStatus.IN_PROGRESS, 10, 5, 50.0).isInProgress()).isTrue();
        }

        @Test
        @DisplayName("COMPLETED → false")
        void completed_shouldReturnFalse() {
            assertThat(buildSession(SessionStatus.COMPLETED, 10, 5, 50.0).isInProgress()).isFalse();
        }

        @Test
        @DisplayName("ABANDONED → false")
        void abandoned_shouldReturnFalse() {
            assertThat(buildSession(SessionStatus.ABANDONED, 10, 5, 50.0).isInProgress()).isFalse();
        }

        @Test
        @DisplayName("EXPIRED → false")
        void expired_shouldReturnFalse() {
            assertThat(buildSession(SessionStatus.EXPIRED, 10, 5, 50.0).isInProgress()).isFalse();
        }
    }

    // ── answerFor() ──────────────────────────────────────────────────────────

    @Nested
    @DisplayName("answerFor()")
    class AnswerFor {

        @Test
        @DisplayName("existing questionId → returns correct answer")
        void existingQuestion_shouldReturnAnswer() {
            UUID questionId = UUID.randomUUID();
            UUID sessionId  = UUID.randomUUID();
            UserAnswer answer = new UserAnswer(
                    UUID.randomUUID(), sessionId, questionId,
                    UUID.randomUUID(), true, false, 500L, OffsetDateTime.now());
            ExamSession session = new ExamSession(
                    UUID.randomUUID(), USER_ID, CERT_ID, MODE,
                    SessionStatus.IN_PROGRESS, STARTED_AT, null, null,
                    10, 0, 0.0, false, List.of(answer));

            assertThat(session.answerFor(questionId)).isEqualTo(answer);
        }

        @Test
        @DisplayName("non-existing questionId → returns null")
        void unknownQuestion_shouldReturnNull() {
            ExamSession session = buildSession(SessionStatus.IN_PROGRESS, 10, 0, 0.0);
            assertThat(session.answerFor(UUID.randomUUID())).isNull();
        }
    }
}
