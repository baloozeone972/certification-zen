// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/dto/request/SubmitAnswerRequest.java
package com.certifapp.api.dto.request;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;

import java.util.UUID;

/**
 * HTTP request body for {@code POST /api/v1/exams/sessions/{id}/answers}.
 *
 * @param questionId       the answered question UUID
 * @param selectedOptionId the chosen option UUID — null means skip
 * @param responseTimeMs   time taken in milliseconds
 */
public record SubmitAnswerRequest(
        @NotNull UUID questionId,
        UUID selectedOptionId,
        @PositiveOrZero long responseTimeMs
) {
}
