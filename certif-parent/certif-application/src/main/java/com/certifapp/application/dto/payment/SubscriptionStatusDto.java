// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/payment/SubscriptionStatusDto.java
package com.certifapp.application.dto.payment;

import java.time.OffsetDateTime;

/**
 * Current subscription status for a user.
 *
 * @param tier               FREE | PRO | PACK
 * @param stripeCustomerId   Stripe customer ID (null for FREE users)
 * @param currentPeriodEnd   subscription expiry timestamp (null for FREE users)
 * @param isActive           whether the subscription is currently active
 * @param cancelAtPeriodEnd  whether the subscription will cancel at period end
 */
public record SubscriptionStatusDto(
        String         tier,
        String         stripeCustomerId,
        OffsetDateTime currentPeriodEnd,
        boolean        isActive,
        boolean        cancelAtPeriodEnd
) {}
