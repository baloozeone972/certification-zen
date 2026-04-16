// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/certification/CertificationDetailDto.java
package com.certifapp.application.dto.certification;

import java.util.List;

/**
 * Full certification detail including themes, shown on the certification page.
 *
 * @param id                internal slug
 * @param code              official exam code
 * @param name              full display name
 * @param description       long description
 * @param totalQuestions    total corpus size
 * @param examQuestionCount questions drawn per exam session
 * @param passingScore      passing percentage threshold
 * @param examDurationMin   official exam duration
 * @param examType          MCQ | PRACTICAL | MIXED
 * @param themes            ordered list of themes
 */
public record CertificationDetailDto(
        String                  id,
        String                  code,
        String                  name,
        String                  description,
        int                     totalQuestions,
        int                     examQuestionCount,
        int                     passingScore,
        int                     examDurationMin,
        String                  examType,
        List<CertificationThemeDto> themes
) {}
