package com.certifapp.domain.model.certification;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;

public class CertificationTest {

    @Test
    @DisplayName("passingQuestionsCount_calculatesCorrectlyForNominalCase")
    public void passingQuestionsCount_calculatesCorrectlyForNominalCase() {
        Certification certification = new Certification(
                "ocp21",
                "1Z0-830",
                "Oracle Certified Professional Java SE 21",
                "Long description...",
                80,
                40,
                90,
                68,
                "MCQ",
                List.of(),
                true
        );
        int result = certification.passingQuestionsCount();
        assertThat(result).isEqualTo(56);
    }

    @Test
    @DisplayName("passingQuestionsCount_returnsMinimumOfOne")
    public void passingQuestionsCount_returnsMinimumOfOne() {
        Certification certification = new Certification(
                "ocp21",
                "1Z0-830",
                "Oracle Certified Professional Java SE 21",
                "Long description...",
                1,
                1,
                90,
                1,
                "MCQ",
                List.of(),
                true
        );
        int result = certification.passingQuestionsCount();
        assertThat(result).isEqualTo(1);
    }

    @Test
    @DisplayName("passingQuestionsCount_returnsMaximumOfTotalQuestions")
    public void passingQuestionsCount_returnsMaximumOfTotalQuestions() {
        Certification certification = new Certification(
                "ocp21",
                "1Z0-830",
                "Oracle Certified Professional Java SE 21",
                "Long description...",
                1,
                1,
                90,
                100,
                "MCQ",
                List.of(),
                true
        );
        int result = certification.passingQuestionsCount();
        assertThat(result).isEqualTo(1);
    }

    @Test
    @DisplayName("examDurationSeconds_calculatesCorrectlyForNominalCase")
    public void examDurationSeconds_calculatesCorrectlyForNominalCase() {
        Certification certification = new Certification(
                "ocp21",
                "1Z0-830",
                "Oracle Certified Professional Java SE 21",
                "Long description...",
                80,
                40,
                90,
                68,
                "MCQ",
                List.of(),
                true
        );
        int result = certification.examDurationSeconds();
        assertThat(result).isEqualTo(5400);
    }

    @Test
    @DisplayName("findTheme_returnsMatchingThemeIfFound")
    public void findTheme_returnsMatchingThemeIfFound() {
        Certification certification = new Certification(
                "ocp21",
                "1Z0-830",
                "Oracle Certified Professional Java SE 21",
                "Long description...",
                80,
                40,
                90,
                68,
                "MCQ",
                List.of(),
                true
        );
        CertificationTheme theme = new CertificationTheme("virtual_threads", "Virtual Threads");
        certification.addTheme(theme);
        CertificationTheme foundTheme = certification.findTheme("virtual_threads");
        assertThat(foundTheme).isEqualTo(theme);
    }

    @Test
    @DisplayName("findTheme_returnsNullIfNotFound")
    public void findTheme_returnsNullIfNotFound() {
        Certification certification = new Certification(
                "ocp21",
                "1Z0-830",
                "Oracle Certified Professional Java SE 21",
                "Long description...",
                80,
                40,
                90,
                68,
                "MCQ",
                List.of(),
                true
        );
        CertificationTheme foundTheme = certification.findTheme("non_existent_theme");
        assertThat(foundTheme).isNull();
    }

    @Test
    @DisplayName("constructor_throwsIllegalArgumentExceptionForBlankId")
    public void constructor_throwsIllegalArgumentExceptionForBlankId() {
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> {
            new Certification(
                    "",
                    "1Z0-830",
                    "Oracle Certified Professional Java SE 21",
                    "Long description...",
                    80,
                    40,
                    90,
                    68,
                    "MCQ",
                    List.of(),
                    true
            );
        });
        assertThat(exception.getMessage()).isEqualTo("id must not be blank");
    }

    @Test
    @DisplayName("constructor_throwsIllegalArgumentExceptionForBlankCode")
    public void constructor_throwsIllegalArgumentExceptionForBlankCode() {
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> {
            new Certification(
                    "ocp21",
                    "",
                    "Oracle Certified Professional Java SE 21",
                    "Long description...",
                    80,
                    40,
                    90,
                    68,
                    "MCQ",
                    List.of(),
                    true
            );
        });
        assertThat(exception.getMessage()).isEqualTo("code must not be blank");
    }

    @Test
    @DisplayName("constructor_throwsIllegalArgumentExceptionForNonPositiveExamQuestionCount")
    public void constructor_throwsIllegalArgumentExceptionForNonPositiveExamQuestionCount() {
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> {
            new Certification(
                    "ocp21",
                    "1Z0-830",
                    "Oracle Certified Professional Java SE 21",
                    "Long description...",
                    80,
                    -1,
                    90,
                    68,
                    "MCQ",
                    List.of(),
                    true
            );
        });
        assertThat(exception.getMessage()).isEqualTo("examQuestionCount must be > 0, got: -1");
    }

    @Test
    @DisplayName("constructor_throwsIllegalArgumentExceptionForNonPositiveExamDurationMin")
    public void constructor_throwsIllegalArgumentExceptionForNonPositiveExamDurationMin() {
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> {
            new Certification(
                    "ocp21",
                    "1Z0-830",
                    "Oracle Certified Professional Java SE 21",
                    "Long description...",
                    80,
                    40,
                    -1,
                    68,
                    "MCQ",
                    List.of(),
                    true
            );
        });
        assertThat(exception.getMessage()).isEqualTo("examDurationMin must be > 0, got: -1");
    }

    @Test
    @DisplayName("constructor_throwsIllegalArgumentExceptionForPassingScoreOutOfRange")
    public void constructor_throwsIllegalArgumentExceptionForPassingScoreOutOfRange() {
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> {
            new Certification(
                    "ocp21",
                    "1Z0-830",
                    "Oracle Certified Professional Java SE 21",
                    "Long description...",
                    80,
                    40,
                    90,
                    150,
                    "MCQ",
                    List.of(),
                    true
            );
        });
        assertThat(exception.getMessage()).isEqualTo("passingScore must be between 1 and 100, got: 150");
    }
}