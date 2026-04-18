// certif-parent/certif-domain/src/test/java/com/certifapp/domain/port/input/learning/ReviewFlashcardUseCaseTest.java
package com.certifapp.domain.port.input.learning;

import com.certifapp.domain.model.learning.SM2Schedule;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDate;
import java.util.UUID;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

/**
 * Contract tests for {@link ReviewFlashcardUseCase} interface.
 * Uses a mock of the interface — implementation tested in ReviewFlashcardUseCaseImplTest.
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("ReviewFlashcardUseCase — interface contract")
class ReviewFlashcardUseCaseTest {

    @Mock
    private ReviewFlashcardUseCase useCase;

    private static final UUID USER_ID      = UUID.randomUUID();
    private static final UUID FLASHCARD_ID = UUID.randomUUID();

    private SM2Schedule makeSchedule(int rep, int interval) {
        return new SM2Schedule(UUID.randomUUID(), USER_ID, FLASHCARD_ID,
                2.5, rep, interval, LocalDate.now().plusDays(interval), null);
    }

    @Test
    @DisplayName("execute() with valid rating returns SM2Schedule")
    void execute_validRating_returnsSchedule() {
        SM2Schedule expected = makeSchedule(1, 1);
        when(useCase.execute(any())).thenReturn(expected);

        ReviewFlashcardUseCase.ReviewFlashcardCommand cmd =
                new ReviewFlashcardUseCase.ReviewFlashcardCommand(USER_ID, FLASHCARD_ID, 4);

        SM2Schedule result = useCase.execute(cmd);

        assertThat(result).isEqualTo(expected);
        verify(useCase, times(1)).execute(cmd);
    }

    @Test
    @DisplayName("execute() with rating 0 (blackout) returns reset schedule")
    void execute_ratingZero_returnsResetSchedule() {
        SM2Schedule reset = makeSchedule(0, 1);
        when(useCase.execute(any())).thenReturn(reset);

        ReviewFlashcardUseCase.ReviewFlashcardCommand cmd =
                new ReviewFlashcardUseCase.ReviewFlashcardCommand(USER_ID, FLASHCARD_ID, 0);

        SM2Schedule result = useCase.execute(cmd);
        assertThat(result.repetitions()).isZero();
        assertThat(result.intervalDays()).isEqualTo(1);
    }

    @Test
    @DisplayName("ReviewFlashcardCommand holds userId, flashcardId and rating")
    void command_holdsAllFields() {
        ReviewFlashcardUseCase.ReviewFlashcardCommand cmd =
                new ReviewFlashcardUseCase.ReviewFlashcardCommand(USER_ID, FLASHCARD_ID, 3);

        assertThat(cmd.userId()).isEqualTo(USER_ID);
        assertThat(cmd.flashcardId()).isEqualTo(FLASHCARD_ID);
        assertThat(cmd.rating()).isEqualTo(3);
    }

    @Test
    @DisplayName("ReviewFlashcardCommand rating must be 0-5")
    void command_ratingRange_validated() {
        // Valid boundaries
        assertThatCode(() ->
            new ReviewFlashcardUseCase.ReviewFlashcardCommand(USER_ID, FLASHCARD_ID, 0))
            .doesNotThrowAnyException();
        assertThatCode(() ->
            new ReviewFlashcardUseCase.ReviewFlashcardCommand(USER_ID, FLASHCARD_ID, 5))
            .doesNotThrowAnyException();
    }
}
