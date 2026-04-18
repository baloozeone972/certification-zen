// certif-application/src/test/java/com/certifapp/application/dto/user/UserPreferencesDtoTest.java
package com.certifapp.application.dto.user;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("UserPreferencesDtoTest")
class UserPreferencesDtoTest {

    private final UserPreferencesDto dto = new UserPreferencesDto(java.util.UUID.randomUUID(),"light","fr","EXAM",true,null);

    @Test @DisplayName("theme() returns expected")
    void theme_expected() { assertThat(dto.theme()).isEqualTo("light"); }
    @Test @DisplayName("language() returns expected")
    void language_expected() { assertThat(dto.language()).isEqualTo("fr"); }

    @Test @DisplayName("record equality holds")
    void equality_holds() { assertThat(dto).isEqualTo(new UserPreferencesDto(java.util.UUID.randomUUID(),"light","fr","EXAM",true,null)); }
}
