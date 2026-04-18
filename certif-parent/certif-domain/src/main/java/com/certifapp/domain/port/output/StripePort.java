// certif-parent/certif-domain/src/main/java/com/certifapp/domain/port/output/StripePort.java
package com.certifapp.domain.port.output;

/**
 * Output port for Stripe operations.
 * Implemented in certif-infrastructure — isolates the domain from the Stripe SDK.
 */
public interface StripePort {

    /**
     * Parses and verifies a raw Stripe webhook payload against the provided signature.
     *
     * @param payload   raw JSON body from Stripe
     * @param signature value of the {@code Stripe-Signature} HTTP header
     * @return parsed {@link StripeEvent}
     * @throws IllegalArgumentException if the signature is invalid or payload is malformed
     */
    StripeEvent parseAndVerify(String payload, String signature);

    /**
     * Immutable record representing a parsed Stripe webhook event.
     *
     * @param id                 Stripe event ID (e.g. {@code evt_xxx}) — used for idempotency
     * @param type               event type (e.g. {@code customer.subscription.created})
     * @param customerId         Stripe customer ID (may be null for some event types)
     * @param subscriptionStatus subscription status: {@code active}, {@code past_due}, {@code canceled}
     * @param checkoutMode       checkout mode: {@code payment} or {@code subscription}
     */
    record StripeEvent(
            String id,
            String type,
            String customerId,
            String subscriptionStatus,
            String checkoutMode
    ) {}
}
