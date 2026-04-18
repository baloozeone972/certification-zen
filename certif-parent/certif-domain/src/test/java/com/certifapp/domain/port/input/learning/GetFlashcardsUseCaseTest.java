package com.certifapp.domain.port.input.learning;

import com.certifapp.domain.exception.SubscriptionRequiredException;
import com.certifapp.domain.model.learning.Flashcard;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

public class GetFlashcardsUseCaseTest {

    @DisplayName("nominal case: retrieve flashcards due for SM-2 review")
    @Test
    public void execute_userHasSubscribed_returnsFlashcards() {
        UUID userId = UUID.randomUUID();
        String certificationId = "cert123";
        int limit = 5;
        List<Flashcard> expectedFlashcards = Arrays.asList(new Flashcard(), new Flashcard());

        // Arrange
        GetFlashcardsUseCase getFlashcardsUseCase = new GetFlashcardsUseCase(new FlashcardService() {
            @Override
            public List<Flashcard> getFlashcardsDueForReview(UUID userId, String certificationId, int limit) {
                return expectedFlashcards;
            }
        });

        // Act
        List<Flashcard> result = getFlashcardsUseCase.execute(userId, certificationId, limit);

        // Assert
        assertThat(result).isEqualTo(expectedFlashcards);
    }

    @DisplayName("edge case: limit is 0")
    @Test
    public void execute_limitIsZero_returnsAllFlashcards() {
        UUID userId = UUID.randomUUID();
        String certificationId = "cert123";
        int limit = 0;
        List<Flashcard> expectedFlashcards = Arrays.asList(new Flashcard(), new Flashcard());

        // Arrange
        GetFlashcardsUseCase getFlashcardsUseCase = new GetFlashcardsUseCase(new FlashcardService() {
            @Override
            public List<Flashcard> getFlashcardsDueForReview(UUID userId, String certificationId, int limit) {
                return expectedFlashcards;
            }
        });

        // Act
        List<Flashcard> result = getFlashcardsUseCase.execute(userId, certificationId, limit);

        // Assert
        assertThat(result).isEqualTo(expectedFlashcards);
    }

    @DisplayName("error case: user does not have subscription")
    @Test
    public void execute_userIsNotSubscribed_throwsSubscriptionRequiredException() {
        UUID userId = UUID.randomUUID();
        String certificationId = "cert123";
        int limit = 5;

        // Arrange
        GetFlashcardsUseCase getFlashcardsUseCase = new GetFlashcardsUseCase(new FlashcardService() {
            @Override
            public List<Flashcard> getFlashcardsDueForReview(UUID userId, String certificationId, int limit) {
                throw new SubscriptionRequiredException("User does not have a subscription");
            }
        });

        // Act & Assert
        assertThatThrownBy(() -> getFlashcardsUseCase.execute(userId, certificationId, limit))
                .isInstanceOf(SubscriptionRequiredException.class)
                .hasMessage("User does not have a subscription");
    }
}