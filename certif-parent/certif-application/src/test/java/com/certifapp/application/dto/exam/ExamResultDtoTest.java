// certif-application/src/test/java/com/certifapp/application/dto/exam/ExamResultDtoTest.java
package com.certifapp.application.dto.exam;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("ExamResultDtoTest")
class ExamResultDtoTest {

    private final ExamResultDto dto = new ExamResultDto(java.util.UUID.randomUUID(),java.util.UUID.randomUUID(),"ocp21","EXAM","COMPLETED",75.0,true,java.util.List.of(),java.util.List.of());

    @Test @DisplayName("score() returns expected")
    void score_expected() { assertThat(dto.score()).isEqualTo(75.0); }
    @Test @DisplayName("passed() returns expected")
    void passed_expected() { assertThat(dto.passed()).isTrue(); }

    @Test @DisplayName("record equality holds")
    void equality_holds() { assertThat(dto).isEqualTo(new ExamResultDto(java.util.UUID.randomUUID(),java.util.UUID.randomUUID(),"ocp21","EXAM","COMPLETED",75.0,true,java.util.List.of(),java.util.List.of())); }
}
