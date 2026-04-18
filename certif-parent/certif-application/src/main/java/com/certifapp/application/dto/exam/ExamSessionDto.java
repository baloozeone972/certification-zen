// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/exam/ExamSessionDto.java
package com.certifapp.application.dto.exam;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;

/**
 * Active exam session returned after {@code StartExamSessionUseCase}.
 *
 * @param id              session UUID
 * @param certificationId certification slug
 * @param mode            EXAM | FREE | REVISION
 * @param questions       drawn questions (without correct answers)
 * @param startedAt       session start timestamp
 * @param durationSeconds max timer in seconds (0 = unlimited)
 * @param timerEnabled    whether a countdown timer is active
 */
public record ExamSessionDto(
        UUID id,
        String certificationId,
        String mode,
        List<QuestionDto> questions,
        OffsetDateTime startedAt,
        int durationSeconds,
        boolean timerEnabled
) {
}
