// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/controller/WebhookController.java
package com.certifapp.api.controller;

import com.certifapp.domain.port.input.payment.ProcessStripeWebhookUseCase;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * REST controller for inbound Stripe webhook events.
 *
 * <p>This endpoint is public (no JWT) but protected by Stripe signature verification
 * inside {@link ProcessStripeWebhookUseCase}.</p>
 */
@RestController
@RequestMapping("/api/v1/webhooks")
@Tag(name = "Webhooks", description = "Stripe webhook receiver")
public class WebhookController {

    private final ProcessStripeWebhookUseCase webhookUseCase;

    public WebhookController(ProcessStripeWebhookUseCase webhookUseCase) {
        this.webhookUseCase = webhookUseCase;
    }

    /**
     * Receives a Stripe webhook event.
     *
     * @param payload   raw JSON body from Stripe
     * @param signature value of the {@code Stripe-Signature} header
     * @return 200 OK if processed successfully
     */
    @PostMapping("/stripe")
    @Operation(summary = "Stripe webhook receiver")
    public ResponseEntity<Void> stripeWebhook(
            @RequestBody String payload,
            @RequestHeader("Stripe-Signature") String signature) {

        webhookUseCase.execute(payload, signature);
        return ResponseEntity.ok().build();
    }
}
