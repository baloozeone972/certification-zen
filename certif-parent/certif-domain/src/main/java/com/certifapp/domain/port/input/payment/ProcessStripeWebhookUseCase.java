// certif-parent/certif-domain/src/main/java/com/certifapp/domain/port/input/payment/ProcessStripeWebhookUseCase.java
package com.certifapp.domain.port.input.payment;

/**
 * Use case: process an inbound Stripe webhook event.
 *
 * <p>Handles: {@code customer.subscription.created},
 * {@code customer.subscription.updated}, {@code customer.subscription.deleted},
 * {@code checkout.session.completed}, {@code invoice.payment_failed}.</p>
 */
public interface ProcessStripeWebhookUseCase {
    /**
     * @param payload   raw JSON body from Stripe
     * @param signature value of the {@code Stripe-Signature} header
     * @throws IllegalArgumentException if the signature is invalid
     */
    void execute(String payload, String signature);
}
