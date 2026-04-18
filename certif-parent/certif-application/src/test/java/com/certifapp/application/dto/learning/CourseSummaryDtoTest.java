// certif-application/src/test/java/com/certifapp/application/dto/learning/CourseSummaryDtoTest.java
package com.certifapp.application.dto.learning;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("CourseSummaryDtoTest")
class CourseSummaryDtoTest {

    private final CourseSummaryDto dto = new CourseSummaryDto(java.util.UUID.randomUUID(),"ocp21","oop","OOP",5);

    @Test @DisplayName("certificationId() returns expected")
    void certificationId_expected() { assertThat(dto.certificationId()).isEqualTo("ocp21"); }
    @Test @DisplayName("sectionCount() returns expected")
    void sectionCount_expected() { assertThat(dto.sectionCount()).isEqualTo(5); }

    @Test @DisplayName("record equality holds")
    void equality_holds() { assertThat(dto).isEqualTo(new CourseSummaryDto(java.util.UUID.randomUUID(),"ocp21","oop","OOP",5)); }
}
