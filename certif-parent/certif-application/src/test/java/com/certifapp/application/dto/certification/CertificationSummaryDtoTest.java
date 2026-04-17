package com.certifapp.application.dto.certification;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("CertificationSummaryDto Tests")
public class CertificationSummaryDtoTest {

    @Mock
    private CertificationService certificationService;

    @InjectMocks
    private CertificationSummaryDto certificationSummaryDto;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @DisplayName("Create a valid CertificationSummaryDto with nominal case")
    @Test
    public void create_validCertificationSummaryDto_nominalCase() {
        String id = "ocp21";
        String code = "1Z0-830";
        String name = "Oracle Certified Professional, Java SE 11 Programmer I";
        int totalQuestions = 100;
        int passingScore = 75;
        int examDurationMin = 90;
        String examType = "MCQ";

        CertificationSummaryDto dto = new CertificationSummaryDto(id, code, name, totalQuestions, passingScore, examDurationMin, examType);

        assertThat(dto.id()).isEqualTo(id);
        assertThat(dto.code()).isEqualTo(code);
        assertThat(dto.name()).isEqualTo(name);
        assertThat(dto.totalQuestions()).isEqualTo(totalQuestions);
        assertThat(dto.passingScore()).isEqualTo(passingScore);
        assertThat(dto.examDurationMin()).isEqualTo(examDurationMin);
        assertThat(dto.examType()).isEqualTo(examType);
    }

    @DisplayName("Create a valid CertificationSummaryDto with edge cases")
    @Test
    public void create_validCertificationSummaryDto_edgeCases() {
        String id = "ocp21";
        String code = "1Z0-830";
        String name = "";
        int totalQuestions = 0;
        int passingScore = -1;
        int examDurationMin = 60;
        String examType = "";

        CertificationSummaryDto dto = new CertificationSummaryDto(id, code, name, totalQuestions, passingScore, examDurationMin, examType);

        assertThat(dto.id()).isEqualTo(id);
        assertThat(dto.code()).isEqualTo(code);
        assertThat(dto.name()).isEqualTo(name);
        assertThat(dto.totalQuestions()).isEqualTo(totalQuestions);
        assertThat(dto.passingScore()).isEqualTo(passingScore);
        assertThat(dto.examDurationMin()).isEqualTo(examDurationMin);
        assertThat(dto.examType()).isEqualTo(examType);
    }

    @DisplayName("Create a valid CertificationSummaryDto with error cases")
    @Test
    public void create_validCertificationSummaryDto_errorCases() {
        String id = null;
        String code = null;
        String name = "Oracle Certified Professional, Java SE 11 Programmer I";
        int totalQuestions = -50;
        int passingScore = 101;
        int examDurationMin = -10;
        String examType = "INVALID";

        CertificationSummaryDto dto = new CertificationSummaryDto(id, code, name, totalQuestions, passingScore, examDurationMin, examType);

        assertThat(dto.id()).isEqualTo(id);
        assertThat(dto.code()).isEqualTo(code);
        assertThat(dto.name()).isEqualTo(name);
        assertThat(dto.totalQuestions()).isEqualTo(totalQuestions);
        assertThat(dto.passingScore()).isEqualTo(passingScore);
        assertThat(dto.examDurationMin()).isEqualTo(examDurationMin);
        assertThat(dto.examType()).isEqualTo(examType);
    }
}