package com.certifapp.infrastructure.persistence.entity;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;

import java.time.OffsetDateTime;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;

@DataJpaTest
@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)
@SpringBootTestContextInitializer.class

@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)
public class ExamSessionEntityTest {

    @BeforeEach
    public void setUp() {
        // No need to set up mocks or inject mocks for this test
    }

    @DisplayName("should set and get id correctly")
    @Test
    public void setId_getId_correctly() {
        UUID testId = UUID.randomUUID();
        ExamSessionEntity examSessionEntity = new ExamSessionEntity();
        examSessionEntity.setId(testId);
        assertThat(examSessionEntity.getId()).isEqualTo(testId);
    }

    @DisplayName("should generate created_at on create")
    @Test
    public void onCreate_setsCreatedAtToCurrentTime() {
        ExamSessionEntity examSessionEntity = new ExamSessionEntity();
        examSessionEntity.onCreate();
        OffsetDateTime createdAt = examSessionEntity.getCreatedAt();
        assertThat(createdAt).isNotNull();
    }

    @DisplayName("should set and get user_id correctly")
    @Test
    public void setUser_Id_getUserId_correctly() {
        UUID testUserId = UUID.randomUUID();
        ExamSessionEntity examSessionEntity = new ExamSessionEntity();
        examSessionEntity.setUserId(testUserId);
        assertThat(examSessionEntity.getUserId()).isEqualTo(testUserId);
    }

    @DisplayName("should set and get certification_id correctly")
    @Test
    public void setCertificationId_getCertificationId_correctly() {
        String testCertId = "cert123";
        ExamSessionEntity examSessionEntity = new ExamSessionEntity();
        examSessionEntity.setCertificationId(testCertId);
        assertThat(examSessionEntity.getCertificationId()).isEqualTo(testCertId);
    }

    @DisplayName("should set and get mode correctly")
    @Test
    public void setMode_getMode_correctly() {
        String testMode = "online";
        ExamSessionEntity examSessionEntity = new ExamSessionEntity();
        examSessionEntity.setMode(testMode);
        assertThat(examSessionEntity.getMode()).isEqualTo(testMode);
    }

    @DisplayName("should set and get status correctly")
    @Test
    public void setStatus_getStatus_correctly() {
        String testStatus = "in_progress";
        ExamSessionEntity examSessionEntity = new ExamSessionEntity();
        examSessionEntity.setStatus(testStatus);
        assertThat(examSessionEntity.getStatus()).isEqualTo(testStatus);
    }

    @DisplayName("should set and get started_at correctly")
    @Test
    public void setStartedAt_getStartedAt_correctly() {
        OffsetDateTime testStartTime = OffsetDateTime.now();
        ExamSessionEntity examSessionEntity = new ExamSessionEntity();
        examSessionEntity.setStartedAt(testStartTime);
        assertThat(examSessionEntity.getStartedAt()).isEqualTo(testStartTime);
    }

    @DisplayName("should set and get ended_at correctly")
    @Test
    public void setEndedAt_getEndedAt_correctly() {
        OffsetDateTime testEndTime = OffsetDateTime.now();
        ExamSessionEntity examSessionEntity = new ExamSessionEntity();
        examSessionEntity.setEndedAt(testEndTime);
        assertThat(examSessionEntity.getEndedAt()).isEqualTo(testEndTime);
    }

    @DisplayName("should set and get duration_seconds correctly")
    @Test
    public void setDurationSeconds_getDurationSeconds_correctly() {
        Integer testDuration = 120;
        ExamSessionEntity examSessionEntity = new ExamSessionEntity();
        examSessionEntity.setDurationSeconds(testDuration);
        assertThat(examSessionEntity.getDurationSeconds()).isEqualTo(testDuration);
    }

    @DisplayName("should set and get total_questions correctly")
    @Test
    public void setTotalQuestions_getTotalQuestions_correctly() {
        int testTotalQuestions = 50;
        ExamSessionEntity examSessionEntity = new ExamSessionEntity();
        examSessionEntity.setTotalQuestions(testTotalQuestions);
        assertThat(examSessionEntity.getTotalQuestions()).isEqualTo(testTotalQuestions);
    }

    @DisplayName("should set and get correct_count correctly")
    @Test
    public void setCorrectCount_getCorrectCount_correctly() {
        int testCorrectCount = 40;
        ExamSessionEntity examSessionEntity = new ExamSessionEntity();
        examSessionEntity.setCorrectCount(testCorrectCount);
        assertThat(examSessionEntity.getCorrectCount()).isEqualTo(testCorrectCount);
    }

    @DisplayName("should set and get percentage correctly")
    @Test
    public void setPercentage_getPercentage_correctly() {
        double testPercentage = 80.0;
        ExamSessionEntity examSessionEntity = new ExamSessionEntity();
        examSessionEntity.setPercentage(testPercentage);
        assertThat(examSessionEntity.getPercentage()).isEqualTo(testPercentage);
    }

    @DisplayName("should set and get passed correctly")
    @Test
    public void setPassed_getPassed_correctly() {
        boolean testPassed = true;
        ExamSessionEntity examSessionEntity = new ExamSessionEntity();
        examSessionEntity.setPassed(testPassed);
        assertThat(examSessionEntity.isPassed()).isEqualTo(testPassed);
    }
}