// certif-application/src/test/java/com/certifapp/application/dto/coaching/JobMarketDtoTest.java
package com.certifapp.application.dto.coaching;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("JobMarketDtoTest")
class JobMarketDtoTest {

    private final JobMarketDto dto = new JobMarketDto("ocp21","FR",1500,95000.0,"Junior Java");

    @Test @DisplayName("certificationId() returns expected")
    void certificationId_expected() { assertThat(dto.certificationId()).isEqualTo("ocp21"); }
    @Test @DisplayName("country() returns expected")
    void country_expected() { assertThat(dto.country()).isEqualTo("FR"); }

    @Test @DisplayName("record equality holds")
    void equality_holds() { assertThat(dto).isEqualTo(new JobMarketDto("ocp21","FR",1500,95000.0,"Junior Java")); }
}
