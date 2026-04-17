package com.certifapp.infrastructure.persistence.entity;

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

import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;

@DataJpaTest
@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)
@Testcontainers
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)
public class SM2ScheduleEntityTest {

    @Container
    public static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:latest")
            .withDatabaseName("testdb")
            .withUsername("testuser")
            .withPassword("testpass");

    @Autowired
    private SM2ScheduleRepository sm2ScheduleRepository;

    @BeforeEach
    public void setUp() {
        // No need to set up manually as DataJpaTest handles it
    }

    @DisplayName("SM2ScheduleEntity getId_stateUnderTest_expectedBehavior")
    @Test
    public void testGetId() {
        UUID expectedId = UUID.randomUUID();
        SM2ScheduleEntity entity = new SM2ScheduleEntity(expectedId, null, null, 0.0, 0, 0, LocalDate.now(), OffsetDateTime.now());
        sm2ScheduleRepository.save(entity);
        SM2ScheduleEntity retrievedEntity = sm2ScheduleRepository.findById(expectedId).orElse(null);
        assertThat(retrievedEntity.getId()).isEqualTo(expectedId);
    }

    @DisplayName("SM2ScheduleEntity getUserId_stateUnderTest_expectedBehavior")
    @Test
    public void testGetUserId() {
        UUID expectedId = UUID.randomUUID();
        SM2ScheduleEntity entity = new SM2ScheduleEntity(expectedId, null, null, 0.0, 0, 0, LocalDate.now(), OffsetDateTime.now());
        sm2ScheduleRepository.save(entity);
        SM2ScheduleEntity retrievedEntity = sm2ScheduleRepository.findById(expectedId).orElse(null);
        assertThat(retrievedEntity.getUserId()).isNull(); // Assuming default value is null
    }

    @DisplayName("SM2ScheduleEntity getQuestionId_stateUnderTest_expectedBehavior")
    @Test
    public void testGetQuestionId() {
        UUID expectedId = UUID.randomUUID();
        SM2ScheduleEntity entity = new SM2ScheduleEntity(expectedId, null, expectedId, 0.0, 0, 0, LocalDate.now(), OffsetDateTime.now());
        sm2ScheduleRepository.save(entity);
        SM2ScheduleEntity retrievedEntity = sm2ScheduleRepository.findById(expectedId).orElse(null);
        assertThat(retrievedEntity.getQuestionId()).isEqualTo(expectedId);
    }

    @DisplayName("SM2ScheduleEntity getEaseFactor_stateUnderTest_expectedBehavior")
    @Test
    public void testGetEaseFactor() {
        double expectedEaseFactor = 3.0;
        SM2ScheduleEntity entity = new SM2ScheduleEntity(null, null, null, expectedEaseFactor, 0, 0, LocalDate.now(), OffsetDateTime.now());
        sm2ScheduleRepository.save(entity);
        SM2ScheduleEntity retrievedEntity = sm2ScheduleRepository.findById(entity.getId()).orElse(null);
        assertThat(retrievedEntity.getEaseFactor()).isEqualTo(expectedEaseFactor);
    }

    @DisplayName("SM2ScheduleEntity getIntervalDays_stateUnderTest_expectedBehavior")
    @Test
    public void testGetIntervalDays() {
        int expectedIntervalDays = 5;
        SM2ScheduleEntity entity = new SM2ScheduleEntity(null, null, null, 0.0, expectedIntervalDays, 0, LocalDate.now(), OffsetDateTime.now());
        sm2ScheduleRepository.save(entity);
        SM2ScheduleEntity retrievedEntity = sm2ScheduleRepository.findById(entity.getId()).orElse(null);
        assertThat(retrievedEntity.getIntervalDays()).isEqualTo(expectedIntervalDays);
    }

    @DisplayName("SM2ScheduleEntity getRepetitions_stateUnderTest_expectedBehavior")
    @Test
    public void testGetRepetitions() {
        int expectedRepetitions = 3;
        SM2ScheduleEntity entity = new SM2ScheduleEntity(null, null, null, 0.0, 0, expectedRepetitions, LocalDate.now(), OffsetDateTime.now());
        sm2ScheduleRepository.save(entity);
        SM2ScheduleEntity retrievedEntity = sm2ScheduleRepository.findById(entity.getId()).orElse(null);
        assertThat(retrievedEntity.getRepetitions()).isEqualTo(expectedRepetitions);
    }

    @DisplayName("SM2ScheduleEntity getDueDate_stateUnderTest_expectedBehavior")
    @Test
    public void testGetDueDate() {
        LocalDate expectedDueDate = LocalDate.now().plusDays(7);
        SM2ScheduleEntity entity = new SM2ScheduleEntity(null, null, null, 0.0, 0, 0, expectedDueDate, OffsetDateTime.now());
        sm2ScheduleRepository.save(entity);
        SM2ScheduleEntity retrievedEntity = sm2ScheduleRepository.findById(entity.getId()).orElse(null);
        assertThat(retrievedEntity.getDueDate()).isEqualTo(expectedDueDate);
    }

    @DisplayName("SM2ScheduleEntity getLastReviewedAt_stateUnderTest_expectedBehavior")
    @Test
    public void testGetLastReviewedAt() {
        OffsetDateTime expectedLastReviewedAt = OffsetDateTime.now();
        SM2ScheduleEntity entity = new SM2ScheduleEntity(null, null, null, 0.0, 0, 0, LocalDate.now(), expectedLastReviewedAt);
        sm2ScheduleRepository.save(entity);
        SM2ScheduleEntity retrievedEntity = sm2ScheduleRepository.findById(entity.getId()).orElse(null);
        assertThat(retrievedEntity.getLastReviewedAt()).isEqualTo(expectedLastReviewedAt);
    }
}