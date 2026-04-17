// certif-domain/src/main/java/com/certifapp/domain/model/session/UserAnswer.java
package com.certifapp.domain.model.session;

import java.time.OffsetDateTime;
import java.util.UUID;

/**
 * Domain record representing a single answer given by a user during an {@link ExamSession}.
 *
 * <p>Key migration note: the legacy SQLite column {@code selected_answer INTEGER = -1}
 * (meaning "skipped") is replaced by {@code selectedOptionId = null} and
 * {@code isSkipped = true} in this domain model.</p>
 *
 * <p>Maps to the {@code user_answers} table in PostgreSQL.</p>
 *
 * @param id               surrogate UUID
 * @param sessionId        parent session UUID
 * @param questionId       answered question UUID
 * @param selectedOptionId UUID of the chosen {@code QuestionOption} — {@code null} if skipped
 * @param isCorrect        {@code true} if the selected option is the correct answer
 * @param isSkipped        {@code true} if no option was selected (skipped question)
 * @param responseTimeMs   milliseconds between question display and answer selection;
 *                         {@code null} if not measured
 * @param answeredAt       server timestamp when the answer was recorded
 */
public record UserAnswer(
        UUID id,
        UUID sessionId,
        UUID questionId,
        UUID selectedOptionId,
        boolean isCorrect,
        boolean isSkipped,
        Long responseTimeMs,
        OffsetDateTime answeredAt
) {

    /**
     * Compact constructor — enforces consistency between {@code selectedOptionId} and {@code isSkipped}.
     */
    public UserAnswer {
        if (selectedOptionId == null && !isSkipped) {
            // Auto-correct: no option selected means skipped
            isSkipped = true;
        }
        if (selectedOptionId != null && isSkipped) {
            throw new IllegalArgumentException(
                    "selectedOptionId must be null when isSkipped is true");
        }
        if (responseTimeMs != null && responseTimeMs < 0) {
            throw new IllegalArgumentException(
                    "responseTimeMs must be >= 0, got: " + responseTimeMs);
        }
    }

    /**
     * Factory method for a skipped question.
     *
     * @param sessionId  parent session UUID
     * @param questionId answered question UUID
     * @return a skipped {@code UserAnswer} with no timestamps
     */
    public static UserAnswer skipped(UUID sessionId, UUID questionId) {
        return new UserAnswer(null, sessionId, questionId, null, false, true, null, null);
    }

    /**
     * Factory method for an answered question (correctness to be computed later).
     *
     * @param sessionId        parent session UUID
     * @param questionId       answered question UUID
     * @param selectedOptionId chosen option UUID
     * @param responseTimeMs   time taken to answer in milliseconds
     * @return an unevaluated {@code UserAnswer}
     */
    public static UserAnswer answered(
            UUID sessionId, UUID questionId, UUID selectedOptionId, long responseTimeMs) {
        return new UserAnswer(
                null, sessionId, questionId, selectedOptionId,
                false, false, responseTimeMs, OffsetDateTime.now());
    }
}
