// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/exam/QuestionDto.java
package com.certifapp.application.dto.exam;

import java.util.List;
import java.util.UUID;

/**
 * Question served during an exam — correct answer is hidden.
 *
 * @param id         question UUID
 * @param statement  question text (may contain Markdown)
 * @param options    answer choices without {@code isCorrect} flag
 * @param themeCode  theme code for palette colouring
 * @param difficulty easy | medium | hard
 */
public record QuestionDto(
        UUID id,
        String statement,
        List<QuestionOptionDto> options,
        String themeCode,
        String difficulty
) {
}
