// certif-application/src/test/java/com/certifapp/application/dto/exam/QuestionResultDtoTest.java
package com.certifapp.application.dto.exam;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("QuestionResultDtoTest")
class QuestionResultDtoTest {

    private final QuestionResultDto dto = new QuestionResultDto(java.util.UUID.randomUUID(),java.util.UUID.randomUUID(),true,"Correct!",java.util.List.of());

    @Test @DisplayName("correct() returns expected")
    void correct_expected() { assertThat(dto.correct()).isTrue(); }
    @Test @DisplayName("explanation() returns expected")
    void explanation_expected() { assertThat(dto.explanation()).isEqualTo("Correct!"); }

    @Test @DisplayName("record equality holds")
    void equality_holds() { assertThat(dto).isEqualTo(new QuestionResultDto(java.util.UUID.randomUUID(),java.util.UUID.randomUUID(),true,"Correct!",java.util.List.of())); }
}
