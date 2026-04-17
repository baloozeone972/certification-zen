// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/learning/AdaptivePlanDto.java
package com.certifapp.application.dto.learning;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

/**
 * Daily adaptive study plan generated from SM-2 schedules and session history.
 *
 * @param userId              owner user UUID
 * @param certificationId     target certification
 * @param dueTodayCount       number of flashcards due for review today
 * @param weakThemes          theme codes where the user is consistently underperforming
 * @param predictedScore      AI-estimated exam score based on SM-2 state (0-100)
 * @param recommendedExamDate recommended date to sit the exam
 */
public record AdaptivePlanDto(
        UUID userId,
        String certificationId,
        int dueTodayCount,
        List<String> weakThemes,
        Double predictedScore,
        LocalDate recommendedExamDate
) {
}
