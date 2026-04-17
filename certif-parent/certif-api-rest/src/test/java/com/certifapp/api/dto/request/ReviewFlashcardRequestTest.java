package com.certifapp.api.dto.request;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class ReviewFlashcardRequestTest {

    @InjectMocks
    private ReviewFlashcardRequest underTest;

    @BeforeEach
    public void setUp() {
        // Initialization if needed
    }

    @DisplayName("should create a valid ReviewFlashcardRequest with rating 3")
    @Test
    public void createReviewFlashcardRequest_withRating3_shouldBeValid() {
        int rating = 3;
        underTest = new ReviewFlashcardRequest(rating);
        Assertions.assertThat(underTest.rating()).isEqualTo(rating);
    }

    @DisplayName("should create a valid ReviewFlashcardRequest with rating 5")
    @Test
    public void createReviewFlashcardRequest_withRating5_shouldBeValid() {
        int rating = 5;
        underTest = new ReviewFlashcardRequest(rating);
        Assertions.assertThat(underTest.rating()).isEqualTo(rating);
    }

    @DisplayName("should throw IllegalArgumentException when rating is less than 0")
    @Test
    public void createReviewFlashcardRequest_withRatingLessThan0_shouldThrowException() {
        int rating = -1;
        Assertions.assertThatThrownBy(() -> new ReviewFlashcardRequest(rating))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("rating must be between 0 and 5");
    }

    @DisplayName("should throw IllegalArgumentException when rating is greater than 5")
    @Test
    public void createReviewFlashcardRequest_withRatingGreaterThan5_shouldThrowException() {
        int rating = 6;
        Assertions.assertThatThrownBy(() -> new ReviewFlashcardRequest(rating))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("rating must be between 0 and 5");
    }
}

