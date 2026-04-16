```java
package com.certifapp.infrastructure.persistence.adapter;

import com.certifapp.domain.model.session.UserAnswer;
import com.certifapp.domain.port.output.UserAnswerRepository;
import com.certifapp.infrastructure.persistence.entity.ExamSessionEntity;
import com.certifapp.infrastructure.persistence.mapper.ExamSessionMapper;
import com.certifapp.infrastructure.persistence.repository.UserAnswerJpaRepository;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class UserAnswerRepositoryAdapterTest {

    @Mock
    private UserAnswerJpaRepository jpaRepository;

    @Mock
    private ExamSessionMapper mapper;

    @InjectMocks
    private UserAnswerRepositoryAdapter userAnswerRepositoryAdapter;

    private final UUID sessionId = UUID.randomUUID();
    private final UserAnswer userAnswer1 = new UserAnswer(sessionId, 1, "optionA");
    private final UserAnswer userAnswer2 = new UserAnswer(sessionId, 2, "optionB");
    private final ExamSessionEntity examSessionEntity1 = new ExamSessionEntity(sessionId, null);
    private final ExamSessionEntity examSessionEntity2 = new ExamSessionEntity(sessionId, null);

    @BeforeEach
    public void setUp() {
        when(mapper.toEntity(userAnswer1)).thenReturn(examSessionEntity1);
        when(mapper.toEntity(userAnswer2)).thenReturn(examSessionEntity2);
        when(mapper.toDomain(any(ExamSessionEntity.class))).thenReturn(userAnswer1);
        when(mapper.toDomainAnswerList(any(List.class))).thenReturn(Stream.of(userAnswer1, userAnswer2).collect(Collectors.toList()));
    }

    @AfterEach
    public void tearDown() {
        reset(jpaRepository, mapper);
    }

    @Test
    @DisplayName("should save a single UserAnswer correctly")
    public void save_singleUserAnswer_savedCorrectly() {
        UserAnswer savedAnswer = userAnswerRepositoryAdapter.save(userAnswer1);

        assertThat(savedAnswer).isEqualTo(userAnswer1);
        verify(jpaRepository, times(1)).save(examSessionEntity1);
    }

    @Test
    @DisplayName("should save all UserAnswers correctly")
    public void saveAll_allUserAnswers_savedCorrectly() {
        List<UserAnswer> savedAnswers = userAnswerRepositoryAdapter.saveAll(List.of(userAnswer1, userAnswer2));

        assertThat(savedAnswers).isEqualTo(List.of(userAnswer1, userAnswer2));
        verify(jpaRepository, times(1)).saveAll(anyList());
    }

    @Test
    @DisplayName("should find all UserAnswers by sessionId correctly")
    public void findBySessionId_validSessionId_foundCorrectly() {
        List<UserAnswer> answers = userAnswerRepositoryAdapter.findBySessionId(sessionId);

        assertThat(answers).isEqualTo(List.of(userAnswer1, userAnswer2));
        verify(jpaRepository, times(1)).findBySessionIdOrderByAnsweredAt(eq(sessionId));
    }

    @Test
    @DisplayName("should handle empty list when finding all UserAnswers by sessionId")
    public void findBySessionId_emptyList_whenFindingAll() {
        when(jpaRepository.findBySessionIdOrderByAnsweredAt(any(UUID.class))).thenReturn(List.of());

        List<UserAnswer> answers = userAnswerRepositoryAdapter.findBySessionId(sessionId);

        assertThat(answers).isEmpty();
        verify(jpaRepository, times(1)).findBySessionIdOrderByAnsweredAt(eq(sessionId));
    }

    @Test
    @DisplayName("should handle null sessionId when finding all UserAnswers")
    public void findBySessionId_nullSessionId_whenFindingAll() {
        UUID nullSessionId = null;

        assertThrows(IllegalArgumentException.class, () -> userAnswerRepositoryAdapter.findBySessionId(nullSessionId));

        verify(jpaRepository, never()).findBySessionIdOrderByAnsweredAt(any(UUID.class));
    }
}
```
