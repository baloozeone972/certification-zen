// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/exam/QuestionOptionDto.java
package com.certifapp.application.dto.exam;

import java.util.UUID;

/**
 * Answer option served to the user during an exam.
 * {@code isCorrect} is intentionally excluded — never sent before session submission.
 *
 * @param id    option UUID
 * @param label display letter: A, B, C, D or E
 * @param text  option text
 */
public record QuestionOptionDto(UUID id, char label, String text) {}
