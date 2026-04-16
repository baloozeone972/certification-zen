// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/coaching/WeeklyCoachReportDto.java
package com.certifapp.application.dto.coaching;

import java.time.LocalDate;
import java.util.Map;
import java.util.UUID;

/**
 * Weekly AI coach report generated every Monday.
 *
 * @param reportId       report UUID
 * @param userId         recipient user UUID
 * @param weekStart      Monday date of the covered week
 * @param reportContent  AI-generated narrative (Markdown)
 * @param studyPlan      daily study plan: day-of-week → list of theme codes
 */
public record WeeklyCoachReportDto(
        UUID                    reportId,
        UUID                    userId,
        LocalDate               weekStart,
        String                  reportContent,
        Map<String, Object>     studyPlan
) {}
