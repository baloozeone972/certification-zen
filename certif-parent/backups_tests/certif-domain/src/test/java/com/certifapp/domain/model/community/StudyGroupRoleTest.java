package com.certifapp.domain.model.community;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.assertj.core.api.Assertions.assertThat;

@ExtendWith(MockitoExtension.class)
public class StudyGroupRoleTest {

    @BeforeEach
    public void setUp() {
        // Nothing to set up for this test class
    }

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

