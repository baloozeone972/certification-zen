// certif-application/src/test/java/com/certifapp/application/dto/learning/CourseDtoTest.java
package com.certifapp.application.dto.learning;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("CourseDtoTest")
class CourseDtoTest {

    private final CourseDto dto = new CourseDto(java.util.UUID.randomUUID(),"ocp21","oop","OOP","Content",java.util.List.of());

    @Test @DisplayName("certificationId() returns expected")
    void certificationId_expected() { assertThat(dto.certificationId()).isEqualTo("ocp21"); }
    @Test @DisplayName("themeCode() returns expected")
    void themeCode_expected() { assertThat(dto.themeCode()).isEqualTo("oop"); }

    @Test @DisplayName("record equality holds")
    void equality_holds() { assertThat(dto).isEqualTo(new CourseDto(java.util.UUID.randomUUID(),"ocp21","oop","OOP","Content",java.util.List.of())); }
}
