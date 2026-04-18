package com.certifapp.api.controller;

import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;
import static org.assertj.core.api.Assertions.*;

import java.util.List;
import java.util.UUID;

import com.certifapp.api.dto.request.ReviewFlashcardRequest;
import com.certifapp.api.dto.response.ApiResponse;
import com.certifapp.domain.model.learning.Flashcard;
import com.certifapp.domain.model.learning.SM2Schedule;
import com.certifapp.domain.port.input.learning.GetFlashcardsUseCase;
import com.certifapp.domain.port.input.learning.ReviewFlashcardUseCase;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import org.springframework.http.ResponseEntity;

@ExtendWith(MockitoExtension.class)
public class LearningControllerTest {

    @Mock
    private GetFlashcardsUseCase getFlashcardsUseCase;

    @Mock
    private ReviewFlashcardUseCase reviewUseCase;

    @InjectMocks
    private LearningController learningController;

    @BeforeEach
    public void setUp() {
        when(CurrentUser.id()).thenReturn(UUID.randomUUID());
    }

    @Test
    @DisplayName("Should return 200 OK with due flashcards")
    public void getDueFlashcards_nominalCase() {
        String certificationId = "123";
        int limit = 20;
        UUID userId = CurrentUser.id();
        List<Flashcard> flashcards = List.of(new Flashcard());
        when(getFlashcardsUseCase.execute(userId, certificationId, limit)).thenReturn(flashcards);

        ResponseEntity<ApiResponse<List<Flashcard>>> response = learningController.getDueFlashcards(certificationId, limit);

        assertThat(response).isEqualTo(ResponseEntity.ok(ApiResponse.ok(flashcards)));
        verify(getFlashcardsUseCase).execute(userId, certificationId, limit);
    }

    @Test
    @DisplayName("Should return 200 OK with updated SM-2 schedule")
    public void reviewFlashcard_nominalCase() {
        UUID id = UUID.randomUUID();
        int rating = 5;
        ReviewFlashcardRequest request = new ReviewFlashcardRequest(rating);
        UUID userId = CurrentUser.id();
        var command = new ReviewFlashcardUseCase.ReviewFlashcardCommand(userId, id, rating);
        SM2Schedule schedule = new SM2Schedule();
        when(reviewUseCase.execute(command)).thenReturn(schedule);

        ResponseEntity<ApiResponse<SM2Schedule>> response = learningController.reviewFlashcard(id, request);

        assertThat(response).isEqualTo(ResponseEntity.ok(ApiResponse.ok(schedule)));
        verify(reviewUseCase).execute(command);
    }

    @Test
    @DisplayName("Should handle null certificationId")
    public void getDueFlashcards_nullCertificationId() {
        String certificationId = null;
        int limit = 20;
        UUID userId = CurrentUser.id();
        List<Flashcard> flashcards = List.of(new Flashcard());
        when(getFlashcardsUseCase.execute(userId, certificationId, limit)).thenReturn(flashcards);

        ResponseEntity<ApiResponse<List<Flashcard>>> response = learningController.getDueFlashcards(certificationId, limit);

        assertThat(response).isEqualTo(ResponseEntity.ok(ApiResponse.ok(flashcards)));
        verify(getFlashcardsUseCase).execute(userId, certificationId, limit);
    }

    @Test
    @DisplayName("Should handle zero limit")
    public void getDueFlashcards_zeroLimit() {
        String certificationId = "123";
        int limit = 0;
        UUID userId = CurrentUser.id();
        List<Flashcard> flashcards = List.of(new Flashcard());
        when(getFlashcardsUseCase.execute(userId, certificationId, limit)).thenReturn(flashcards);

        ResponseEntity<ApiResponse<List<Flashcard>>> response = learningController.getDueFlashcards(certificationId, limit);

        assertThat(response).isEqualTo(ResponseEntity.ok(ApiResponse.ok(flashcards)));
        verify(getFlashcardsUseCase).execute(userId, certificationId, limit);
    }

    @Test
    @DisplayName("Should handle negative rating")
    public void reviewFlashcard_negativeRating() {
        UUID id = UUID.randomUUID();
        int rating = -1;
        ReviewFlashcardRequest request = new ReviewFlashcardRequest(rating);
        UUID userId = CurrentUser.id();
        var command = new ReviewFlashcardUseCase.ReviewFlashcardCommand(userId, id, rating);
        SM2Schedule schedule = new SM2Schedule();
        when(reviewUseCase.execute(command)).thenReturn(schedule);

        ResponseEntity<ApiResponse<SM2Schedule>> response = learningController.reviewFlashcard(id, request);

        assertThat(response).isEqualTo(ResponseEntity.ok(ApiResponse.ok(schedule)));
        verify(reviewUseCase).execute(command);
    }

    @Test
    @DisplayName("Should handle rating greater than 5")
    public void reviewFlashcard_ratingGreaterThanFive() {
        UUID id = UUID.randomUUID();
        int rating = 6;
        ReviewFlashcardRequest request = new ReviewFlashcardRequest(rating);
        UUID userId = CurrentUser.id();
        var command = new ReviewFlashcardUseCase.ReviewFlashcardCommand(userId, id, rating);
        SM2Schedule schedule = new SM2Schedule();
        when(reviewUseCase.execute(command)).thenReturn(schedule);

        ResponseEntity<ApiResponse<SM2Schedule>> response = learningController.reviewFlashcard(id, request);

        assertThat(response).isEqualTo(ResponseEntity.ok(ApiResponse.ok(schedule)));
        verify(reviewUseCase).execute(command);
    }
}
