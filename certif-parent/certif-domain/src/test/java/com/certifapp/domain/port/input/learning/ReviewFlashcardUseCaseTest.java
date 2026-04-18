package com.certifapp.domain.port.input.learning;

import com.certifapp.domain.model.learning.SM2Schedule;
import org.junit.jupiter.api.*;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@DisplayName("ReviewFlashcardUseCase tests")
@ExtendWith(MockitoExtension.class)
public class ReviewFlashcardUseCaseTest {

    @Mock
    private SM2ScheduleService sm2ScheduleService;

    @InjectMocks
    private ReviewFlashcardUseCase reviewFlashcardUseCase;

    @BeforeEach
    public void setUp() {
        // Setup code if needed
    }

    @AfterEach
    public void tearDown() {
        // Teardown code if needed
    }

    @Test
    @DisplayName("record valid SM-2 rating")
    public void execute_validRating_sm2ScheduleUpdated() {
        UUID userId = UUID.randomUUID();
        UUID flashcardId = UUID.randomUUID();
        int rating = 3;
        SM2Schedule expectedSchedule = new SM2Schedule();

        when(sm2ScheduleService.update(any(SM2Schedule.class))).thenReturn(expectedSchedule);

        SM2Schedule result = reviewFlashcardUseCase.execute(new ReviewFlashcardCommand(userId, flashcardId, rating));

        assertThat(result).isEqualTo(expectedSchedule);
        verify(sm2ScheduleService, times(1)).update(any(SM2Schedule.class));
    }

    @Test
    @DisplayName("record invalid SM-2 rating")
    public void execute_invalidRating_exceptionThrown() {
        UUID userId = UUID.randomUUID();
        UUID flashcardId = UUID.randomUUID();
        int rating = 6;

        assertThrows(IllegalArgumentException.class, () -> 
            reviewFlashcardUseCase.execute(new ReviewFlashcardCommand(userId, flashcardId, rating))
        );
    }

    @Test
    @DisplayName("record SM-2 rating of zero")
    public void execute_ratingZero_sm2ScheduleUpdated() {
        UUID userId = UUID.randomUUID();
        UUID flashcardId = UUID.randomUUID();
        int rating = 0;
        SM2Schedule expectedSchedule = new SM2Schedule();

        when(sm2ScheduleService.update(any(SM2Schedule.class))).thenReturn(expectedSchedule);

        SM2Schedule result = reviewFlashcardUseCase.execute(new ReviewFlashcardCommand(userId, flashcardId, rating));

        assertThat(result).isEqualTo(expectedSchedule);
        verify(sm2ScheduleService, times(1)).update(any(SM2Schedule.class));
    }

    @Test
    @DisplayName("record SM-2 rating of one")
    public void execute_ratingOne_sm2ScheduleUpdated() {
        UUID userId = UUID.randomUUID();
        UUID flashcardId = UUID.randomUUID();
        int rating = 1;
        SM2Schedule expectedSchedule = new SM2Schedule();

        when(sm2ScheduleService.update(any(SM2Schedule.class))).thenReturn(expectedSchedule);

        SM2Schedule result = reviewFlashcardUseCase.execute(new ReviewFlashcardCommand(userId, flashcardId, rating));

        assertThat(result).isEqualTo(expectedSchedule);
        verify(sm2ScheduleService, times(1)).update(any(SM2Schedule.class));
    }

    @Test
    @DisplayName("record SM-2 rating of two")
    public void execute_ratingTwo_sm2ScheduleUpdated() {
        UUID userId = UUID.randomUUID();
        UUID flashcardId = UUID.randomUUID();
        int rating = 2;
        SM2Schedule expectedSchedule = new SM2Schedule();

        when(sm2ScheduleService.update(any(SM2Schedule.class))).thenReturn(expectedSchedule);

        SM2Schedule result = reviewFlashcardUseCase.execute(new ReviewFlashcardCommand(userId, flashcardId, rating));

        assertThat(result).isEqualTo(expectedSchedule);
        verify(sm2ScheduleService, times(1)).update(any(SM2Schedule.class));
    }

    @Test
    @DisplayName("record SM-2 rating of four")
    public void execute_ratingFour_sm2ScheduleUpdated() {
        UUID userId = UUID.randomUUID();
        UUID flashcardId = UUID.randomUUID();
        int rating = 4;
        SM2Schedule expectedSchedule = new SM2Schedule();

        when(sm2ScheduleService.update(any(SM2Schedule.class))).thenReturn(expectedSchedule);

        SM2Schedule result = reviewFlashcardUseCase.execute(new ReviewFlashcardCommand(userId, flashcardId, rating));

        assertThat(result).isEqualTo(expectedSchedule);
        verify(sm2ScheduleService, times(1)).update(any(SM2Schedule.class));
    }

    @Test
    @DisplayName("record SM-2 rating of five")
    public void execute_ratingFive_sm2ScheduleUpdated() {
        UUID userId = UUID.randomUUID();
        UUID flashcardId = UUID.randomUUID();
        int rating = 5;
        SM2Schedule expectedSchedule = new SM2Schedule();

        when(sm2ScheduleService.update(any(SM2Schedule.class))).thenReturn(expectedSchedule);

        SM2Schedule result = reviewFlashcardUseCase.execute(new ReviewFlashcardCommand(userId, flashcardId, rating));

        assertThat(result).isEqualTo(expectedSchedule);
        verify(sm2ScheduleService, times(1)).update(any(SM2Schedule.class));
    }
}
```

Note: The `SM2ScheduleService` class and its `update` method are assumed to be properly implemented in the production codebase. If not, you would need to mock or implement them for the tests to run.
