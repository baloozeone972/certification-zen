// certif-application/src/test/java/com/certifapp/application/dto/exam/QuestionDtoTest.java
package com.certifapp.application.dto.exam;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("QuestionDtoTest")
class QuestionDtoTest {

    private final QuestionDto dto = new QuestionDto(java.util.UUID.randomUUID(),"ocp21","oop","What is a Record?",java.util.List.of(),"Explanation","EASY","SINGLE_CHOICE",java.util.List.of(),null);

    @Test @DisplayName("certificationId() returns expected")
    void certificationId_expected() { assertThat(dto.certificationId()).isEqualTo("ocp21"); }
    @Test @DisplayName("statement() returns expected")
    void statement_expected() { assertThat(dto.statement()).isEqualTo("What is a Record?"); }

    @Test @DisplayName("record equality holds")
    void equality_holds() { assertThat(dto).isEqualTo(new QuestionDto(java.util.UUID.randomUUID(),"ocp21","oop","What is a Record?",java.util.List.of(),"Explanation","EASY","SINGLE_CHOICE",java.util.List.of(),null)); }
}
