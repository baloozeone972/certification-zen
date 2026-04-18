// certif-application/src/test/java/com/certifapp/application/dto/user/UserDtoTest.java
package com.certifapp.application.dto.user;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("UserDtoTest")
class UserDtoTest {

    private final UserDto dto = new UserDto(java.util.UUID.randomUUID(),"u@test.com","USER","FREE","fr","Europe/Paris",null,true);

    @Test @DisplayName("email() returns expected")
    void email_expected() { assertThat(dto.email()).isEqualTo("u@test.com"); }
    @Test @DisplayName("subscriptionTier() returns expected")
    void subscriptionTier_expected() { assertThat(dto.subscriptionTier()).isEqualTo("FREE"); }

    @Test @DisplayName("record equality holds")
    void equality_holds() { assertThat(dto).isEqualTo(new UserDto(java.util.UUID.randomUUID(),"u@test.com","USER","FREE","fr","Europe/Paris",null,true)); }
}
