// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/dto/request/StartExamRequest.java
package com.certifapp.api.dto.request;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

import java.util.List;

/**
 * HTTP request body for {@code POST /api/v1/exams/sessions}.
 *
 * @param certificationId target certification slug
 * @param mode            EXAM | FREE | REVISION
 * @param selectedThemes  theme codes (FREE mode only — empty = all themes)
 * @param questionCount   number of questions (0 = use certification default)
 * @param durationMinutes custom timer in minutes (0 = unlimited, FREE mode only)
 */
public record StartExamRequest(
        @NotBlank String certificationId,
        @NotBlank @Pattern(regexp = "EXAM|FREE|REVISION") String mode,
        List<String> selectedThemes,
        @Min(0) @Max(200) int questionCount,
        @Min(0) int durationMinutes
) {
}
