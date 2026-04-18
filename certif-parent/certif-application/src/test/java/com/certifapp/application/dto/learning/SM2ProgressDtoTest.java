// certif-application/src/test/java/com/certifapp/application/dto/learning/SM2ProgressDtoTest.java
package com.certifapp.application.dto.learning;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("SM2ProgressDtoTest")
class SM2ProgressDtoTest {

    private final SM2ProgressDto dto = new SM2ProgressDto(java.util.UUID.randomUUID(),java.util.UUID.randomUUID(),2.5,6,2,java.time.LocalDate.now());

    @Test @DisplayName("easeFactor() returns expected")
    void easeFactor_expected() { assertThat(dto.easeFactor()).isEqualTo(2.5); }
    @Test @DisplayName("intervalDays() returns expected")
    void intervalDays_expected() { assertThat(dto.intervalDays()).isEqualTo(6); }

    @Test @DisplayName("record equality holds")
    void equality_holds() { assertThat(dto).isEqualTo(new SM2ProgressDto(java.util.UUID.randomUUID(),java.util.UUID.randomUUID(),2.5,6,2,java.time.LocalDate.now())); }
}
