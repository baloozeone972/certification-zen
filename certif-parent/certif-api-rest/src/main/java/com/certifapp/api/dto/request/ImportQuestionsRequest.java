// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/dto/request/ImportQuestionsRequest.java
package com.certifapp.api.dto.request;

import jakarta.validation.constraints.*;
import java.util.List;

/**
 * HTTP request body for {@code POST /api/v1/admin/questions/import}.
 *
 * @param certificationId  target certification
 * @param questions        list of questions to import (1-500)
 */
public record ImportQuestionsRequest(
        @NotBlank String certificationId,
        @NotNull @Size(min = 1, max = 500) List<QuestionImportItem> questions
) {
    /**
     * One question item in the import payload — mirrors the JSON corpus format.
     *
     * @param legacyId      original JSON id (e.g. "JAVA-001") — for deduplication
     * @param themeLabel    theme display name (used to resolve themeId)
     * @param statement     question text
     * @param difficulty    easy | medium | hard
     * @param options       2-5 answer texts
     * @param correctIndex  0-based index of the correct option
     * @param explanation   explanation text
     */
    public record QuestionImportItem(
            String legacyId,
            @NotBlank String themeLabel,
            @NotBlank String statement,
            @Pattern(regexp = "easy|medium|hard") String difficulty,
            @NotNull @Size(min = 2, max = 5) List<String> options,
            @Min(0) @Max(4) int correctIndex,
            String explanation
    ) {}
}
