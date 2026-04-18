// certif-application/src/test/java/com/certifapp/application/dto/certification/CertificationSummaryDtoTest.java
package com.certifapp.application.dto.certification;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("CertificationSummaryDtoTest")
class CertificationSummaryDtoTest {

    private final CertificationSummaryDto dto = new CertificationSummaryDto("aws_saa","SAA-C03","AWS SAA","Desc.",500,68,"MCQ");

    @Test @DisplayName("id() returns expected")
    void id_expected() { assertThat(dto.id()).isEqualTo("aws_saa"); }
    @Test @DisplayName("passingScore() returns expected")
    void passingScore_expected() { assertThat(dto.passingScore()).isEqualTo(68); }

    @Test @DisplayName("record equality holds")
    void equality_holds() { assertThat(dto).isEqualTo(new CertificationSummaryDto("aws_saa","SAA-C03","AWS SAA","Desc.",500,68,"MCQ")); }
}
