// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/certification/CertificationThemeDto.java
package com.certifapp.application.dto.certification;

import java.util.UUID;

/**
 * Theme details within a certification.
 *
 * @param id            theme UUID
 * @param code          URL-safe slug (e.g. {@code "virtual_threads"})
 * @param label         display name (e.g. {@code "Virtual Threads"})
 * @param questionCount number of questions in this theme
 * @param weightPercent official weight percentage — null if not published
 */
public record CertificationThemeDto(
        UUID   id,
        String code,
        String label,
        int    questionCount,
        Double weightPercent
) {}
