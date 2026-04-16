// certif-parent/certif-domain/src/main/java/com/certifapp/domain/model/learning/SM2Schedule.java
package com.certifapp.domain.model.learning;

import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.UUID;

/**
 * Spaced-repetition schedule for one (user, question) pair using the SM-2 algorithm.
 *
 * <p>The SM-2 algorithm was designed by Piotr Wozniak (SuperMemo).
 * Key parameters: {@code easeFactor} (EF >= 1.3) and {@code intervalDays}.
 * Maps to the {@code user_sm2_schedule} table in PostgreSQL.</p>
 *
 * @param id               surrogate UUID
 * @param userId           owner user UUID
 * @param questionId       reviewed question UUID
 * @param easeFactor       SM-2 ease factor — minimum 1.3, default 2.5
 * @param intervalDays     days until next review
 * @param repetitions      number of successful consecutive reviews
 * @param dueDate          date when this question should next be reviewed
 * @param lastReviewedAt   timestamp of the most recent review — null if never reviewed
 */
public record SM2Schedule(
        UUID           id,
        UUID           userId,
        UUID           questionId,
        double         easeFactor,
        int            intervalDays,
        int            repetitions,
        LocalDate      dueDate,
        OffsetDateTime lastReviewedAt
) {
    /** Minimum ease factor mandated by the SM-2 specification. */
    public static final double MIN_EASE_FACTOR     = 1.3;
    /** Default ease factor for new items. */
    public static final double DEFAULT_EASE_FACTOR = 2.5;

    public SM2Schedule {
        if (userId     == null) throw new IllegalArgumentException("userId must not be null");
        if (questionId == null) throw new IllegalArgumentException("questionId must not be null");
        if (easeFactor < MIN_EASE_FACTOR)
            throw new IllegalArgumentException("easeFactor must be >= 1.3, got: " + easeFactor);
        if (intervalDays < 0)
            throw new IllegalArgumentException("intervalDays must be >= 0");
        if (repetitions  < 0)
            throw new IllegalArgumentException("repetitions must be >= 0");
        if (dueDate == null) dueDate = LocalDate.now();
    }

    /**
     * Creates a brand-new SM-2 schedule (first encounter with this question).
     *
     * @param userId     owner
     * @param questionId question to schedule
     * @return initial schedule due today
     */
    public static SM2Schedule initial(UUID userId, UUID questionId) {
        return new SM2Schedule(null, userId, questionId,
                DEFAULT_EASE_FACTOR, 0, 0, LocalDate.now(), null);
    }

    /** Returns {@code true} if this item is due for review today or overdue. */
    public boolean isDueToday() {
        return !dueDate.isAfter(LocalDate.now());
    }
}
