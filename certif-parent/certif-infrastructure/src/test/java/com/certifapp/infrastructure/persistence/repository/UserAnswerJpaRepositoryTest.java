package com.certifapp.infrastructure.persistence.repository;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

import java.util.Arrays;
import java.util.List;
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
public class UserAnswerJpaRepositoryTest {

    @Mock
    private JpaRepository<UserAnswerEntity, UUID> jpaRepository;

    @InjectMocks
    private UserAnswerJpaRepository userAnswerJpaRepository;

    @BeforeEach
    public void setUp() {
        when(jpaRepository.findAll()).thenReturn(Arrays.asList(new UserAnswerEntity(), new UserAnswerEntity()));
    }

    @AfterEach
    public void tearDown() {
        reset(jpaRepository);
    }

    @Test
    @DisplayName("findBySessionIdOrderByAnsweredAt_nominalCase")
    public void findBySessionIdOrderByAnsweredAt_nominalCase() {
        UUID sessionId = UUID.randomUUID();
        when(jpaRepository.findBySessionIdOrderByAnsweredAt(sessionId)).thenReturn(Arrays.asList(new UserAnswerEntity(), new UserAnswerEntity()));

        List<UserAnswerEntity> result = userAnswerJpaRepository.findBySessionIdOrderByAnsweredAt(sessionId);

        assertThat(result).isNotEmpty().hasSize(2);
        verify(jpaRepository, times(1)).findBySessionIdOrderByAnsweredAt(eq(sessionId));
    }

    @Test
    @DisplayName("findBySessionIdOrderByAnsweredAt_emptyResult")
    public void findBySessionIdOrderByAnsweredAt_emptyResult() {
        UUID sessionId = UUID.randomUUID();
        when(jpaRepository.findBySessionIdOrderByAnsweredAt(sessionId)).thenReturn(Arrays.asList());

        List<UserAnswerEntity> result = userAnswerJpaRepository.findBySessionIdOrderByAnsweredAt(sessionId);

        assertThat(result).isEmpty();
        verify(jpaRepository, times(1)).findBySessionIdOrderByAnsweredAt(eq(sessionId));
    }

    @Test
    @DisplayName("findBySessionIdOrderByAnsweredAt_errorCase")
    public void findBySessionIdOrderByAnsweredAt_errorCase() {
        UUID sessionId = null;
        when(jpaRepository.findBySessionIdOrderByAnsweredAt(any(UUID.class))).thenThrow(new IllegalArgumentException());

        assertThatThrownBy(() -> userAnswerJpaRepository.findBySessionIdOrderByAnsweredAt(sessionId))
            .isInstanceOf(IllegalArgumentException.class);
    }
}
