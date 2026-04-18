// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/exam/UserAnswerDto.java
package com.certifapp.application.dto.exam;

import java.util.UUID;

/**
 * Answer recorded for one question, returned after {@code SubmitAnswerUseCase}.
 *
 * @param questionId       the answered question
 * @param selectedOptionId the chosen option — null if skipped
 * @param isCorrect        whether the selected option is correct
 * @param isSkipped        true if no option was selected
 */
public record UserAnswerDto(
        UUID questionId,
        UUID selectedOptionId,
        boolean isCorrect,
        boolean isSkipped
) {
}
