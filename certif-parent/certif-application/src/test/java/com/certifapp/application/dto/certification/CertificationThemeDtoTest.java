package com.certifapp.application.dto.certification;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.assertj.core.api.Assertions.assertThat;

@ExtendWith(MockitoExtension.class)
public class CertificationThemeDtoTest {

    @InjectMocks
    private CertificationThemeDto certificationThemeDto;

    @BeforeEach
    public void setUp() {
        certificationThemeDto = new CertificationThemeDto(
                UUID.randomUUID(),
                "virtual_threads",
                "Virtual Threads",
                10,
                25.0
        );
    }

    @Test
    @DisplayName("should return the correct id")
    public void getId_correctIdReturned() {
        assertThat(certificationThemeDto.id()).isEqualTo(UUID.randomUUID());
    }

    @Test
    @DisplayName("should return the correct code")
    public void getCode_correctCodeReturned() {
        assertThat(certificationThemeDto.code()).isEqualTo("virtual_threads");
    }

    @Test
    @DisplayName("should return the correct label")
    public void getLabel_correctLabelReturned() {
        assertThat(certificationThemeDto.label()).isEqualTo("Virtual Threads");
    }

    @Test
    @DisplayName("should return the correct questionCount")
    public void getQuestionCount_correctQuestionCountReturned() {
        assertThat(certificationThemeDto.questionCount()).isEqualTo(10);
    }

    @Test
    @DisplayName("should return the correct weightPercent")
    public void getWeightPercent_correctWeightPercentReturned() {
        assertThat(certificationThemeDto.weightPercent()).isEqualTo(25.0);
    }
}

