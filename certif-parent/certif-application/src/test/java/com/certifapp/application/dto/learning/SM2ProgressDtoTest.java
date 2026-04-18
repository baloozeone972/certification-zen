package com.certifapp.application.dto.learning;

import java.util.UUID;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

public class SM2ProgressDtoTest {

    @InjectMocks
    private SM2ProgressDto sm2ProgressDto;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @DisplayName("nominal case: creating an instance of SM2ProgressDto")
    @Test
    public void createInstance_withValidParameters_successfullyCreated() {
        UUID flashcardId = UUID.randomUUID();
        LocalDate nextReviewDate = LocalDate.now().plusDays(10);
        int intervalDays = 5;
        double easeFactor = 2.5;
        int repetitions = 3;

        sm2ProgressDto = new SM2ProgressDto(flashcardId, nextReviewDate, intervalDays, easeFactor, repetitions);

        assertThat(sm2ProgressDto.flashcardId()).isEqualTo(flashcardId);
        assertThat(sm2ProgressDto.nextReviewDate()).isEqualTo(nextReviewDate);
        assertThat(sm2ProgressDto.intervalDays()).isEqualTo(intervalDays);
        assertThat(sm2ProgressDto.easeFactor()).isEqualTo(easeFactor);
        assertThat(sm2ProgressDto.repetitions()).isEqualTo(repetitions);
    }

    @DisplayName("edge case: creating an instance with null flashcardId")
    @Test
    public void createInstance_withNullFlashcardId_throwNullPointerException() {
        UUID flashcardId = null;
        LocalDate nextReviewDate = LocalDate.now().plusDays(10);
        int intervalDays = 5;
        double easeFactor = 2.5;
        int repetitions = 3;

        assertThatExceptionOfType(NullPointerException.class)
                .isThrownBy(() -> new SM2ProgressDto(flashcardId, nextReviewDate, intervalDays, easeFactor, repetitions));
    }

    @DisplayName("edge case: creating an instance with negative intervalDays")
    @Test
    public void createInstance_withNegativeIntervalDays_throwIllegalArgumentException() {
        UUID flashcardId = UUID.randomUUID();
        LocalDate nextReviewDate = LocalDate.now().plusDays(10);
        int intervalDays = -5;
        double easeFactor = 2.5;
        int repetitions = 3;

        assertThatExceptionOfType(IllegalArgumentException.class)
                .isThrownBy(() -> new SM2ProgressDto(flashcardId, nextReviewDate, intervalDays, easeFactor, repetitions));
    }

    @DisplayName("edge case: creating an instance with negative repetitions")
    @Test
    public void createInstance_withNegativeRepetitions_throwIllegalArgumentException() {
        UUID flashcardId = UUID.randomUUID();
        LocalDate nextReviewDate = LocalDate.now().plusDays(10);
        int intervalDays = 5;
        double easeFactor = 2.5;
        int repetitions = -3;

        assertThatExceptionOfType(IllegalArgumentException.class)
                .isThrownBy(() -> new SM2ProgressDto(flashcardId, nextReviewDate, intervalDays, easeFactor, repetitions));
    }

    @DisplayName("edge case: creating an instance with negative easeFactor")
    @Test
    public void createInstance_withNegativeEaseFactor_throwIllegalArgumentException() {
        UUID flashcardId = UUID.randomUUID();
        LocalDate nextReviewDate = LocalDate.now().plusDays(10);
        int intervalDays = 5;
        double easeFactor = -2.5;
        int repetitions = 3;

        assertThatExceptionOfType(IllegalArgumentException.class)
                .isThrownBy(() -> new SM2ProgressDto(flashcardId, nextReviewDate, intervalDays, easeFactor, repetitions));
    }
}
