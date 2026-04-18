// certif-application/src/test/java/com/certifapp/application/dto/community/LeaderboardEntryDtoTest.java
package com.certifapp.application.dto.community;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("LeaderboardEntryDtoTest")
class LeaderboardEntryDtoTest {

    private final LeaderboardEntryDto dto = new LeaderboardEntryDto(java.util.UUID.randomUUID(),1,"Alice",85.0,10);

    @Test @DisplayName("rank() returns expected")
    void rank_expected() { assertThat(dto.rank()).isEqualTo(1); }
    @Test @DisplayName("displayName() returns expected")
    void displayName_expected() { assertThat(dto.displayName()).isEqualTo("Alice"); }

    @Test @DisplayName("record equality holds")
    void equality_holds() { assertThat(dto).isEqualTo(new LeaderboardEntryDto(java.util.UUID.randomUUID(),1,"Alice",85.0,10)); }
}
