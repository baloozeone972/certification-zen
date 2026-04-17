// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/learning/SM2ProgressDto.java
package com.certifapp.application.dto.learning;

import java.time.LocalDate;
import java.util.UUID;

/**
 * Updated SM-2 schedule returned after a flashcard review.
 *
 * @param flashcardId    the reviewed flashcard
 * @param nextReviewDate new scheduled date
 * @param intervalDays   new interval in days
 * @param easeFactor     updated ease factor
 * @param repetitions    updated repetition count
 */
public record SM2ProgressDto(
        UUID flashcardId,
        LocalDate nextReviewDate,
        int intervalDays,
        double easeFactor,
        int repetitions
) {
}
