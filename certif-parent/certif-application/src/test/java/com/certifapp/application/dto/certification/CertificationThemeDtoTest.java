// certif-application/src/test/java/com/certifapp/application/dto/certification/CertificationThemeDtoTest.java
package com.certifapp.application.dto.certification;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("CertificationThemeDtoTest")
class CertificationThemeDtoTest {

    private final CertificationThemeDto dto = new CertificationThemeDto(java.util.UUID.randomUUID(),"oop","OOP",50,1);

    @Test @DisplayName("label() returns expected")
    void label_expected() { assertThat(dto.label()).isEqualTo("OOP"); }
    @Test @DisplayName("questionCount() returns expected")
    void questionCount_expected() { assertThat(dto.questionCount()).isEqualTo(50); }

    @Test @DisplayName("record equality holds")
    void equality_holds() { assertThat(dto).isEqualTo(new CertificationThemeDto(java.util.UUID.randomUUID(),"oop","OOP",50,1)); }
}
