// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/learning/FlashcardDto.java
package com.certifapp.application.dto.learning;

import java.time.LocalDate;
import java.util.UUID;

/**
 * Flashcard served to the user for SM-2 spaced-repetition review.
 *
 * @param id             flashcard UUID
 * @param frontText      concept or question on the front
 * @param backText       answer or explanation on the back
 * @param codeExample    optional code snippet
 * @param nextReviewDate next scheduled review date
 * @param easeFactor     current SM-2 ease factor
 * @param intervalDays   current SM-2 interval
 * @param repetitions    number of successful consecutive reviews
 */
public record FlashcardDto(
        UUID id,
        String frontText,
        String backText,
        String codeExample,
        LocalDate nextReviewDate,
        double easeFactor,
        int intervalDays,
        int repetitions
) {
}
