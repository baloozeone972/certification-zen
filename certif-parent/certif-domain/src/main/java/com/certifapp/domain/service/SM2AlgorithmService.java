// certif-parent/certif-domain/src/main/java/com/certifapp/domain/service/SM2AlgorithmService.java
package com.certifapp.domain.service;

import com.certifapp.domain.model.learning.SM2Schedule;

import java.time.LocalDate;
import java.util.UUID;

/**
 * Pure domain service implementing the SM-2 spaced-repetition algorithm.
 *
 * <p>Reference: Piotr Wozniak, "Optimization of Learning" (1990).
 * This implementation follows the original SM-2 specification.</p>
 *
 * <h2>Algorithm summary</h2>
 * <pre>
 * For quality q in [0, 5]:
 *   if q >= 3 (correct):
 *     if repetitions == 0: interval = 1
 *     if repetitions == 1: interval = 6
 *     if repetitions >= 2: interval = round(previousInterval * easeFactor)
 *     easeFactor = easeFactor + 0.1 - (5 - q) * (0.08 + (5 - q) * 0.02)
 *     easeFactor = max(1.3, easeFactor)
 *     repetitions++
 *   else (incorrect, q < 3):
 *     repetitions = 0
 *     interval = 1
 *
 * nextReviewDate = today + interval days
 * </pre>
 *
 * <p>No Spring dependencies — unit-testable directly.</p>
 */
public class SM2AlgorithmService {

    /**
     * Computes the updated SM-2 schedule after a review with a given quality rating.
     *
     * @param current the current schedule for this (user, question) pair
     * @param quality the review quality rating, 0-5:
     *                <ul>
     *                  <li>0 — complete blackout</li>
     *                  <li>1 — incorrect, but remembered on seeing the answer</li>
     *                  <li>2 — incorrect with serious difficulty</li>
     *                  <li>3 — correct with serious difficulty</li>
     *                  <li>4 — correct with some hesitation</li>
     *                  <li>5 — perfect recall</li>
     *                </ul>
     * @return a new {@link SM2Schedule} with updated parameters
     * @throws IllegalArgumentException if quality is not in [0, 5]
     */
    public SM2Schedule review(SM2Schedule current, int quality) {
        if (quality < 0 || quality > 5) {
            throw new IllegalArgumentException("SM-2 quality must be 0-5, got: " + quality);
        }

        double newEaseFactor;
        int    newInterval;
        int    newRepetitions;

        if (quality >= 3) {
            // Correct answer
            newInterval = switch (current.repetitions()) {
                case 0  -> 1;
                case 1  -> 6;
                default -> (int) Math.round(current.intervalDays() * current.easeFactor());
            };
            newRepetitions = current.repetitions() + 1;
            newEaseFactor  = computeNewEaseFactor(current.easeFactor(), quality);
        } else {
            // Incorrect — reset to beginning
            newInterval    = 1;
            newRepetitions = 0;
            newEaseFactor  = current.easeFactor(); // EF unchanged on failure per SM-2 spec
        }

        LocalDate newDueDate = LocalDate.now().plusDays(newInterval);

        return new SM2Schedule(
                current.id(),
                current.userId(),
                current.questionId(),
                newEaseFactor,
                newInterval,
                newRepetitions,
                newDueDate,
                java.time.OffsetDateTime.now()
        );
    }

    /**
     * Computes the new ease factor after a correct answer.
     *
     * <p>Formula: {@code EF' = EF + 0.1 - (5-q) * (0.08 + (5-q) * 0.02)}
     * with {@code EF' >= 1.3}</p>
     *
     * @param currentEf current ease factor
     * @param quality   review quality (must be >= 3)
     * @return new ease factor, never below {@link SM2Schedule#MIN_EASE_FACTOR}
     */
    double computeNewEaseFactor(double currentEf, int quality) {
        double newEf = currentEf + 0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02);
        return Math.max(SM2Schedule.MIN_EASE_FACTOR, newEf);
    }

    /**
     * Creates the initial SM-2 schedule for a user encountering a question for the first time.
     *
     * @param userId     the user
     * @param questionId the question
     * @return initial schedule due today with default ease factor
     */
    public SM2Schedule initialSchedule(UUID userId, UUID questionId) {
        return SM2Schedule.initial(userId, questionId);
    }
}
