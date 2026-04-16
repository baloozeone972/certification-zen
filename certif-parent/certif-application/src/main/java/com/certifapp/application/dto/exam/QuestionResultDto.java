// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/exam/QuestionResultDto.java
package com.certifapp.application.dto.exam;

import java.util.List;
import java.util.UUID;

/**
 * Question with full result details shown after session submission.
 * Includes the correct answer and explanation — never served during the exam.
 *
 * @param id                  question UUID
 * @param statement           question text
 * @param options             all options with display label and text
 * @param correctOptionId     UUID of the correct option
 * @param selectedOptionId    UUID of the user's selected option — null if skipped
 * @param isCorrect           whether the user answered correctly
 * @param isSkipped           whether the question was skipped
 * @param explanationOriginal original explanation text
 * @param explanationEnriched AI-enriched explanation — null if not yet enriched
 * @param officialDocUrl      optional link to vendor documentation
 * @param themeCode           theme code
 * @param difficulty          question difficulty
 */
public record QuestionResultDto(
        UUID                 id,
        String               statement,
        List<QuestionOptionDto> options,
        UUID                 correctOptionId,
        UUID                 selectedOptionId,
        boolean              isCorrect,
        boolean              isSkipped,
        String               explanationOriginal,
        String               explanationEnriched,
        String               officialDocUrl,
        String               themeCode,
        String               difficulty
) {}
