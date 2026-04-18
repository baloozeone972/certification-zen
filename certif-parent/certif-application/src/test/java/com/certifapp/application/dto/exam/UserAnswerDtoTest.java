// certif-application/src/test/java/com/certifapp/application/dto/exam/UserAnswerDtoTest.java
package com.certifapp.application.dto.exam;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("UserAnswerDtoTest")
class UserAnswerDtoTest {

    private final UserAnswerDto dto = new UserAnswerDto(java.util.UUID.randomUUID(),java.util.UUID.randomUUID(),java.util.UUID.randomUUID(),true,false,5000L);

    @Test @DisplayName("correct() returns expected")
    void correct_expected() { assertThat(dto.correct()).isTrue(); }
    @Test @DisplayName("skipped() returns expected")
    void skipped_expected() { assertThat(dto.skipped()).isFalse(); }

    @Test @DisplayName("record equality holds")
    void equality_holds() { assertThat(dto).isEqualTo(new UserAnswerDto(java.util.UUID.randomUUID(),java.util.UUID.randomUUID(),java.util.UUID.randomUUID(),true,false,5000L)); }
}
