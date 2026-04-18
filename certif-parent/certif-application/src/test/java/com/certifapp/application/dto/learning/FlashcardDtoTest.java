// certif-application/src/test/java/com/certifapp/application/dto/learning/FlashcardDtoTest.java
package com.certifapp.application.dto.learning;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("FlashcardDtoTest")
class FlashcardDtoTest {

    private final FlashcardDto dto = new FlashcardDto(java.util.UUID.randomUUID(),"ocp21","oop","Front text","Back text",null,2.5,1,1,java.time.LocalDate.now());

    @Test @DisplayName("certificationId() returns expected")
    void certificationId_expected() { assertThat(dto.certificationId()).isEqualTo("ocp21"); }
    @Test @DisplayName("frontText() returns expected")
    void frontText_expected() { assertThat(dto.frontText()).isEqualTo("Front text"); }

    @Test @DisplayName("record equality holds")
    void equality_holds() { assertThat(dto).isEqualTo(new FlashcardDto(java.util.UUID.randomUUID(),"ocp21","oop","Front text","Back text",null,2.5,1,1,java.time.LocalDate.now())); }
}
