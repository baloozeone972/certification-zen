package com.certifapp.infrastructure.persistence.entity;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import com.certifapp.infrastructure.persistence.entity.QuestionEntity;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class QuestionEntityTest {

    @Mock
    private QuestionOptionEntity option1;

    @InjectMocks
    private QuestionEntity questionEntity;

    @BeforeEach
    public void setUp() {
        questionEntity.setOptions(List.of(option1));
    }

    @DisplayName("should set id successfully")
    @Test
    public void setId_successfully() {
        UUID testId = UUID.randomUUID();
        questionEntity.setId(testId);
        assertThat(questionEntity.getId()).isEqualTo(testId);
    }

    @DisplayName("should set legacyId successfully")
    @Test
    public void setLegacyId_successfully() {
        String testLegacyId = "legacy123";
        questionEntity.setLegacyId(testLegacyId);
        assertThat(questionEntity.getLegacyId()).isEqualTo(testLegacyId);
    }

    @DisplayName("should set certificationId successfully")
    @Test
    public void setCertificationId_successfully() {
        String testCertificationId = "certif456";
        questionEntity.setCertificationId(testCertificationId);
        assertThat(questionEntity.getCertificationId()).isEqualTo(testCertificationId);
    }

    @DisplayName("should set themeId successfully")
    @Test
    public void setThemeId_successfully() {
        UUID testThemeId = UUID.randomUUID();
        questionEntity.setThemeId(testThemeId);
        assertThat(questionEntity.getThemeId()).isEqualTo(testThemeId);
    }

    @DisplayName("should set statement successfully")
    @Test
    public void setStatement_successfully() {
        String testStatement = "What is Java?";
        questionEntity.setStatement(testStatement);
        assertThat(questionEntity.getStatement()).isEqualTo(testStatement);
    }

    @DisplayName("should set difficulty successfully")
    @Test
    public void setDifficulty_successfully() {
        String testDifficulty = "Easy";
        questionEntity.setDifficulty(testDifficulty);
        assertThat(questionEntity.getDifficulty()).isEqualTo(testDifficulty);
    }

    @DisplayName("should set questionType successfully")
    @Test
    public void setQuestionType_successfully() {
        String testQuestionType = "Multiple Choice";
        questionEntity.setQuestionType(testQuestionType);
        assertThat(questionEntity.getQuestionType()).isEqualTo(testQuestionType);
    }

    @DisplayName("should set explanationOriginal successfully")
    @Test
    public void setExplanationOriginal_successfully() {
        String testExplanationOriginal = "Java is a programming language.";
        questionEntity.setExplanationOriginal(testExplanationOriginal);
        assertThat(questionEntity.getExplanationOriginal()).isEqualTo(testExplanationOriginal);
    }

    @DisplayName("should set explanationEnriched successfully")
    @Test
    public void setExplanationEnriched_successfully() {
        String testExplanationEnriched = "Java is a high-level, class-based, object-oriented programming language.";
        questionEntity.setExplanationEnriched(testExplanationEnriched);
        assertThat(questionEntity.getExplanationEnriched()).isEqualTo(testExplanationEnriched);
    }

    @DisplayName("should set explanationStatus successfully")
    @Test
    public void setExplanationStatus_successfully() {
        String testExplanationStatus = "ENRICHED";
        questionEntity.setExplanationStatus(testExplanationStatus);
        assertThat(questionEntity.getExplanationStatus()).isEqualTo(testExplanationStatus);
    }

    @DisplayName("should set explanationVersion successfully")
    @Test
    public void setExplanationVersion_successfully() {
        int testExplanationVersion = 2;
        questionEntity.setExplanationVersion(testExplanationVersion);
        assertThat(questionEntity.getExplanationVersion()).isEqualTo(testExplanationVersion);
    }

    @DisplayName("should set officialDocUrl successfully")
    @Test
    public void setOfficialDocUrl_successfully() {
        String testOfficialDocUrl = "https://docs.oracle.com/javase/tutorial/";
        questionEntity.setOfficialDocUrl(testOfficialDocUrl);
        assertThat(questionEntity.getOfficialDocUrl()).isEqualTo(testOfficialDocUrl);
    }

    @DisplayName("should set codeExample successfully")
    @Test
    public void setCodeExample_successfully() {
        String testCodeExample = "public class HelloWorld { public static void main(String[] args) { System.out.println(\"Hello, World!\"); } }";
        questionEntity.setCodeExample(testCodeExample);
        assertThat(questionEntity.getCodeExample()).isEqualTo(testCodeExample);
    }

    @DisplayName("should set aiConfidenceScore successfully")
    @Test
    public void setAiConfidenceScore_successfully() {
        Double testAiConfidenceScore = 0.95;
        questionEntity.setAiConfidenceScore(testAiConfidenceScore);
        assertThat(questionEntity.getAiConfidenceScore()).isEqualTo(testAiConfidenceScore);
    }

    @DisplayName("should set lastReviewedBy successfully")
    @Test
    public void setLastReviewedBy_successfully() {
        UUID testLastReviewedBy = UUID.randomUUID();
        questionEntity.setLastReviewedBy(testLastReviewedBy);
        assertThat(questionEntity.getLastReviewedBy()).isEqualTo(testLastReviewedBy);
    }

    @DisplayName("should set lastReviewedAt successfully")
    @Test
    public void setLastReviewedAt_successfully() {
        OffsetDateTime testLastReviewedAt = OffsetDateTime.now();
        questionEntity.setLastReviewedAt(testLastReviewedAt);
        assertThat(questionEntity.getLastReviewedAt()).isEqualTo(testLastReviewedAt);
    }

    @DisplayName("should set isActive successfully")
    @Test
    public void setActive_successfully() {
        boolean testIsActive = false;
        questionEntity.setActive(testIsActive);
        assertThat(questionEntity.isActive()).isEqualTo(testIsActive);
    }

    @DisplayName("should set createdAt successfully on create")
    @Test
    public void onCreate_setCreatedAt_successfully() {
        OffsetDateTime now = OffsetDateTime.now();
        when(OffsetDateTime.now()).thenReturn(now);

        questionEntity.onCreate();

        assertThat(questionEntity.getCreatedAt()).isEqualTo(now);
    }

    @DisplayName("should not change createdAt on update")
    @Test
    public void onUpdate_noChangeInCreatedAt() {
        OffsetDateTime createdNow = OffsetDateTime.now();
        questionEntity.setCreatedAt(createdNow);

        when(OffsetDateTime.now()).thenReturn(createdNow.plusSeconds(1));

        questionEntity.onUpdate();

        assertThat(questionEntity.getCreatedAt()).isEqualTo(createdNow);
    }

    @DisplayName("should update updatedAt on update")
    @Test
    public void onUpdate_updateUpdatedAt() {
        OffsetDateTime now = OffsetDateTime.now();
        when(OffsetDateTime.now()).thenReturn(now);

        questionEntity.onUpdate();

        assertThat(questionEntity.getUpdatedAt()).isEqualTo(now);
    }
}
