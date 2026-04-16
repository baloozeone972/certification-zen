```java
package com.certifapp.infrastructure.persistence.entity;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;

import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class SM2ScheduleEntityTest {

    @InjectMocks
    private SM2ScheduleEntity sm2ScheduleEntity;

    @BeforeEach
    public void setUp() {
        sm2ScheduleEntity = new SM2ScheduleEntity();
    }

    @DisplayName("SM2ScheduleEntity getId_stateUnderTest_expectedBehavior")
    @Test
    public void testGetId() {
        UUID expectedId = UUID.randomUUID();
        sm2ScheduleEntity.setId(expectedId);
        assertThat(sm2ScheduleEntity.getId()).isEqualTo(expectedId);
    }

    @DisplayName("SM2ScheduleEntity getUserId_stateUnderTest_expectedBehavior")
    @Test
    public void testGetUserId() {
        UUID expectedUserId = UUID.randomUUID();
        sm2ScheduleEntity.setUserId(expectedUserId);
        assertThat(sm2ScheduleEntity.getUserId()).isEqualTo(expectedUserId);
    }

    @DisplayName("SM2ScheduleEntity getQuestionId_stateUnderTest_expectedBehavior")
    @Test
    public void testGetQuestionId() {
        UUID expectedQuestionId = UUID.randomUUID();
        sm2ScheduleEntity.setQuestionId(expectedQuestionId);
        assertThat(sm2ScheduleEntity.getQuestionId()).isEqualTo(expectedQuestionId);
    }

    @DisplayName("SM2ScheduleEntity getEaseFactor_stateUnderTest_expectedBehavior")
    @Test
    public void testGetEaseFactor() {
        double expectedEaseFactor = 3.0;
        sm2ScheduleEntity.setEaseFactor(expectedEaseFactor);
        assertThat(sm2ScheduleEntity.getEaseFactor()).isEqualTo(expectedEaseFactor);
    }

    @DisplayName("SM2ScheduleEntity getIntervalDays_stateUnderTest_expectedBehavior")
    @Test
    public void testGetIntervalDays() {
        int expectedIntervalDays = 5;
        sm2ScheduleEntity.setIntervalDays(expectedIntervalDays);
        assertThat(sm2ScheduleEntity.getIntervalDays()).isEqualTo(expectedIntervalDays);
    }

    @DisplayName("SM2ScheduleEntity getRepetitions_stateUnderTest_expectedBehavior")
    @Test
    public void testGetRepetitions() {
        int expectedRepetitions = 3;
        sm2ScheduleEntity.setRepetitions(expectedRepetitions);
        assertThat(sm2ScheduleEntity.getRepetitions()).isEqualTo(expectedRepetitions);
    }

    @DisplayName("SM2ScheduleEntity getDueDate_stateUnderTest_expectedBehavior")
    @Test
    public void testGetDueDate() {
        LocalDate expectedDueDate = LocalDate.now().plusDays(7);
        sm2ScheduleEntity.setDueDate(expectedDueDate);
        assertThat(sm2ScheduleEntity.getDueDate()).isEqualTo(expectedDueDate);
    }

    @DisplayName("SM2ScheduleEntity getLastReviewedAt_stateUnderTest_expectedBehavior")
    @Test
    public void testGetLastReviewedAt() {
        OffsetDateTime expectedLastReviewedAt = OffsetDateTime.now();
        sm2ScheduleEntity.setLastReviewedAt(expectedLastReviewedAt);
        assertThat(sm2ScheduleEntity.getLastReviewedAt()).isEqualTo(expectedLastReviewedAt);
    }
}
```
