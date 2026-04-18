// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/dto/request/ReviewFlashcardRequest.java
package com.certifapp.api.dto.request;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;

/**
 * HTTP request body for {@code POST /api/v1/learning/flashcards/{id}/review}.
 *
 * @param rating SM-2 quality rating 0-5
 *               (0=blackout, 3=correct+hard, 4=correct, 5=perfect)
 */
public record ReviewFlashcardRequest(@Min(0) @Max(5) int rating) {
}
