// certif-application/src/test/java/com/certifapp/application/dto/certification/CertificationDetailDtoTest.java
package com.certifapp.application.dto.certification;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("CertificationDetailDtoTest")
class CertificationDetailDtoTest {

    private final CertificationDetailDto dto = new CertificationDetailDto("ocp21","1Z0-830","OCP Java 21","Desc.",500,80,68,180,"MCQ",java.util.List.of());

    @Test @DisplayName("id() returns expected")
    void id_expected() { assertThat(dto.id()).isEqualTo("ocp21"); }
    @Test @DisplayName("code() returns expected")
    void code_expected() { assertThat(dto.code()).isEqualTo("1Z0-830"); }
    @Test @DisplayName("name() returns expected")
    void name_expected() { assertThat(dto.name()).isEqualTo("OCP Java 21"); }
    @Test @DisplayName("totalQuestions() returns expected")
    void totalQuestions_expected() { assertThat(dto.totalQuestions()).isEqualTo(500); }

    @Test @DisplayName("record equality holds")
    void equality_holds() { assertThat(dto).isEqualTo(new CertificationDetailDto("ocp21","1Z0-830","OCP Java 21","Desc.",500,80,68,180,"MCQ",java.util.List.of())); }
}
