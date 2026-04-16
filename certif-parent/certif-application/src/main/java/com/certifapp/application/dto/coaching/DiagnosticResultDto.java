// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/coaching/DiagnosticResultDto.java
package com.certifapp.application.dto.coaching;

import java.util.List;
import java.util.Map;

/**
 * Result of the initial competency diagnostic assessment.
 *
 * @param scoreByDomain             domain code → score percentage
 * @param skillMap                  skill name → confidence level 0.0-1.0
 * @param recommendedCertifications ordered list of recommended certifications
 */
public record DiagnosticResultDto(
        Map<String, Integer>             scoreByDomain,
        Map<String, Double>              skillMap,
        List<RecommendedCertificationDto> recommendedCertifications
) {
    /**
     * One recommended certification from the diagnostic.
     *
     * @param certificationId  certification slug
     * @param rationale        AI explanation for why this is recommended
     * @param priority         1 = highest priority
     */
    public record RecommendedCertificationDto(
            String certificationId,
            String rationale,
            int    priority
    ) {}
}
