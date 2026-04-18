// certif-application/src/test/java/com/certifapp/application/dto/user/TokenPairDtoTest.java
package com.certifapp.application.dto.user;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("TokenPairDtoTest")
class TokenPairDtoTest {

    private final TokenPairDto dto = new TokenPairDto("access-token","refresh-token",3600);

    @Test @DisplayName("accessToken() returns expected")
    void accessToken_expected() { assertThat(dto.accessToken()).isEqualTo("access-token"); }
    @Test @DisplayName("expiresIn() returns expected")
    void expiresIn_expected() { assertThat(dto.expiresIn()).isEqualTo(3600); }

    @Test @DisplayName("record equality holds")
    void equality_holds() { assertThat(dto).isEqualTo(new TokenPairDto("access-token","refresh-token",3600)); }
}
