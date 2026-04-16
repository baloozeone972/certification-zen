```java
package com.certifapp.domain.port.output;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

import java.util.Optional;
import java.util.UUID;

import com.certifapp.domain.model.learning.SM2Schedule;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class SM2ScheduleRepositoryTest {

    @Mock
    private SM2ScheduleRepository repository;

    @InjectMocks
    private SM2ScheduleRepositoryImpl sm2ScheduleRepositoryImpl;

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
        when(repository.findByUserAndQuestion(userId, questionId)).thenReturn(Optional.empty());

        Optional<SM2Schedule> result = repository.findByUserAndQuestion(userId, questionId);

        assertThat(result).isEmpty();
        verify(repository).findByUserAndQuestion(userId, questionId);
    }

    @Test
    @DisplayName("Should return optional with schedule when schedule found by user and question")
    public void findByUserAndQuestion_scheduleFound_OptionalWithSchedule() {
        when(repository.findByUserAndQuestion(userId, questionId)).thenReturn(Optional.of(schedule));

        Optional<SM2Schedule> result = repository.findByUserAndQuestion(userId, questionId);

        assertThat(result).isPresent().contains(schedule);
        verify(repository).findByUserAndQuestion(userId, questionId);
    }

    @Test
    @DisplayName("Should save schedule and return it")
    public void save_scheduleSaved_ReturnSavedSchedule() {
        when(repository.save(any(SM2Schedule.class))).thenReturn(schedule);

        SM2Schedule savedSchedule = repository.save(schedule);

        assertThat(savedSchedule).isEqualTo(schedule);
        verify(repository).save(schedule);
    }

    @Test
    @DisplayName("Should throw NullPointerException when saving null schedule")
    public void save_nullSchedule_ThrowNullPointerException() {
        NullPointerException exception = assertThrows(NullPointerException.class, () -> {
            repository.save(null);
        });

        assertThat(exception.getMessage()).contains("schedule");
        verify(repository, never()).save(any(SM2Schedule.class));
    }
}
```
