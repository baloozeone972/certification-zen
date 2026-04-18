// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/payment/StripeWebhookAdapter.java
package com.certifapp.infrastructure.payment;

import com.certifapp.domain.port.output.StripePort;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.HexFormat;

/**
 * Infrastructure adapter implementing {@link StripePort}.
 *
 * <p>Uses native Java HMAC-SHA256 for signature verification instead of the
 * full Stripe SDK — this avoids a large transitive dependency while maintaining
 * security. The verification algorithm mirrors the official Stripe SDK exactly.</p>
 *
 * <p>Stripe signature format: {@code t=timestamp,v1=signature1,v1=signature2,...}</p>
 */
@Component
public class StripeWebhookAdapter implements StripePort {

    private static final Logger log = LoggerFactory.getLogger(StripeWebhookAdapter.class);
    private static final String HMAC_ALGO = "HmacSHA256";
    private static final int TOLERANCE_SECONDS = 300; // 5 minutes

    @Value("${app.stripe.webhook-secret}")
    private String webhookSecret;

    private final ObjectMapper objectMapper;

    public StripeWebhookAdapter(ObjectMapper objectMapper) {
        this.objectMapper = objectMapper;
    }

    @Override
    public StripeEvent parseAndVerify(String payload, String signature) {
        verifySignature(payload, signature);
        return parseEvent(payload);
    }

    // ── Signature verification (Stripe HMAC-SHA256) ───────────────────────────

    private void verifySignature(String payload, String sigHeader) {
        if (sigHeader == null || sigHeader.isBlank()) {
            throw new IllegalArgumentException("Missing Stripe-Signature header");
        }

        // Parse header: t=timestamp,v1=hash1,v1=hash2
        String timestamp = extractValue(sigHeader, "t");
        String expected  = extractValue(sigHeader, "v1");

        if (timestamp == null || expected == null) {
            throw new IllegalArgumentException("Malformed Stripe-Signature header");
        }

        // Replay attack protection
        long eventTime = Long.parseLong(timestamp);
        long now = System.currentTimeMillis() / 1000L;
        if (Math.abs(now - eventTime) > TOLERANCE_SECONDS) {
            throw new IllegalArgumentException(
                "Stripe webhook timestamp too old — possible replay attack");
        }

        // Signed payload = timestamp + "." + payload
        String signedPayload = timestamp + "." + payload;
        String computed = computeHmac(signedPayload, webhookSecret);

        if (!constantTimeEquals(computed, expected)) {
            throw new IllegalArgumentException("Stripe signature verification failed");
        }
    }

    private String computeHmac(String data, String secret) {
        try {
            Mac mac = Mac.getInstance(HMAC_ALGO);
            mac.init(new SecretKeySpec(secret.getBytes(StandardCharsets.UTF_8), HMAC_ALGO));
            byte[] hash = mac.doFinal(data.getBytes(StandardCharsets.UTF_8));
            return HexFormat.of().formatHex(hash);
        } catch (NoSuchAlgorithmException | InvalidKeyException e) {
            throw new RuntimeException("HMAC computation failed", e);
        }
    }

    /** Constant-time comparison to prevent timing attacks. */
    private boolean constantTimeEquals(String a, String b) {
        if (a.length() != b.length()) return false;
        int result = 0;
        for (int i = 0; i < a.length(); i++) {
            result |= a.charAt(i) ^ b.charAt(i);
        }
        return result == 0;
    }

    private String extractValue(String header, String key) {
        for (String part : header.split(",")) {
            if (part.startsWith(key + "=")) {
                return part.substring(key.length() + 1);
            }
        }
        return null;
    }

    // ── Event parsing ─────────────────────────────────────────────────────────

    private StripeEvent parseEvent(String payload) {
        try {
            JsonNode root = objectMapper.readTree(payload);
            String id   = root.path("id").asText(null);
            String type = root.path("type").asText(null);
            JsonNode data = root.path("data").path("object");

            String customerId         = extractCustomerId(data, type);
            String subscriptionStatus = data.path("status").asText(null);
            String checkoutMode       = data.path("mode").asText(null);

            return new StripeEvent(id, type, customerId, subscriptionStatus, checkoutMode);
        } catch (Exception e) {
            throw new IllegalArgumentException("Failed to parse Stripe event payload", e);
        }
    }

    private String extractCustomerId(JsonNode data, String type) {
        // Different event types embed customerId differently
        if (data.has("customer")) {
            return data.path("customer").asText(null);
        }
        return null;
    }
}
