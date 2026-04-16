// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/exam/ExamSessionSummaryDto.java
package com.certifapp.application.dto.exam;

import java.time.OffsetDateTime;
import java.util.UUID;

/**
 * Lightweight exam session summary for the history list.
 *
 * @param id               session UUID
 * @param certificationId  certification slug
 * @param mode             EXAM | FREE | REVISION
 * @param startedAt        session start timestamp
 * @param durationSeconds  actual elapsed time
 * @param totalQuestions   total questions
 * @param correctCount     correct answers count
 * @param percentage       score percentage
 * @param passed           whether the exam was passed
 */
public record ExamSessionSummaryDto(
        UUID           id,
        String         certificationId,
        String         mode,
        OffsetDateTime startedAt,
        int            durationSeconds,
        int            totalQuestions,
        int            correctCount,
        double         percentage,
        boolean        passed
) {}
