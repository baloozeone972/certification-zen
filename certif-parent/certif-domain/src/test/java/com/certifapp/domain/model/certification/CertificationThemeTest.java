```java
package com.certifapp.domain.model.certification;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import org.assertj.core.api.Assertions;

import java.util.UUID;

import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class CertificationThemeTest {

    @InjectMocks
    private CertificationTheme certificationTheme;

    @BeforeEach
    public void setUp() {
        certificationTheme = new CertificationTheme(
                UUID.randomUUID(),
                "ocp21",
                "virtual_threads",
                "Virtual Threads",
                60,
                60.0,
                0
        );
    }

    @Test
    @DisplayName("Should create a transient theme with default values")
    public void of_stateUnderTest_expectedBehavior() {
        CertificationTheme theme = CertificationTheme.of(
                "ocp21", "virtual_threads", "Virtual Threads", 60, 0);

        Assertions.assertThat(theme.id()).isNull();
        Assertions.assertThat(theme.certificationId()).isEqualTo("ocp21");
        Assertions.assertThat(theme.code()).isEqualTo("virtual_threads");
        Assertions.assertThat(theme.label()).isEqualTo("Virtual Threads");
        Assertions.assertThat(theme.questionCount()).isEqualTo(60);
        Assertions.assertThat(theme.weightPercent()).isNull();
        Assertions.assertThat(theme.displayOrder()).isEqualTo(0);
    }

    @Test
    @DisplayName("Should throw IllegalArgumentException for blank certificationId")
    public void constructor_stateUnderTest_expectedBehavior() {
        Assertions.assertThatThrownBy(() -> new CertificationTheme(
                UUID.randomUUID(),
                "",
                "virtual_threads",
                "Virtual Threads",
                60,
                null,
                0))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("certificationId must not be blank");
    }

    @Test
    @DisplayName("Should throw IllegalArgumentException for blank code")
    public void constructor_stateUnderTest_expectedBehavior() {
        Assertions.assertThatThrownBy(() -> new CertificationTheme(
                UUID.randomUUID(),
                "ocp21",
                "",
                "Virtual Threads",
                60,
                null,
                0))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("code must not be blank");
    }

    @Test
    @DisplayName("Should throw IllegalArgumentException for blank label")
    public void constructor_stateUnderTest_expectedBehavior() {
        Assertions.assertThatThrownBy(() -> new CertificationTheme(
                UUID.randomUUID(),
                "ocp21",
                "virtual_threads",
                "",
                60,
                null,
                0))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("label must not be blank");
    }

    @Test
    @DisplayName("Should throw IllegalArgumentException for negative questionCount")
    public void constructor_stateUnderTest_expectedBehavior() {
        Assertions.assertThatThrownBy(() -> new CertificationTheme(
                UUID.randomUUID(),
                "ocp21",
                "virtual_threads",
                "Virtual Threads",
                -1,
                null,
                0))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("questionCount must be >= 0, got: -1");
    }

    @Test
    @DisplayName("Should throw IllegalArgumentException for weightPercent < 0")
    public void constructor_stateUnderTest_expectedBehavior() {
        Assertions.assertThatThrownBy(() -> new CertificationTheme(
                UUID.randomUUID(),
                "ocp21",
                "virtual_threads",
                "Virtual Threads",
                60,
                -1.0,
                0))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("weightPercent must be between 0 and 100, got: -1.0");
    }

    @Test
    @DisplayName("Should throw IllegalArgumentException for weightPercent > 100")
    public void constructor_stateUnderTest_expectedBehavior() {
        Assertions.assertThatThrownBy(() -> new CertificationTheme(
                UUID.randomUUID(),
                "ocp21",
                "virtual_threads",
                "Virtual Threads",
                60,
                101.0,
                0))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("weightPercent must be between 0 and 100, got: 101.0");
    }
}
```
