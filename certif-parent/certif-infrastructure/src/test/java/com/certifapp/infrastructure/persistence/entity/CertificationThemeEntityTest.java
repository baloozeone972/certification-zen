package com.certifapp.infrastructure.persistence.entity;

import java.util.UUID;
import org.junit.jupiter.api.extension.ExtendWith;

import org.junit.jupiter.api.*;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class CertificationThemeEntityTest {

    @Mock
    private CertificationEntity certification;

    @InjectMocks
    private CertificationThemeEntity theme;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
        theme.setId(UUID.randomUUID());
        theme.setCertification(certification);
        theme.setCode("testCode");
        theme.setLabel("testLabel");
        theme.setQuestionCount(10);
        theme.setWeightPercent(50.0);
        theme.setDisplayOrder(1);
    }

    @AfterEach
    public void tearDown() {
        verifyNoMoreInteractions(certification);
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
        IllegalArgumentException thrown = assertThatThrownBy(() -> theme.setCertification(null))
                .isInstanceOf(IllegalArgumentException.class)
                .withMessageContaining("certification");
        assertThat(thrown).hasNoCause();
    }

    @Test
    @DisplayName(" error case: null code should throw exception")
    public void setCode_Null_ShouldThrowException() {
        IllegalArgumentException thrown = assertThatThrownBy(() -> theme.setCode(null))
                .isInstanceOf(IllegalArgumentException.class)
                .withMessageContaining("code");
        assertThat(thrown).hasNoCause();
    }

    @Test
    @DisplayName(" error case: null label should throw exception")
    public void setLabel_Null_ShouldThrowException() {
        IllegalArgumentException thrown = assertThatThrownBy(() -> theme.setLabel(null))
                .isInstanceOf(IllegalArgumentException.class)
                .withMessageContaining("label");
    }
}
