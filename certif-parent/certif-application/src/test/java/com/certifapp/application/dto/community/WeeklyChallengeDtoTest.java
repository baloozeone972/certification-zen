// certif-application/src/test/java/com/certifapp/application/dto/community/WeeklyChallengeDtoTest.java
package com.certifapp.application.dto.community;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("WeeklyChallengeDtoTest")
class WeeklyChallengeDtoTest {

    private final WeeklyChallengeDto dto = new WeeklyChallengeDto(java.util.UUID.randomUUID(),"ocp21","Beat the week",java.time.OffsetDateTime.now());

    @Test @DisplayName("certificationId() returns expected")
    void certificationId_expected() { assertThat(dto.certificationId()).isEqualTo("ocp21"); }
    @Test @DisplayName("title() returns expected")
    void title_expected() { assertThat(dto.title()).isEqualTo("Beat the week"); }

    @Test @DisplayName("record equality holds")
    void equality_holds() { assertThat(dto).isEqualTo(new WeeklyChallengeDto(java.util.UUID.randomUUID(),"ocp21","Beat the week",java.time.OffsetDateTime.now())); }
}
