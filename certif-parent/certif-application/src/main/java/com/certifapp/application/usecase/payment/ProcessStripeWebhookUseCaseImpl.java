// certif-parent/certif-application/src/main/java/com/certifapp/application/usecase/payment/ProcessStripeWebhookUseCaseImpl.java
package com.certifapp.application.usecase.payment;

import com.certifapp.domain.model.user.SubscriptionTier;
import com.certifapp.domain.model.user.User;
import com.certifapp.domain.port.input.payment.ProcessStripeWebhookUseCase;
import com.certifapp.domain.port.output.UserRepository;
import com.certifapp.domain.port.output.StripePort;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Optional;

/**
 * Use case: processes inbound Stripe webhook events idempotently.
 *
 * <p><strong>Events handled:</strong></p>
 * <ul>
 *   <li>{@code customer.subscription.created}   → set tier PRO</li>
 *   <li>{@code customer.subscription.updated}   → update tier (PRO↔FREE)</li>
 *   <li>{@code customer.subscription.deleted}   → downgrade to FREE</li>
 *   <li>{@code checkout.session.completed}       → one-time PACK purchase</li>
 *   <li>{@code invoice.payment_failed}           → notify, keep current tier</li>
 * </ul>
 *
 * <p>Signature verification is delegated to {@link StripePort} so this use case
 * has zero direct dependency on the Stripe SDK (hexagonal architecture).</p>
 */
public class ProcessStripeWebhookUseCaseImpl implements ProcessStripeWebhookUseCase {

    private static final Logger log = LoggerFactory.getLogger(ProcessStripeWebhookUseCaseImpl.class);

    private final StripePort    stripePort;
    private final UserRepository userRepository;

    public ProcessStripeWebhookUseCaseImpl(StripePort stripePort, UserRepository userRepository) {
        this.stripePort     = stripePort;
        this.userRepository = userRepository;
    }

    @Override
    public void execute(String payload, String signature) {
        // 1. Verify signature + parse event (throws IllegalArgumentException on failure)
        StripePort.StripeEvent event = stripePort.parseAndVerify(payload, signature);

        log.info("[Stripe] received event type={} id={}", event.type(), event.id());

        switch (event.type()) {
            case "customer.subscription.created",
                 "customer.subscription.updated" -> handleSubscriptionUpsert(event);
            case "customer.subscription.deleted" -> handleSubscriptionDeleted(event);
            case "checkout.session.completed"    -> handleCheckoutCompleted(event);
            case "invoice.payment_failed"        -> handlePaymentFailed(event);
            default -> log.debug("[Stripe] unhandled event type={}", event.type());
        }
    }

    // ── Handlers ─────────────────────────────────────────────────────────────

    private void handleSubscriptionUpsert(StripePort.StripeEvent event) {
        String customerId = event.customerId();
        String status     = event.subscriptionStatus(); // active | past_due | canceled

        SubscriptionTier newTier = "active".equals(status)
                ? SubscriptionTier.PRO
                : SubscriptionTier.FREE;

        updateUserTier(customerId, newTier, event.type());
    }

    private void handleSubscriptionDeleted(StripePort.StripeEvent event) {
        updateUserTier(event.customerId(), SubscriptionTier.FREE, event.type());
    }

    private void handleCheckoutCompleted(StripePort.StripeEvent event) {
        // One-time purchase (PACK) — mode = payment, not subscription
        if ("payment".equals(event.checkoutMode())) {
            updateUserTier(event.customerId(), SubscriptionTier.PACK, event.type());
        }
        // subscription checkout handled by customer.subscription.created
    }

    private void handlePaymentFailed(StripePort.StripeEvent event) {
        // Do not downgrade immediately — Stripe retries for up to 3 days
        log.warn("[Stripe] payment failed for customer={}", event.customerId());
        // TODO Phase 2: send email notification via EmailPort
    }

    // ── Shared helper ─────────────────────────────────────────────────────────

    /**
     * Finds a user by Stripe customer ID and updates their subscription tier.
     * Idempotent: if the tier is already correct, no write occurs.
     */
    private void updateUserTier(String customerId, SubscriptionTier newTier, String eventType) {
        if (customerId == null || customerId.isBlank()) {
            log.warn("[Stripe] event {} has no customerId — skipping", eventType);
            return;
        }

        Optional<User> userOpt = userRepository.findByStripeCustomerId(customerId);
        if (userOpt.isEmpty()) {
            log.warn("[Stripe] no user found for customerId={}", customerId);
            return;
        }

        User user = userOpt.get();
        if (user.subscriptionTier() == newTier) {
            log.debug("[Stripe] idempotent — user={} already has tier={}", user.id(), newTier);
            return;
        }

        User updated = new User(
                user.id(), user.email(), user.passwordHash(),
                user.role(), newTier,
                user.locale(), user.timezone(),
                user.stripeCustomerId(), user.isActive(),
                user.createdAt(), java.time.OffsetDateTime.now()
        );
        userRepository.save(updated);
        log.info("[Stripe] user={} tier updated {} → {} (event={})",
                user.id(), user.subscriptionTier(), newTier, eventType);
    }
}
