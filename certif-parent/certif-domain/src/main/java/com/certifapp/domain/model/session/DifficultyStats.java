// certif-domain/src/main/java/com/certifapp/domain/model/session/DifficultyStats.java
package com.certifapp.domain.model.session;

import com.certifapp.domain.model.question.DifficultyLevel;

/**
 * Immutable statistics broken down by {@link DifficultyLevel} for one completed session.
 *
 * <p>Produced by {@code ScoringService#calculateDifficultyStats}.
 * Skipped questions are excluded from this calculation — only answered questions
 * contribute to the percentage.</p>
 *
 * @param difficulty difficulty level
 * @param correct    number of correctly answered questions at this difficulty
 * @param total      total answered (non-skipped) questions at this difficulty
 */
public record DifficultyStats(
        DifficultyLevel difficulty,
        int             correct,
        int             total
) {

    /**
     * Compact constructor — validates non-negative counts.
     */
    public DifficultyStats {
        if (difficulty == null) throw new IllegalArgumentException("difficulty must not be null");
        if (correct < 0) throw new IllegalArgumentException("correct must be >= 0");
        if (total   < 0) throw new IllegalArgumentException("total must be >= 0");
        if (correct > total) {
            throw new IllegalArgumentException(
                "correct (%d) cannot exceed total (%d)".formatted(correct, total));
        }
    }

    /**
     * Percentage of correct answers at this difficulty level.
     *
     * @return value between 0.0 and 100.0, or 0.0 if no questions at this level were answered
     */
    public double percentage() {
        return total == 0 ? 0.0 : (correct * 100.0) / total;
    }
}
