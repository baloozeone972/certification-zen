```java
package com.certifapp.application.dto.payment;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import org.assertj.core.api.Assertions;

import java.time.OffsetDateTime;

@ExtendWith(MockitoExtension.class)
public class SubscriptionStatusDtoTest {

    @InjectMocks
    private SubscriptionStatusDto subscriptionStatusDto;

    @BeforeEach
    public void setUp() {
        // Common setup if needed
    }

    @DisplayName("Nominal case: Create a FREE user")
    @Test
    public void testCreateFreeUser() {
        String tier = "FREE";
        String stripeCustomerId = null;
        OffsetDateTime currentPeriodEnd = null;
        boolean isActive = false;
        boolean cancelAtPeriodEnd = false;

        subscriptionStatusDto = new SubscriptionStatusDto(tier, stripeCustomerId, currentPeriodEnd, isActive, cancelAtPeriodEnd);

        Assertions.assertThat(subscriptionStatusDto.tier()).isEqualTo("FREE");
        Assertions.assertThat(subscriptionStatusDto.stripeCustomerId()).isNull();
        Assertions.assertThat(subscriptionStatusDto.currentPeriodEnd()).isNull();
        Assertions.assertThat(subscriptionStatusDto.isActive()).isFalse();
        Assertions.assertThat(subscriptionStatusDto.cancelAtPeriodEnd()).isFalse();
    }

    @DisplayName("Edge case: Create a PRO user with null values")
    @Test
    public void testCreateProUserWithNullValues() {
        String tier = "PRO";
        String stripeCustomerId = null;
        OffsetDateTime currentPeriodEnd = OffsetDateTime.now().plusDays(30);
        boolean isActive = true;
        boolean cancelAtPeriodEnd = false;

        subscriptionStatusDto = new SubscriptionStatusDto(tier, stripeCustomerId, currentPeriodEnd, isActive, cancelAtPeriodEnd);

        Assertions.assertThat(subscriptionStatusDto.tier()).isEqualTo("PRO");
        Assertions.assertThat(subscriptionStatusDto.stripeCustomerId()).isNull();
        Assertions.assertThat(subscriptionStatusDto.currentPeriodEnd()).isNotNull();
        Assertions.assertThat(subscriptionStatusDto.isActive()).isTrue();
        Assertions.assertThat(subscriptionStatusDto.cancelAtPeriodEnd()).isFalse();
    }

    @DisplayName("Error case: Invalid tier")
    @Test
    public void testInvalidTier() {
        String invalidTier = "INVALID";
        Assertions.assertThatThrownBy(() -> new SubscriptionStatusDto(invalidTier, null, null, false, false))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessageContaining("Invalid tier value");
    }
}
```
