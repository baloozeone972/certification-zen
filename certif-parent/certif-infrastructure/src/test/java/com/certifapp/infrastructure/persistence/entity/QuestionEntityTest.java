package com.certifapp.infrastructure.persistence.entity;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestPropertySource;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;

@DataJpaTest
@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)
@TestPropertySource(properties = "spring.flyway.enabled=true")
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)
public class QuestionEntityTest {

    @BeforeEach
    public void setUp() {
        // No need for setup as we are using DataJpaTest
    }

    @DisplayName("should set id successfully")
    @Test
    public void setId_successfully() {
        UUID testId = UUID.randomUUID();
        QuestionEntity questionEntity = new QuestionEntity();
        questionEntity.setId(testId);
        assertThat(questionEntity.getId()).isEqualTo(testId);
    }

    @DisplayName("should set legacyId successfully")
    @Test
    public void setLegacyId_successfully() {
        String testLegacyId = "legacy123";
        QuestionEntity questionEntity = new QuestionEntity();
        questionEntity.setLegacyId(testLegacyId);
        assertThat(questionEntity.getLegacyId()).isEqualTo(testLegacyId);
    }

    @DisplayName("should set certificationId successfully")
    @Test
    public void setCertificationId_successfully() {
        String testCertificationId = "certif456";
        QuestionEntity questionEntity = new QuestionEntity();
        questionEntity.setCertificationId(testCertificationId);
        assertThat(questionEntity.getCertificationId()).isEqualTo(testCertificationId);
    }

    @DisplayName("should set themeId successfully")
    @Test
    public void setThemeId_successfully() {
        UUID testThemeId = UUID.randomUUID();
        QuestionEntity questionEntity = new QuestionEntity();
        questionEntity.setThemeId(testThemeId);
        assertThat(questionEntity.getThemeId()).isEqualTo(testThemeId);
    }

    @DisplayName("should set statement successfully")
    @Test
    public void setStatement_successfully() {
        String testStatement = "What is Java?";
        QuestionEntity questionEntity = new QuestionEntity();
        questionEntity.setStatement(testStatement);
        assertThat(questionEntity.getStatement()).isEqualTo(testStatement);
    }

    @DisplayName("should set difficulty successfully")
    @Test
    public void setDifficulty_successfully() {
        String testDifficulty = "Easy";
        QuestionEntity questionEntity = new QuestionEntity();
        questionEntity.setDifficulty(testDifficulty);
        assertThat(questionEntity.getDifficulty()).isEqualTo(testDifficulty);
    }

    @DisplayName("should set questionType successfully")
    @Test
    public void setQuestionType_successfully() {
        String testQuestionType = "Multiple Choice";
        QuestionEntity questionEntity = new QuestionEntity();
        questionEntity.setQuestionType(testQuestionType);
        assertThat(questionEntity.getQuestionType()).isEqualTo(testQuestionType);
    }

    @DisplayName("should set explanationOriginal successfully")
    @Test
    public void setExplanationOriginal_successfully() {
        String testExplanationOriginal = "Java is a programming language.";
        QuestionEntity questionEntity = new QuestionEntity();
        questionEntity.setExplanationOriginal(testExplanationOriginal);
        assertThat(questionEntity.getExplanationOriginal()).isEqualTo(testExplanationOriginal);
    }

    @DisplayName("should set explanationEnriched successfully")
    @Test
    public void setExplanationEnriched_successfully() {
        String testExplanationEnriched = "Java is a high-level, class-based, object-oriented programming language.";
        QuestionEntity questionEntity = new QuestionEntity();
        questionEntity.setExplanationEnriched(testExplanationEnriched);
        assertThat(questionEntity.getExplanationEnriched()).isEqualTo(testExplanationEnriched);
    }

    @DisplayName("should set explanationStatus successfully")
    @Test
    public void setExplanationStatus_successfully() {
        String testExplanationStatus = "ENRICHED";
        QuestionEntity questionEntity = new QuestionEntity();
        questionEntity.setExplanationStatus(testExplanationStatus);
        assertThat(questionEntity.getExplanationStatus()).isEqualTo(testExplanationStatus);
    }

