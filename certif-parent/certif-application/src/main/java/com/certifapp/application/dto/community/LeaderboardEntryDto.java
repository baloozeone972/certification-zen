// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/community/LeaderboardEntryDto.java
package com.certifapp.application.dto.community;

import java.util.UUID;

/**
 * One entry in a challenge leaderboard.
 *
 * @param rank        position (1-based)
 * @param userId      user UUID
 * @param displayName anonymised display name
 * @param score       raw score (number of correct answers)
 * @param percentage  score percentage
 * @param badgeEarned badge awarded (GOLD | SILVER | BRONZE | TOP_10_PERCENT | null)
 * @param countryCode user's country code (ISO 3166-1 alpha-2)
 */
public record LeaderboardEntryDto(
        int    rank,
        UUID   userId,
        String displayName,
        int    score,
        double percentage,
        String badgeEarned,
        String countryCode
) {}
