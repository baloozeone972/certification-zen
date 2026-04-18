package com.certifapp.domain.port.output;

import com.certifapp.domain.model.learning.SM2Schedule;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

public class SM2ScheduleRepositoryTest {

    private UUID userId;
    private UUID questionId;
    private SM2Schedule schedule;

    @BeforeEach
    public void setUp() {
        userId = UUID.randomUUID();
        questionId = UUID.randomUUID();
        schedule = new SM2Schedule(userId, questionId);
    }

    @Test
    @DisplayName("Should return optional empty when no schedule found by user and question")
    public void findByUserAndQuestion_noScheduleFound_OptionalEmpty() {
        // Arrange
        when(repository.findByUserAndQuestion(userId, questionId)).thenReturn(Optional.empty());

        // Act
        Optional<SM2Schedule> result = repository.findByUserAndQuestion(userId, questionId);

        // Assert
        assertThat(result).isEmpty();
        verify(repository).findByUserAndQuestion(userId, questionId);
    }

    @Test
    @DisplayName("Should return optional with schedule when schedule found by user and question")
    public void findByUserAndQuestion_scheduleFound_OptionalWithSchedule() {
        // Arrange
        when(repository.findByUserAndQuestion(userId, questionId)).thenReturn(Optional.of(schedule));

        // Act
        Optional<SM2Schedule> result = repository.findByUserAndQuestion(userId, questionId);

        // Assert
        assertThat(result).isPresent().contains(schedule);
        verify(repository).findByUserAndQuestion(userId, questionId);
    }

    @Test
    @DisplayName("Should save schedule and return it")
    public void save_scheduleSaved_ReturnSavedSchedule() {
        // Arrange
        when(repository.save(any(SM2Schedule.class))).thenReturn(schedule);

        // Act
        SM2Schedule savedSchedule = repository.save(schedule);

        // Assert
        assertThat(savedSchedule).isEqualTo(schedule);
        verify(repository).save(schedule);
    }

    @Test
    @DisplayName("Should throw NullPointerException when saving null schedule")
    public void save_nullSchedule_ThrowNullPointerException() {
        // Arrange
        NullPointerException exception = assertThrows(NullPointerException.class, () -> {
            repository.save(null);
        });

        // Assert
        assertThat(exception.getMessage()).contains("schedule");
        verify(repository, never()).save(any(SM2Schedule.class));
    }
}