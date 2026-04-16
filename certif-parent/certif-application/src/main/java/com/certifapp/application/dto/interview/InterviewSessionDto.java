// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/interview/InterviewSessionDto.java
package com.certifapp.application.dto.interview;

import java.time.OffsetDateTime;
import java.util.Map;
import java.util.UUID;

/**
 * Interview simulation session.
 *
 * @param id               session UUID
 * @param certificationId  target certification
 * @param mode             TEXT | VOICE | MIXED
 * @param startedAt        session start timestamp
 * @param overallFeedback  AI summary feedback (null while in progress)
 * @param scoreByDomain    domain → average score 0-10 (null while in progress)
 */
public record InterviewSessionDto(
        UUID               id,
        String             certificationId,
        String             mode,
        OffsetDateTime     startedAt,
        String             overallFeedback,
        Map<String, Double> scoreByDomain
) {}
