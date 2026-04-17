// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/certification/CertificationSummaryDto.java
package com.certifapp.application.dto.certification;

/**
 * Lightweight certification summary for the catalogue list view.
 *
 * @param id              internal slug (e.g. {@code "ocp21"})
 * @param code            official exam code (e.g. {@code "1Z0-830"})
 * @param name            full display name
 * @param totalQuestions  total corpus size
 * @param passingScore    passing percentage threshold
 * @param examDurationMin official exam duration in minutes
 * @param examType        MCQ | PRACTICAL | MIXED
 */
public record CertificationSummaryDto(
        String id,
        String code,
        String name,
        int totalQuestions,
        int passingScore,
        int examDurationMin,
        String examType
) {
}
