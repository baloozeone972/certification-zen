```java
package com.certifapp.domain.model.question;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;
import static com.certifapp.domain.model.question.ExplanationStatus.*;

@ExtendWith(MockitoExtension.class)
public class ExplanationStatusTest {

    @BeforeEach
    void setUp() {
        // No setup needed for this test class
    }

    @Test
    @DisplayName("isValidated returns true for HUMAN_VALIDATED")
    public void isValidated_HumanValidated_ReturnsTrue() {
        assertThat(HUMAN_VALIDATED.isValidated()).isTrue();
    }

    @Test
    @DisplayName("isValidated returns false for ORIGINAL and AI_DRAFT")
    public void isValidated_OriginalAndAiDraft_ReturnsFalse() {
        assertThat(ORIGINAL.isValidated()).isFalse();
        assertThat(AI_DRAFT.isValidated()).isFalse();
    }

    @Test
    @DisplayName("isAiGenerated returns true for AI_DRAFT")
    public void isAiGenerated_AiDraft_ReturnsTrue() {
        assertThat(AI_DRAFT.isAiGenerated()).isTrue();
    }

    @Test
    @DisplayName("isAiGenerated returns false for ORIGINAL and HUMAN_VALIDATED")
    public void isAiGenerated_OriginalAndHumanValidated_ReturnsFalse() {
        assertThat(ORIGINAL.isAiGenerated()).isFalse();
        assertThat(HUMAN_VALIDATED.isAiGenerated()).isFalse();
    }
}
```
