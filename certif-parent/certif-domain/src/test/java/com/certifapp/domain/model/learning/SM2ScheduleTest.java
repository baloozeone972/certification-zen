package com.certifapp.domain.model.learning;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDate;
import java.util.UUID;

import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class SM2ScheduleTest {

    @Mock
    private SomeDependency someDependency; // Replace with actual dependencies if any

    @InjectMocks
    private SM2Schedule sm2Schedule;

    @BeforeEach
    public void setUp() {
        // Setup any common mock behavior here if necessary
    }

    @AfterEach
    public void tearDown() {
        // Clean up resources if needed
    }

    @Test
    @DisplayName("initial_shouldCreateNewSM2Schedule")
    public void initial_shouldCreateNewSM2Schedule() {
        UUID userId = UUID.randomUUID();
        UUID questionId = UUID.randomUUID();

        SM2Schedule result = SM2Schedule.initial(userId, questionId);

        Assertions.assertThat(result).isNotNull();
        Assertions.assertThat(result.getUserId()).isEqualTo(userId);
        Assertions.assertThat(result.getQuestionId()).isEqualTo(questionId);
        Assertions.assertThat(result.getEaseFactor()).isEqualTo(SM2Schedule.DEFAULT_EASE_FACTOR);
        Assertions.assertThat(result.getIntervalDays()).isEqualTo(0);
        Assertions.assertThat(result.getRepetitions()).isEqualTo(0);
        Assertions.assertThat(result.getDueDate()).isEqualTo(LocalDate.now());
        Assertions.assertThat(result.getLastReviewedAt()).isNull();
    }

    @Test
    @DisplayName("isDueToday_shouldReturnTrueIfDueToday")
    public void isDueToday_shouldReturnTrueIfDueToday() {
        SM2Schedule schedule = SM2Schedule.initial(UUID.randomUUID(), UUID.randomUUID());

        when(someDependency.getCurrentDate()).thenReturn(LocalDate.now());
        Assertions.assertThat(schedule.isDueToday()).isTrue();
    }

    @Test
    @DisplayName("isDueToday_shouldReturnFalseIfNotDueToday")
    public void isDueToday_shouldReturnFalseIfNotDueToday() {
        SM2Schedule schedule = SM2Schedule.initial(UUID.randomUUID(), UUID.randomUUID());

        when(someDependency.getCurrentDate()).thenReturn(LocalDate.now().plusDays(1));
        Assertions.assertThat(schedule.isDueToday()).isFalse();
    }

    @Test
    @DisplayName("constructor_shouldThrowIllegalArgumentExceptionForNullUserId")
    public void constructor_shouldThrowIllegalArgumentExceptionForNullUserId() {
        Exception exception = Assertions.catchThrowable(() -> new SM2Schedule(null, UUID.randomUUID(), UUID.randomUUID(),
                SM2Schedule.DEFAULT_EASE_FACTOR, 0, 0, LocalDate.now(), null));

        Assertions.assertThat(exception).isInstanceOf(IllegalArgumentException.class)
                .hasMessage("userId must not be null");
    }

    @Test
    @DisplayName("constructor_shouldThrowIllegalArgumentExceptionForNullQuestionId")
    public void constructor_shouldThrowIllegalArgumentExceptionForNullQuestionId() {
        Exception exception = Assertions.catchThrowable(() -> new SM2Schedule(UUID.randomUUID(), null, UUID.randomUUID(),
                SM2Schedule.DEFAULT_EASE_FACTOR, 0, 0, LocalDate.now(), null));

        Assertions.assertThat(exception).isInstanceOf(IllegalArgumentException.class)
                .hasMessage("questionId must not be null");
    }

    @Test
    @DisplayName("constructor_shouldThrowIllegalArgumentExceptionForEaseFactorBelowMin")
    public void constructor_shouldThrowIllegalArgumentExceptionForEaseFactorBelowMin() {
        Exception exception = Assertions.catchThrowable(() -> new SM2Schedule(UUID.randomUUID(), UUID.randomUUID(), UUID.randomUUID(),
                1.2, 0, 0, LocalDate.now(), null));

        Assertions.assertThat(exception).isInstanceOf(IllegalArgumentException.class)
                .hasMessage("easeFactor must be >= 1.3, got: 1.2");
    }

    @Test
    @DisplayName("constructor_shouldThrowIllegalArgumentExceptionForNegativeIntervalDays")
    public void constructor_shouldThrowIllegalArgumentExceptionForNegativeIntervalDays() {
        Exception exception = Assertions.catchThrowable(() -> new SM2Schedule(UUID.randomUUID(), UUID.randomUUID(), UUID.randomUUID(),
                SM2Schedule.DEFAULT_EASE_FACTOR, -1, 0, LocalDate.now(), null));

        Assertions.assertThat(exception).isInstanceOf(IllegalArgumentException.class)
                .hasMessage("intervalDays must be >= 0");
    }

    @Test
    @DisplayName("constructor_shouldThrowIllegalArgumentExceptionForNegativeRepetitions")
    public void constructor_shouldThrowIllegalArgumentExceptionForNegativeRepetitions() {
        Exception exception = Assertions.catchThrowable(() -> new SM2Schedule(UUID.randomUUID(), UUID.randomUUID(), UUID.randomUUID(),
                SM2Schedule.DEFAULT_EASE_FACTOR, 0, -1, LocalDate.now(), null));

        Assertions.assertThat(exception).isInstanceOf(IllegalArgumentException.class)
                .hasMessage("repetitions must be >= 0");
    }
}
