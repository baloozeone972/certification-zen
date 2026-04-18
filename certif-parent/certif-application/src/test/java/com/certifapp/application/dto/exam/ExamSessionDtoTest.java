// certif-application/src/test/java/com/certifapp/application/dto/exam/ExamSessionDtoTest.java
package com.certifapp.application.dto.exam;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("ExamSessionDtoTest")
class ExamSessionDtoTest {

    private final ExamSessionDto dto = new ExamSessionDto(java.util.UUID.randomUUID(),java.util.UUID.randomUUID(),"ocp21","EXAM","IN_PROGRESS",java.time.OffsetDateTime.now(),null,null,10);

    @Test @DisplayName("certificationId() returns expected")
    void certificationId_expected() { assertThat(dto.certificationId()).isEqualTo("ocp21"); }
    @Test @DisplayName("totalQuestions() returns expected")
    void totalQuestions_expected() { assertThat(dto.totalQuestions()).isEqualTo(10); }

    @Test @DisplayName("record equality holds")
    void equality_holds() { assertThat(dto).isEqualTo(new ExamSessionDto(java.util.UUID.randomUUID(),java.util.UUID.randomUUID(),"ocp21","EXAM","IN_PROGRESS",java.time.OffsetDateTime.now(),null,null,10)); }
}
