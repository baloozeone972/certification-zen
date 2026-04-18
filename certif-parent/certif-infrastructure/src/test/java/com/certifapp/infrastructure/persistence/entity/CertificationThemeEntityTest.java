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
import org.springframework.test.context.TestPropertySource;

import java.time.OffsetDateTime;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;

@DataJpaTest
@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)
@TestPropertySource(locations = "classpath:application-test.properties")
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)
public class CertificationThemeEntityTest {

    @Autowired
    private CertificationThemeRepository themeRepository;

    private CertificationThemeEntity theme;

    @BeforeEach
    public void setUp() {
        theme = new CertificationThemeEntity();
        theme.setId(UUID.randomUUID());
        theme.setCertification(new CertificationEntity());
        theme.setCode("testCode");
        theme.setLabel("testLabel");
        theme.setQuestionCount(10);
        theme.setWeightPercent(50.0);
        theme.setDisplayOrder(1);
    }

    @AfterEach
    public void tearDown() {
        themeRepository.deleteAll();
    }

    @Test
    @DisplayName(" nominal case: get and set id")
    public void getIdAndSetId_NominalCase() {
        UUID newId = UUID.randomUUID();
        theme.setId(newId);
        assertThat(theme.getId()).isEqualTo(newId);
    }

    @Test
    @DisplayName(" nominal case: get and set certification")
    public void getCertificationAndSetCertification_NominalCase() {
        CertificationEntity newCertification = new CertificationEntity();
        theme.setCertification(newCertification);
        assertThat(theme.getCertification()).isEqualTo(newCertification);
    }

    @Test
    @DisplayName(" nominal case: get and set code")
    public void getCodeAndSetCode_NominalCase() {
        String newCode = "newTestCode";
        theme.setCode(newCode);
        assertThat(theme.getCode()).isEqualTo(newCode);
    }

    @Test
    @DisplayName(" nominal case: get and set label")
    public void getLabelAndGetSetLabel_NominalCase() {
        String newLabel = "newTestLabel";
        theme.setLabel(newLabel);
        assertThat(theme.getLabel()).isEqualTo(newLabel);
    }

    @Test
    @DisplayName(" nominal case: get and set question count")
    public void getQuestionCountAndSetQuestionCount_NominalCase() {
        int newQuestionCount = 20;
        theme.setQuestionCount(newQuestionCount);
        assertThat(theme.getQuestionCount()).isEqualTo(newQuestionCount);
    }

    @Test
    @DisplayName(" nominal case: get and set weight percent")
    public void getWeightPercentAndSetWeightPercent_NominalCase() {
        Double newWeightPercent = 75.0;
        theme.setWeightPercent(newWeightPercent);
        assertThat(theme.getWeightPercent()).isEqualTo(newWeightPercent);
    }

    @Test
    @DisplayName(" nominal case: get and set display order")
    public void getDisplayOrderAndSetDisplayOrder_NominalCase() {
        int newDisplayOrder = 2;
        theme.setDisplayOrder(newDisplayOrder);
        assertThat(theme.getDisplayOrder()).isEqualTo(newDisplayOrder);
    }

    @Test
    @DisplayName(" edge case: get created at on creation")
    public void getCreatedAt_OnCreation() {
        OffsetDateTime createdAt = theme.getCreatedAt();
        assertThat(createdAt).isNotNull();
    }

    @Test
    @DisplayName(" error case: null certification should throw exception")
    public void setCertification_Null_ShouldThrowException() {
        assertThrows(IllegalArgumentException.class, () -> theme.setCertification(null));
    }

    @Test
    @DisplayName(" error case: null code should throw exception")
    public void setCode_Null_ShouldThrowException() {
        assertThrows(IllegalArgumentException.class, () -> theme.setCode(null));
    }

    @Test
    @DisplayName(" error case: null label should throw exception")
    public void setLabel_Null_ShouldThrowException() {
        assertThrows(IllegalArgumentException.class, () -> theme.setLabel(null));
    }
}