    @DisplayName("should set explanationVersion successfully")
    @Test
    public void setExplanationVersion_successfully() {
        int testExplanationVersion = 2;
        QuestionEntity questionEntity = new QuestionEntity();
        questionEntity.setExplanationVersion(testExplanationVersion);
        assertThat(questionEntity.getExplanationVersion()).isEqualTo(testExplanationVersion);
    }

    @DisplayName("should set officialDocUrl successfully")
    @Test
    public void setOfficialDocUrl_successfully() {
        String testOfficialDocUrl = "https://docs.oracle.com/javase/tutorial/";
        QuestionEntity questionEntity = new QuestionEntity();
        questionEntity.setOfficialDocUrl(testOfficialDocUrl);
        assertThat(questionEntity.getOfficialDocUrl()).isEqualTo(testOfficialDocUrl);
    }

    @DisplayName("should set codeExample successfully")
    @Test
    public void setCodeExample_successfully() {
        String testCodeExample = "public class HelloWorld { public static void main(String[] args) { System.out.println(\"Hello, World!\"); } }";
        QuestionEntity questionEntity = new QuestionEntity();
        questionEntity.setCodeExample(testCodeExample);
        assertThat(questionEntity.getCodeExample()).isEqualTo(testCodeExample);
    }

    @DisplayName("should set aiConfidenceScore successfully")
    @Test
    public void setAiConfidenceScore_successfully() {
        Double testAiConfidenceScore = 0.95;
        QuestionEntity questionEntity = new QuestionEntity();
        questionEntity.setAiConfidenceScore(testAiConfidenceScore);
        assertThat(questionEntity.getAiConfidenceScore()).isEqualTo(testAiConfidenceScore);
    }

    @DisplayName("should set lastReviewedBy successfully")
    @Test
    public void setLastReviewedBy_successfully() {
        UUID testLastReviewedBy = UUID.randomUUID();
        QuestionEntity questionEntity = new QuestionEntity();
        questionEntity.setLastReviewedBy(testLastReviewedBy);
        assertThat(questionEntity.getLastReviewedBy()).isEqualTo(testLastReviewedBy);
    }

    @DisplayName("should set lastReviewedAt successfully")
    @Test
    public void setLastReviewedAt_successfully() {
        OffsetDateTime testLastReviewedAt = OffsetDateTime.now();
        QuestionEntity questionEntity = new QuestionEntity();
        questionEntity.setLastReviewedAt(testLastReviewedAt);
        assertThat(questionEntity.getLastReviewedAt()).isEqualTo(testLastReviewedAt);
    }

    @DisplayName("should set isActive successfully")
    @Test
    public void setActive_successfully() {
        boolean testIsActive = false;
        QuestionEntity questionEntity = new QuestionEntity();
        questionEntity.setActive(testIsActive);
        assertThat(questionEntity.isActive()).isEqualTo(testIsActive);
    }

    @DisplayName("should set createdAt successfully on create")
    @Test
    public void onCreate_setCreatedAt_successfully() {
        OffsetDateTime now = OffsetDateTime.now();
        QuestionEntity questionEntity = new QuestionEntity();
        questionEntity.onCreate();

        assertThat(questionEntity.getCreatedAt()).isEqualTo(now);
    }

    @DisplayName("should not change createdAt on update")
    @Test
    public void onUpdate_noChangeInCreatedAt() {
        OffsetDateTime createdNow = OffsetDateTime.now();
        QuestionEntity questionEntity = new QuestionEntity();
        questionEntity.setCreatedAt(createdNow);

        questionEntity.onUpdate();

        assertThat(questionEntity.getCreatedAt()).isEqualTo(createdNow);
    }

    @DisplayName("should update updatedAt on update")
    @Test
    public void onUpdate_updateUpdatedAt() {
        OffsetDateTime now = OffsetDateTime.now();
        QuestionEntity questionEntity = new QuestionEntity();
        questionEntity.onUpdate();

        assertThat(questionEntity.getUpdatedAt()).isEqualTo(now);
    }
}