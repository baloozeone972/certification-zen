package com.certifapp.domain.model.user;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

public class UserRoleTest {

    @Test
    @DisplayName("UserRole_ADMIN_getGrantedAuthority_shouldReturnROLE_ADMIN")
    public void admin_getGrantedAuthority_shouldReturnROLE_ADMIN() {
        assertThat(UserRole.ADMIN.getGrantedAuthority()).isEqualTo("ROLE_ADMIN");
    }

    @Test
    @DisplayName("UserRole_USER_getGrantedAuthority_shouldReturnROLE_USER")
    public void user_getGrantedAuthority_shouldReturnROLE_USER() {
        assertThat(UserRole.USER.getGrantedAuthority()).isEqualTo("ROLE_USER");
    }

    @Test
    @DisplayName("UserRole_PARTNER_getGrantedAuthority_shouldReturnROLE_PARTNER")
    public void partner_getGrantedAuthority_shouldReturnROLE_PARTNER() {
        assertThat(UserRole.PARTNER.getGrantedAuthority()).isEqualTo("ROLE_PARTNER");
    }

    @Test
    @DisplayName("UserRole_fromString_validRoleString_shouldReturnUserRole")
    public void fromString_validRoleString_shouldReturnUserRole() {
        UserRole role = UserRole.fromString("ADMIN");
        assertThat(role).isEqualTo(UserRole.ADMIN);
    }

    @Test
    @DisplayName("UserRole_fromString_invalidRoleString_shouldThrowIllegalArgumentException")
    public void fromString_invalidRoleString_shouldThrowIllegalArgumentException() {
        assertThatThrownBy(() -> UserRole.fromString("INVALID_ROLE"))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("Invalid role: INVALID_ROLE");
    }
}