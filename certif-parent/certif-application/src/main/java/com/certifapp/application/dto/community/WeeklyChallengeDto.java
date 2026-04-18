// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/community/WeeklyChallengeDto.java
package com.certifapp.application.dto.community;

import java.time.OffsetDateTime;
import java.util.UUID;

/**
 * Weekly challenge summary for the community page.
 *
 * @param id                challenge UUID
 * @param title             challenge title
 * @param certificationId   target certification
 * @param themeCode         target theme code (null = all themes)
 * @param startsAt          challenge start timestamp
 * @param endsAt            challenge end timestamp
 * @param totalParticipants number of participants so far
 * @param questionCount     number of questions in the challenge
 */
public record WeeklyChallengeDto(
        UUID id,
        String title,
        String certificationId,
        String themeCode,
        OffsetDateTime startsAt,
        OffsetDateTime endsAt,
        int totalParticipants,
        int questionCount
) {
}
