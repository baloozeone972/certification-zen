```java
package com.certifapp.infrastructure.persistence.repository;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

import com.certifapp.infrastructure.persistence.entity.SM2ScheduleEntity;
import java.util.Optional;
import java.util.UUID;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class SM2ScheduleJpaRepositoryTest {

    @Mock
    private JpaRepository<SM2ScheduleEntity, UUID> jpaRepository;

    @InjectMocks
    private SM2ScheduleJpaRepository sm2ScheduleJpaRepository;

    @BeforeEach
    public void setUp() {
        when(jpaRepository.findByUserIdAndQuestionId(any(UUID.class), any(UUID.class))).thenReturn(Optional.empty());
    }

    @Test
    @DisplayName("findByUserIdAndQuestionId_nominalCase_returnPresent")
    public void findByUserIdAndQuestionId_nominalCase_returnPresent() {
        UUID userId = UUID.randomUUID();
        UUID questionId = UUID.randomUUID();
        SM2ScheduleEntity entity = new SM2ScheduleEntity();
        when(jpaRepository.findByUserIdAndQuestionId(userId, questionId)).thenReturn(Optional.of(entity));

        Optional<SM2ScheduleEntity> result = sm2ScheduleJpaRepository.findByUserIdAndQuestionId(userId, questionId);

        assertThat(result).isPresent().contains(entity);
        verify(jpaRepository, times(1)).findByUserIdAndQuestionId(userId, questionId);
    }

    @Test
    @DisplayName("findByUserIdAndQuestionId_edgeCase_nullInputs_returnEmpty")
    public void findByUserIdAndQuestionId_edgeCase_nullInputs_returnEmpty() {
        Optional<SM2ScheduleEntity> result = sm2ScheduleJpaRepository.findByUserIdAndQuestionId(null, null);

        assertThat(result).isEmpty();
        verify(jpaRepository, never()).findByUserIdAndQuestionId(any(UUID.class), any(UUID.class));
    }

    @Test
    @DisplayName("findByUserIdAndQuestionId_errorCase_userIdNull_returnEmpty")
    public void findByUserIdAndQuestionId_errorCase_userIdNull_returnEmpty() {
        UUID questionId = UUID.randomUUID();
        Optional<SM2ScheduleEntity> result = sm2ScheduleJpaRepository.findByUserIdAndQuestionId(null, questionId);

        assertThat(result).isEmpty();
        verify(jpaRepository, never()).findByUserIdAndQuestionId(any(UUID.class), any(UUID.class));
    }

    @Test
    @DisplayName("findByUserIdAndQuestionId_errorCase_questionIdNull_returnEmpty")
    public void findByUserIdAndQuestionId_errorCase_questionIdNull_returnEmpty() {
        UUID userId = UUID.randomUUID();
        Optional<SM2ScheduleEntity> result = sm2ScheduleJpaRepository.findByUserIdAndQuestionId(userId, null);

        assertThat(result).isEmpty();
        verify(jpaRepository, never()).findByUserIdAndQuestionId(any(UUID.class), any(UUID.class));
    }
}
```
