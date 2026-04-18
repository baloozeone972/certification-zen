package com.certifapp.domain.port.input.learning;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import com.certifapp.domain.exception.SubscriptionRequiredException;
import com.certifapp.domain.model.learning.Flashcard;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class GetFlashcardsUseCaseTest {

    @Mock
    private FlashcardService flashcardService;

    @InjectMocks
    private GetFlashcardsUseCase getFlashcardsUseCase;

    @BeforeEach
    public void setUp() {
        // Setup mock behavior if necessary
    }

    @DisplayName("nominal case: retrieve flashcards due for SM-2 review")
    @Test
    public void execute_userHasSubscribed_returnsFlashcards() {
        UUID userId = UUID.randomUUID();
        String certificationId = "cert123";
        int limit = 5;
        List<Flashcard> expectedFlashcards = Arrays.asList(new Flashcard(), new Flashcard());

        when(flashcardService.getFlashcardsDueForReview(userId, certificationId, limit)).thenReturn(expectedFlashcards);

        List<Flashcard> result = getFlashcardsUseCase.execute(userId, certificationId, limit);

        assertThat(result).isEqualTo(expectedFlashcards);
        verify(flashcardService, times(1)).getFlashcardsDueForReview(userId, certificationId, limit);
    }

    @DisplayName("edge case: limit is 0")
    @Test
    public void execute_limitIsZero_returnsAllFlashcards() {
        UUID userId = UUID.randomUUID();
        String certificationId = "cert123";
        int limit = 0;
        List<Flashcard> expectedFlashcards = Arrays.asList(new Flashcard(), new Flashcard());

        when(flashcardService.getFlashcardsDueForReview(userId, certificationId, anyInt())).thenReturn(expectedFlashcards);

        List<Flashcard> result = getFlashcardsUseCase.execute(userId, certificationId, limit);

        assertThat(result).isEqualTo(expectedFlashcards);
        verify(flashcardService, times(1)).getFlashcardsDueForReview(userId, certificationId, anyInt());
    }

    @DisplayName("error case: user does not have subscription")
    @Test
    public void execute_userIsNotSubscribed_throwsSubscriptionRequiredException() {
        UUID userId = UUID.randomUUID();
        String certificationId = "cert123";
        int limit = 5;

        when(flashcardService.getFlashcardsDueForReview(userId, certificationId, limit)).thenThrow(new SubscriptionRequiredException("User does not have a subscription"));

        assertThatThrownBy(() -> getFlashcardsUseCase.execute(userId, certificationId, limit))
                .isInstanceOf(SubscriptionRequiredException.class)
                .hasMessage("User does not have a subscription");

        verify(flashcardService, times(1)).getFlashcardsDueForReview(userId, certificationId, limit);
    }
}
