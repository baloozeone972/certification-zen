package com.certifapp.infrastructure.persistence.repository;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@DataJpaTest
@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)
@Testcontainers
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)
public class UserAnswerJpaRepositoryTest {

    @Container
    public static PostgreSQLContainer<?> postgresql = new PostgreSQLContainer<>("postgres:latest")
            .withDatabaseName("testdb")
            .withUsername("testuser")
            .withPassword("testpass");

    @Autowired
    private UserAnswerJpaRepository userAnswerJpaRepository;

    @BeforeEach
    public void setUp() {
        when(userAnswerJpaRepository.findAll()).thenReturn(Arrays.asList(new UserAnswerEntity(), new UserAnswerEntity()));
    }

    @AfterEach
    public void tearDown() {
        reset(userAnswerJpaRepository);
    }

    @Test
    @DisplayName("findBySessionIdOrderByAnsweredAt_nominalCase")
    public void findBySessionIdOrderByAnsweredAt_nominalCase() {
        UUID sessionId = UUID.randomUUID();
        when(userAnswerJpaRepository.findBySessionIdOrderByAnsweredAt(sessionId)).thenReturn(Arrays.asList(new UserAnswerEntity(), new UserAnswerEntity()));

        List<UserAnswerEntity> result = userAnswerJpaRepository.findBySessionIdOrderByAnsweredAt(sessionId);

        assertThat(result).isNotEmpty().hasSize(2);
        verify(userAnswerJpaRepository, times(1)).findBySessionIdOrderByAnsweredAt(eq(sessionId));
    }

    @Test
    @DisplayName("findBySessionIdOrderByAnsweredAt_emptyResult")
    public void findBySessionIdOrderByAnsweredAt_emptyResult() {
        UUID sessionId = UUID.randomUUID();
        when(userAnswerJpaRepository.findBySessionIdOrderByAnsweredAt(sessionId)).thenReturn(Arrays.asList());

        List<UserAnswerEntity> result = userAnswerJpaRepository.findBySessionIdOrderByAnsweredAt(sessionId);

        assertThat(result).isEmpty();
        verify(userAnswerJpaRepository, times(1)).findBySessionIdOrderByAnsweredAt(eq(sessionId));
    }

    @Test
    @DisplayName("findBySessionIdOrderByAnsweredAt_errorCase")
    public void findBySessionIdOrderByAnsweredAt_errorCase() {
        UUID sessionId = null;
        when(userAnswerJpaRepository.findBySessionIdOrderByAnsweredAt(any(UUID.class))).thenThrow(new IllegalArgumentException());

        assertThatThrownBy(() -> userAnswerJpaRepository.findBySessionIdOrderByAnsweredAt(sessionId))
                .isInstanceOf(IllegalArgumentException.class);
    }
}