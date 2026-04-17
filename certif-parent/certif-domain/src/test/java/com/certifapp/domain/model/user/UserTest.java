package com.certifapp.domain.model.user;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.time.OffsetDateTime;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;

public class UserTest {

    private User user;
    private SubscriptionTier subscriptionTier;

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

        subscriptionTier = new SubscriptionTier(false, false);
        user = new User(id, email, passwordHash, role, subscriptionTier, locale, timezone, stripeCustomerId, isActive, createdAt, updatedAt);
    }

    @Test
    @DisplayName("should have AI access for PRO subscription")
    public void hasAiAccess_proSubscription_true() {
        user.setRole(UserRole.PRO);
        subscriptionTier = new SubscriptionTier(true, false);
        user.setSubscriptionTier(subscriptionTier);

        boolean result = user.hasAiAccess();

        assertThat(result).isTrue();
    }

    @Test
    @DisplayName("should not have AI access for BASIC subscription")
    public void hasAiAccess_basicSubscription_false() {
        boolean result = user.hasAiAccess();

        assertThat(result).isFalse();
    }

    @Test
    @DisplayName("should have unlimited access for PRO and PACK subscriptions")
    public void hasUnlimitedAccess_proAndPackSubscriptions_true() {
        user.setRole(UserRole.PRO);
        subscriptionTier = new SubscriptionTier(false, true);
        user.setSubscriptionTier(subscriptionTier);

        boolean result = user.hasUnlimitedAccess();

        assertThat(result).isTrue();
    }

    @Test
    @DisplayName("should not have unlimited access for other subscriptions")
    public void hasUnlimitedAccess_otherSubscriptions_false() {
        boolean result = user.hasUnlimitedAccess();

        assertThat(result).isFalse();
    }
}