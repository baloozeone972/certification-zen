// certif-parent/certif-application/src/test/java/com/certifapp/application/usecase/learning/ReviewFlashcardUseCaseImplTest.java
package com.certifapp.application.usecase.learning;

import com.certifapp.domain.model.learning.SM2Schedule;
import com.certifapp.domain.port.input.learning.ReviewFlashcardUseCase;
import com.certifapp.domain.port.output.SM2ScheduleRepository;
import com.certifapp.domain.service.SM2AlgorithmService;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDate;
import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

/**
 * Unit tests for {@link ReviewFlashcardUseCaseImpl}.
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("ReviewFlashcardUseCaseImpl")
class ReviewFlashcardUseCaseImplTest {

    @Mock private SM2ScheduleRepository sm2Repository;

    private SM2AlgorithmService   sm2Service;
    private ReviewFlashcardUseCaseImpl useCase;

    private static final UUID USER_ID     = UUID.randomUUID();
    private static final UUID FLASHCARD_ID = UUID.randomUUID();

    @BeforeEach
    void setUp() {
        sm2Service = new SM2AlgorithmService();
        useCase    = new ReviewFlashcardUseCaseImpl(sm2Repository, sm2Service);
    }

    @Test
    @DisplayName("First review of a card — creates initial schedule then applies review")
    void firstReview_shouldCreateInitialSchedule() {
        when(sm2Repository.findByUserAndQuestion(USER_ID, FLASHCARD_ID))
                .thenReturn(Optional.empty());
        when(sm2Repository.save(any(SM2Schedule.class))).thenAnswer(inv -> inv.getArgument(0));

        ReviewFlashcardUseCase.ReviewFlashcardCommand cmd =
                new ReviewFlashcardUseCase.ReviewFlashcardCommand(USER_ID, FLASHCARD_ID, 4);

        SM2Schedule result = useCase.execute(cmd);

        assertThat(result.repetitions()).isEqualTo(1);
        assertThat(result.intervalDays()).isEqualTo(1);
        assertThat(result.dueDate()).isEqualTo(LocalDate.now().plusDays(1));
        verify(sm2Repository).save(any(SM2Schedule.class));
    }

    @Test
    @DisplayName("Subsequent review — updates existing schedule")
    void subsequentReview_shouldUpdateExistingSchedule() {
        SM2Schedule existing = new SM2Schedule(UUID.randomUUID(), USER_ID, FLASHCARD_ID,
                2.5, 1, 1, LocalDate.now(), null);
        when(sm2Repository.findByUserAndQuestion(USER_ID, FLASHCARD_ID))
                .thenReturn(Optional.of(existing));
        when(sm2Repository.save(any(SM2Schedule.class))).thenAnswer(inv -> inv.getArgument(0));

        ReviewFlashcardUseCase.ReviewFlashcardCommand cmd =
                new ReviewFlashcardUseCase.ReviewFlashcardCommand(USER_ID, FLASHCARD_ID, 4);

        SM2Schedule result = useCase.execute(cmd);

        assertThat(result.repetitions()).isEqualTo(2); // was 1, now 2
        assertThat(result.intervalDays()).isEqualTo(6); // 2nd correct = 6 days
    }

    @Test
    @DisplayName("Invalid rating (6) — throws IllegalArgumentException")
    void invalidRating_shouldThrow() {
        assertThatThrownBy(() ->
                new ReviewFlashcardUseCase.ReviewFlashcardCommand(USER_ID, FLASHCARD_ID, 6))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessageContaining("SM-2 rating must be 0-5");
    }
}
