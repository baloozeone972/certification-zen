package com.certifapp.domain.model.community;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

public class StudyGroupRoleTest {

    @DisplayName("OWNER_role_canModerate_returns_true")
    @Test
    public void OWNER_role_canModerate_returns_true() {
        assertThat(StudyGroupRole.OWNER.canModerate()).isTrue();
    }

    @DisplayName("MODERATOR_role_canModerate_returns_true")
    @Test
    public void MODERATOR_role_canModerate_returns_true() {
        assertThat(StudyGroupRole.MODERATOR.canModerate()).isTrue();
    }

    @DisplayName("MEMBER_role_canModerate_returns_false")
    @Test
    public void MEMBER_role_canModerate_returns_false() {
        assertThat(StudyGroupRole.MEMBER.canModerate()).isFalse();
    }
}