package com.certifapp.application.dto.certification;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class CertificationDetailDtoTest {

    @InjectMocks
    private CertificationDetailDto certificationDetailDto;

    @BeforeEach
    void setUp() {
        certificationDetailDto = new CertificationDetailDto(
            "id123",
            "CITP",
            "Certified IT Professional",
            "A comprehensive certification for IT professionals.",
            100,
            25,
            75,
            90,
            "MCQ",
            List.of()
        );
    }

    @Test
    @DisplayName("Should return correct id")
    void getId_IdProvided_ReturnsId() {
        assertThat(certificationDetailDto.id()).isEqualTo("id123");
    }

    @Test
    @DisplayName("Should return correct code")
    void getCode_CodeProvided_ReturnsCode() {
        assertThat(certificationDetailDto.code()).isEqualTo("CITP");
    }

    @Test
    @DisplayName("Should return correct name")
    void getName_NameProvided_ReturnsName() {
        assertThat(certificationDetailDto.name()).isEqualTo("Certified IT Professional");
    }

    @Test
    @DisplayName("Should return correct description")
    void getDescription_DescriptionProvided_ReturnsDescription() {
        assertThat(certificationDetailDto.description()).isEqualTo("A comprehensive certification for IT professionals.");
    }

    @Test
    @DisplayName("Should return correct totalQuestions")
    void getTotalQuestions_TotalQuestionsProvided_ReturnsTotalQuestions() {
        assertThat(certificationDetailDto.totalQuestions()).isEqualTo(100);
    }

    @Test
    @DisplayName("Should return correct examQuestionCount")
    void getExamQuestionCount_ExamQuestionCountProvided_ReturnsExamQuestionCount() {
        assertThat(certificationDetailDto.examQuestionCount()).isEqualTo(25);
    }

    @Test
    @DisplayName("Should return correct passingScore")
    void getPassingScore_PassingScoreProvided_ReturnsPassingScore() {
        assertThat(certificationDetailDto.passingScore()).isEqualTo(75);
    }

    @Test
    @DisplayName("Should return correct examDurationMin")
    void getExamDurationMin_ExamDurationMinProvided_ReturnsExamDurationMin() {
        assertThat(certificationDetailDto.examDurationMin()).isEqualTo(90);
    }

    @Test
    @DisplayName("Should return correct examType")
    void getExamType_ExamTypeProvided_ReturnsExamType() {
        assertThat(certificationDetailDto.examType()).isEqualTo("MCQ");
    }

    @Test
    @DisplayName("Should return correct themes")
    void getThemes_ThemesProvided_ReturnsThemes() {
        assertThat(certificationDetailDto.themes()).isEmpty();
    }
}
