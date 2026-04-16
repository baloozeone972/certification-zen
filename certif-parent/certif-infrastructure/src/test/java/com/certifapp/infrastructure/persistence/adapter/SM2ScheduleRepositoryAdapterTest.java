```java
package com.certifapp.infrastructure.persistence.adapter;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

import java.util.Optional;
import java.util.UUID;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class SM2ScheduleRepositoryAdapterTest {

    @Mock
    private SM2ScheduleJpaRepository jpaRepository;

    @InjectMocks
    private SM2ScheduleRepositoryAdapter adapter;

    private UUID userId = UUID.randomUUID();
    private UUID questionId = UUID.randomUUID();

    @BeforeEach
    public void setUp() {
        // Setup code if needed
    }

    @AfterEach
    public void tearDown() {
        verifyNoMoreInteractions(jpaRepository);
    }

    @Test
    @DisplayName("Should return Optional.empty when schedule not found")
    public void findByUserAndQuestion_NotFound_ReturnsEmptyOptional() {
        when(jpaRepository.findByUserIdAndQuestionId(userId, questionId)).thenReturn(Optional.empty());

        Optional<SM2Schedule> result = adapter.findByUserAndQuestion(userId, questionId);

        assertThat(result).isEmpty();
    }

    @Test
    @DisplayName("Should return SM2Schedule when found")
    public void findByUserAndQuestion_Found_ReturnsSM2Schedule() {
        SM2ScheduleEntity entity = new SM2ScheduleEntity();
        entity.setId(UUID.randomUUID());
        entity.setUserId(userId);
        entity.setQuestionId(questionId);

        when(jpaRepository.findByUserIdAndQuestionId(userId, questionId)).thenReturn(Optional.of(entity));

        Optional<SM2Schedule> result = adapter.findByUserAndQuestion(userId, questionId);

        assertThat(result).isPresent();
        SM2Schedule schedule = result.get();
        assertThat(schedule.id()).isEqualTo(entity.getId());
        assertThat(schedule.userId()).isEqualTo(entity.getUserId());
        assertThat(schedule.questionId()).isEqualTo(entity.getQuestionId());
    }

    @Test
    @DisplayName("Should save and return the saved SM2Schedule")
    public void save_SavesAndReturnsSM2Schedule() {
        SM2Schedule schedule = new SM2Schedule(UUID.randomUUID(), userId, questionId,
                1.5f, 30, 2, null, null);
        SM2ScheduleEntity entity = adapter.toEntity(schedule);

        when(jpaRepository.save(entity)).thenReturn(entity);

        SM2Schedule savedSchedule = adapter.save(schedule);

        assertThat(savedSchedule.id()).isEqualTo(entity.getId());
        verify(jpaRepository).save(entity);
    }
}
```
