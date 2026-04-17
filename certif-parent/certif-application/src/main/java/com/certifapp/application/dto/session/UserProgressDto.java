// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/session/UserProgressDto.java
package com.certifapp.application.dto.session;

import java.util.Map;
import java.util.UUID;

/**
 * Aggregated user progress statistics for a certification.
 *
 * @param userId          the user
 * @param certificationId the certification
 * @param totalSessions   total exam sessions completed
 * @param bestScore       best percentage achieved
 * @param averageScore    average percentage across all sessions
 * @param passRate        percentage of sessions where the user passed
 * @param progressByTheme map of theme code → average percentage
 */
public record UserProgressDto(
        UUID userId,
        String certificationId,
        int totalSessions,
        double bestScore,
        double averageScore,
        double passRate,
        Map<String, Double> progressByTheme
) {
}
