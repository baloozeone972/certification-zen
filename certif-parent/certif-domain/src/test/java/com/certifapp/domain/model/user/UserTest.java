package com.certifapp.domain.model.user;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import org.assertj.core.api.Assertions;

import java.time.OffsetDateTime;
import java.util.UUID;

import static org.mockito.Mockito.*;
import static org.assertj.core.api.Assertions.assertThat;

@ExtendWith(MockitoExtension.class)
public class UserTest {

    @Mock
    private SubscriptionTier subscriptionTier;

    @InjectMocks
    private User user;

    @BeforeEach
    public void setUp() {
        UUID id = UUID.randomUUID();
        String email = "test@example.com";
        String passwordHash = "passwordHash";
        UserRole role = UserRole.BASIC;
        String locale = User.DEFAULT_LOCALE;
        String timezone = User.DEFAULT_TIMEZONE;
        String stripeCustomerId = null;
        boolean isActive = true;
        OffsetDateTime createdAt = OffsetDateTime.now();
        OffsetDateTime updatedAt = OffsetDateTime.now();

        user = new User(id, email, passwordHash, role, subscriptionTier, locale, timezone, stripeCustomerId, isActive, createdAt, updatedAt);
    }

    @Test
    @DisplayName("should have AI access for PRO subscription")
    public void hasAiAccess_proSubscription_true() {
        when(subscriptionTier.hasAiFeatures()).thenReturn(true);

        boolean result = user.hasAiAccess();

        assertThat(result).isTrue();
        verify(subscriptionTier, times(1)).hasAiFeatures();
    }

    @Test
    @DisplayName("should not have AI access for BASIC subscription")
    public void hasAiAccess_basicSubscription_false() {
        when(subscriptionTier.hasAiFeatures()).thenReturn(false);

        boolean result = user.hasAiAccess();

        assertThat(result).isFalse();
        verify(subscriptionTier, times(1)).hasAiFeatures();
    }

    @Test
    @DisplayName("should have unlimited access for PRO and PACK subscriptions")
    public void hasUnlimitedAccess_proAndPackSubscriptions_true() {
        when(subscriptionTier.isUnlimited()).thenReturn(true);

        boolean result = user.hasUnlimitedAccess();

        assertThat(result).isTrue();
        verify(subscriptionTier, times(1)).isUnlimited();
    }

    @Test
    @DisplayName("should not have unlimited access for other subscriptions")
    public void hasUnlimitedAccess_otherSubscriptions_false() {
        when(subscriptionTier.isUnlimited()).thenReturn(false);

        boolean result = user.hasUnlimitedAccess();

        assertThat(result).isFalse();
        verify(subscriptionTier, times(1)).isUnlimited();
    }
}
