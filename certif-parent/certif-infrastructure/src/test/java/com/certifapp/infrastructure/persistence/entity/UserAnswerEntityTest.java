package com.certifapp.infrastructure.persistence.entity;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.verifyNoMoreInteractions;

@DataJpaTest
@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)
@SpringJUnitConfig(classes = {UserAnswerEntityTest.Config.class})
@Testcontainers
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)
public class UserAnswerEntityTest {

    @Container
    public static PostgreSQLContainer<?> postgresql = new PostgreSQLContainer<>("postgres:latest")
            .withDatabaseName("testdb")
            .withUsername("testuser")
            .withPassword("testpass");

    @Autowired
    private UserAnswerRepository userAnswerRepository;

    @BeforeEach
    public void setUp() {
        // No setup needed for this test
    }

    @AfterEach
    public void tearDown() {
        verifyNoMoreInteractions(userAnswerRepository);
    }

    @Test
    @DisplayName("Test UserAnswerEntity creation with correct values")
    public void testUserAnswerEntityCreationCorrectValues() {
        UserAnswerEntity userAnswerEntity = new UserAnswerEntity();
        userAnswerEntity.setId(UUID.randomUUID());
        userAnswerEntity.setSessionId(UUID.randomUUID());
        userAnswerEntity.setQuestionId(UUID.randomUUID());
        userAnswerEntity.setSelectedOption(UUID.randomUUID());

        UserAnswerEntity savedUserAnswer = userAnswerRepository.save(userAnswerEntity);

        assertThat(savedUserAnswer.getId()).isNotNull();
        assertThat(savedUserAnswer.getSessionId()).isEqualTo(userAnswerEntity.getSessionId());
        assertThat(savedUserAnswer.getQuestionId()).isEqualTo(userAnswerEntity.getQuestionId());
        assertThat(savedUserAnswer.getSelectedOption()).isEqualTo(userAnswerEntity.getSelectedOption());
        assertThat(savedUserAnswer.isCorrect()).isFalse();
        assertThat(savedUserAnswer.isSkipped()).isFalse();
        assertThat(savedUserAnswer.getResponseTimeMs()).isNull();
        assertThat(savedUserAnswer.getAnsweredAt()).isNotNull();
    }

    @Test
    @DisplayName("Test UserAnswerEntity creation with null values")
    public void testUserAnswerEntityCreationNullValues() {
        UserAnswerEntity userAnswerEntity = new UserAnswerEntity();
        userAnswerEntity.setId(null);
        userAnswerEntity.setSessionId(null);
        userAnswerEntity.setQuestionId(null);
        userAnswerEntity.setSelectedOption(null);

        UserAnswerEntity savedUserAnswer = userAnswerRepository.save(userAnswerEntity);

        assertThat(savedUserAnswer.getId()).isNull();
        assertThat(savedUserAnswer.getSessionId()).isNull();
        assertThat(savedUserAnswer.getQuestionId()).isNull();
        assertThat(savedUserAnswer.getSelectedOption()).isNull();
    }

    @Test
    @DisplayName("Test UserAnswerEntity creation with isCorrect set to true")
    public void testUserAnswerEntityCreationIsCorrectTrue() {
        UserAnswerEntity userAnswerEntity = new UserAnswerEntity();
        userAnswerEntity.setId(UUID.randomUUID());
        userAnswerEntity.setSessionId(UUID.randomUUID());
        userAnswerEntity.setQuestionId(UUID.randomUUID());
        userAnswerEntity.setSelectedOption(UUID.randomUUID());
        userAnswerEntity.setCorrect(true);

        UserAnswerEntity savedUserAnswer = userAnswerRepository.save(userAnswerEntity);

        assertThat(savedUserAnswer.isCorrect()).isTrue();
    }

    @Test
    @DisplayName("Test UserAnswerEntity creation with isSkipped set to true")
    public void testUserAnswerEntityCreationIsSkippedTrue() {
        UserAnswerEntity userAnswerEntity = new UserAnswerEntity();
        userAnswerEntity.setId(UUID.randomUUID());
        userAnswerEntity.setSessionId(UUID.randomUUID());
        userAnswerEntity.setQuestionId(UUID.randomUUID());
        userAnswerEntity.setSelectedOption(UUID.randomUUID());
        userAnswerEntity.setSkipped(true);

        UserAnswerEntity savedUserAnswer = userAnswerRepository.save(userAnswerEntity);

        assertThat(savedUserAnswer.isSkipped()).isTrue();
    }

    @Test
    @DisplayName("Test UserAnswerEntity creation with responseTimeMs set to a value")
    public void testUserAnswerEntityCreationResponseTimeMsValue() {
        UserAnswerEntity userAnswerEntity = new UserAnswerEntity();
        userAnswerEntity.setId(UUID.randomUUID());
        userAnswerEntity.setSessionId(UUID.randomUUID());
        userAnswerEntity.setQuestionId(UUID.randomUUID());
        userAnswerEntity.setSelectedOption(UUID.randomUUID());
        userAnswerEntity.setResponseTimeMs(100L);

        UserAnswerEntity savedUserAnswer = userAnswerRepository.save(userAnswerEntity);

        assertThat(savedUserAnswer.getResponseTimeMs()).isEqualTo(100L);
    }

    static class Config {
        // Configuration for the test
    }
}