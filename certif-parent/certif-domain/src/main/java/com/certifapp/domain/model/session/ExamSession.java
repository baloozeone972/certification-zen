// certif-domain/src/main/java/com/certifapp/domain/model/session/ExamSession.java
package com.certifapp.domain.model.session;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;

/**
 * Domain aggregate root representing one exam attempt by a user.
 *
 * <h2>Key migration decisions (from CertiPrep Engine)</h2>
 * <ul>
 *   <li>{@code durationSeconds} = actual elapsed time (ended_at − started_at).
 *       This is NOT the exam max duration (stored in {@code Certification.examDurationMin}).</li>
 *   <li>{@code correctCount} is denormalised (calculated once at submission time).</li>
 *   <li>{@code percentage} is denormalised with a CHECK 0–100 constraint in PostgreSQL.</li>
 *   <li>Timer enforcement is done server-side: the session is auto-submitted
 *       when {@code startedAt + examDurationSeconds < now()}.</li>
 * </ul>
 *
 * <h2>Canonical scoring formula</h2>
 * {@code percentage = correctCount * 100.0 / totalQuestions}<br>
 * {@code passed = percentage >= certification.passingScore()}
 *
 * @param id              surrogate UUID
 * @param userId          owner user UUID
 * @param certificationId parent certification slug
 * @param mode            {@link ExamMode}
 * @param status          {@link SessionStatus}
 * @param startedAt       server timestamp when the session was created
 * @param endedAt         server timestamp when the session was submitted or expired
 * @param durationSeconds actual elapsed time in seconds ({@code null} if still in progress)
 * @param totalQuestions  number of questions in this session
 * @param correctCount    denormalised correct answer count (0 until submission)
 * @param percentage      denormalised score 0.0–100.0 (0.0 until submission)
 * @param passed          whether the passing threshold was met
 * @param answers         user answers collected during the session
 */
public record ExamSession(
        UUID            id,
        UUID            userId,
        String          certificationId,
        ExamMode        mode,
        SessionStatus   status,
        OffsetDateTime  startedAt,
        OffsetDateTime  endedAt,
        Integer         durationSeconds,
        int             totalQuestions,
        int             correctCount,
        double          percentage,
        boolean         passed,
        List<UserAnswer> answers
) {

    /**
     * Compact constructor — enforces invariants.
     */
    public ExamSession {
        if (userId == null)          throw new IllegalArgumentException("userId must not be null");
        if (certificationId == null || certificationId.isBlank())
            throw new IllegalArgumentException("certificationId must not be blank");
        if (mode == null)            throw new IllegalArgumentException("mode must not be null");
        if (status == null)          throw new IllegalArgumentException("status must not be null");
        if (startedAt == null)       throw new IllegalArgumentException("startedAt must not be null");
        if (totalQuestions <= 0)
            throw new IllegalArgumentException("totalQuestions must be > 0, got: " + totalQuestions);
        if (correctCount < 0 || correctCount > totalQuestions)
            throw new IllegalArgumentException(
                "correctCount must be 0..%d, got: %d".formatted(totalQuestions, correctCount));
        if (percentage < 0.0 || percentage > 100.0)
            throw new IllegalArgumentException(
                "percentage must be 0-100, got: " + percentage);
        answers = answers == null ? List.of() : List.copyOf(answers);
    }

    /**
     * Factory: creates a new in-progress session just before questions are served.
     *
     * @param userId          user starting the session
     * @param certificationId target certification
     * @param mode            exam mode
     * @param totalQuestions  number of questions drawn
     * @return a fresh {@code IN_PROGRESS} session with zero scores
     */
    public static ExamSession start(
            UUID userId, String certificationId, ExamMode mode, int totalQuestions) {
        return new ExamSession(
            UUID.randomUUID(), userId, certificationId, mode,
            SessionStatus.IN_PROGRESS,
            OffsetDateTime.now(), null, null,
            totalQuestions, 0, 0.0, false, List.of());
    }

    /**
     * Returns {@code true} if this session is still accepting answers.
     *
     * @return {@code true} when {@code status == IN_PROGRESS}
     */
    public boolean isInProgress() {
        return status == SessionStatus.IN_PROGRESS;
    }

    /**
     * Returns the answer for a specific question, or {@code null} if not answered yet.
     *
     * @param questionId question UUID to look up
     * @return the matching {@link UserAnswer} or {@code null}
     */
    public UserAnswer answerFor(UUID questionId) {
        return answers.stream()
            .filter(a -> questionId.equals(a.questionId()))
            .findFirst()
            .orElse(null);
    }
}
