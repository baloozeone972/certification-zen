package com.certifapp.domain.model.user;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class SubscriptionTierTest {

    @DisplayName("isUnlimited should return true for PRO and PACK")
    @Test
    public void isUnlimited_PRO_and_PACK_return_true() {
        assertThat(SubscriptionTier.PRO.isUnlimited()).isTrue();
        assertThat(SubscriptionTier.PACK.isUnlimited()).isTrue();
    }

    @DisplayName("isUnlimited should return false for FREE")
    @Test
    public void isUnlimited_FREE_return_false() {
        assertThat(SubscriptionTier.FREE.isUnlimited()).isFalse();
    }

    @DisplayName("hasAiFeatures should return true only for PRO")
    @Test
    public void hasAiFeatures_only_PRO_returns_true() {
        assertThat(SubscriptionTier.PRO.hasAiFeatures()).isTrue();
    }

    @DisplayName("hasAiFeatures should return false for FREE and PACK")
    @Test
    public void hasAiFeatures_FREE_and_PACK_return_false() {
        assertThat(SubscriptionTier.FREE.hasAiFeatures()).isFalse();
        assertThat(SubscriptionTier.PACK.hasAiFeatures()).isFalse();
    }
}