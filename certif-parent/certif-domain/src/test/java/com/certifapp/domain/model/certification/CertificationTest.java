```java
package com.certifapp.domain.model.certification;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

import java.util.Collections;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class CertificationTest {

    @Mock
    private CertificationTheme theme1;
    
    @Mock
    private CertificationTheme theme2;

    @InjectMocks
    private Certification certification;

    @BeforeEach
    public void setUp() {
        certification = new Certification(
            "ocp21",
            "1Z0-830",
            "Oracle Certified Professional Java SE 21",
            "Long description...",
            80,
            40,
            90,
            68,
            "MCQ",
            List.of(theme1, theme2),
            true
        );
    }

    @Test
    @DisplayName("passingQuestionsCount_calculatesCorrectlyForNominalCase")
    public void passingQuestionsCount_calculatesCorrectlyForNominalCase() {
        int result = certification.passingQuestionsCount();
        assertThat(result).isEqualTo(56);
    }

    @Test
    @DisplayName("passingQuestionsCount_returnsMinimumOfOne")
    public void passingQuestionsCount_returnsMinimumOfOne() {
        Certification cert = new Certification(
            "ocp21",
            "1Z0-830",
            "Oracle Certified Professional Java SE 21",
            "Long description...",
            1,
            1,
            90,
            1,
            "MCQ",
            Collections.emptyList(),
            true
        );
        int result = cert.passingQuestionsCount();
        assertThat(result).isEqualTo(1);
    }

    @Test
    @DisplayName("passingQuestionsCount_returnsMaximumOfTotalQuestions")
    public void passingQuestionsCount_returnsMaximumOfTotalQuestions() {
        Certification cert = new Certification(
            "ocp21",
            "1Z0-830",
            "Oracle Certified Professional Java SE 21",
            "Long description...",
            1,
            1,
            90,
            100,
            "MCQ",
            Collections.emptyList(),
            true
        );
        int result = cert.passingQuestionsCount();
        assertThat(result).isEqualTo(1);
    }

    @Test
    @DisplayName("examDurationSeconds_calculatesCorrectlyForNominalCase")
    public void examDurationSeconds_calculatesCorrectlyForNominalCase() {
        int result = certification.examDurationSeconds();
        assertThat(result).isEqualTo(5400);
    }

    @Test
    @DisplayName("findTheme_returnsMatchingThemeIfFound")
    public void findTheme_returnsMatchingThemeIfFound() {
        CertificationTheme foundTheme = certification.findTheme("virtual_threads");
        assertThat(foundTheme).isEqualTo(theme1);
    }

    @Test
    @DisplayName("findTheme_returnsNullIfNotFound")
    public void findTheme_returnsNullIfNotFound() {
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
                List.of(theme1, theme2),
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
                List.of(theme1, theme2),
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
                List.of(theme1, theme2),
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
                List.of(theme1, theme2),
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
                List.of(theme1, theme2),
                true
            );
        });
        assertThat(exception.getMessage()).isEqualTo("passingScore must be between 1 and 100, got: 150");
    }
}
```
