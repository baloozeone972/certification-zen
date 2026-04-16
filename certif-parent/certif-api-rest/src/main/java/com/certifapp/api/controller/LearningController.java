// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/controller/LearningController.java
package com.certifapp.api.controller;

import com.certifapp.api.dto.request.ReviewFlashcardRequest;
import com.certifapp.api.dto.response.ApiResponse;
import com.certifapp.api.security.CurrentUser;
import com.certifapp.domain.model.learning.*;
import com.certifapp.domain.port.input.learning.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

/**
 * REST controller for learning features: flashcards and SM-2 review.
 */
@RestController
@RequestMapping("/api/v1/learning")
@Tag(name = "Learning", description = "Flashcards and spaced repetition")
@SecurityRequirement(name = "BearerAuth")
public class LearningController {

    private final GetFlashcardsUseCase    getFlashcardsUseCase;
    private final ReviewFlashcardUseCase  reviewUseCase;

    public LearningController(
            GetFlashcardsUseCase   getFlashcardsUseCase,
            ReviewFlashcardUseCase reviewUseCase) {
        this.getFlashcardsUseCase = getFlashcardsUseCase;
        this.reviewUseCase        = reviewUseCase;
    }

    /**
     * Get flashcards due for SM-2 review today (PRO only).
     *
     * @param certificationId target certification
     * @param limit           max cards to return (default 20)
     * @return 200 OK with due flashcards
     */
    @GetMapping("/flashcards/{certificationId}")
    @Operation(summary = "Get flashcards due for review today (PRO only)")
    public ResponseEntity<ApiResponse<List<Flashcard>>> getDueFlashcards(
            @PathVariable String certificationId,
            @RequestParam(defaultValue = "20") int limit) {

        UUID userId = CurrentUser.id();
        return ResponseEntity.ok(ApiResponse.ok(
                getFlashcardsUseCase.execute(userId, certificationId, limit)));
    }

    /**
     * Record the result of a flashcard review and update the SM-2 schedule.
     *
     * @param id      flashcard UUID
     * @param request SM-2 quality rating 0-5
     * @return 200 OK with updated SM-2 schedule
     */
    @PostMapping("/flashcards/{id}/review")
    @Operation(summary = "Record flashcard review result (SM-2)")
    public ResponseEntity<ApiResponse<SM2Schedule>> reviewFlashcard(
            @PathVariable UUID id,
            @Valid @RequestBody ReviewFlashcardRequest request) {

        UUID userId = CurrentUser.id();
        var command = new ReviewFlashcardUseCase.ReviewFlashcardCommand(userId, id, request.rating());
        return ResponseEntity.ok(ApiResponse.ok(reviewUseCase.execute(command)));
    }
}
