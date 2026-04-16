// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/exam/ExamResultDto.java
package com.certifapp.application.dto.exam;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;

/**
 * Full exam result returned after session submission.
 *
 * @param sessionId        the completed session UUID
 * @param certificationId  certification slug
 * @param mode             EXAM | FREE | REVISION
 * @param startedAt        session start timestamp
 * @param endedAt          session end timestamp
 * @param durationSeconds  actual elapsed time in seconds
 * @param totalQuestions   total questions in session
 * @param correctCount     number of correct answers
 * @param percentage       score percentage 0-100
 * @param passed           whether the passing threshold was met
 * @param themeStats       per-theme breakdown
 * @param wrongQuestions   questions answered incorrectly (for review)
 */
public record ExamResultDto(
        UUID                    sessionId,
        String                  certificationId,
        String                  mode,
        OffsetDateTime          startedAt,
        OffsetDateTime          endedAt,
        int                     durationSeconds,
        int                     totalQuestions,
        int                     correctCount,
        double                  percentage,
        boolean                 passed,
        List<ThemeStatsDto>     themeStats,
        List<QuestionResultDto> wrongQuestions
) {}
