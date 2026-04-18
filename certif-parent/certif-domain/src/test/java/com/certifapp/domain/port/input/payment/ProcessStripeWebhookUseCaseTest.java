package com.certifapp.domain.port.input.payment;

import com.stripe.exception.SignatureVerificationException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static com.certifapp.domain.port.input.payment.ProcessStripeWebhookUseCaseImpl.INVALID_STRIPE_SIGNATURE;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

public class ProcessStripeWebhookUseCaseTest {

    @BeforeEach
    public void setUp() {
        // No need for mocks in a pure domain test
    }

    @Test
    @DisplayName("execute_nominal_case_should_process_webhook")
    public void execute_nominal_case_should_process_webhook() throws SignatureVerificationException {
        // Arrange
        String payload = "{\"type\": \"customer.subscription.created\"}";
        String signature = "valid_signature";

        // Act
        ProcessStripeWebhookUseCaseImpl.processWebhook(payload, signature);

        // Assert (no need to verify anything in a pure domain test)
    }

    @Test
    @DisplayName("execute_edge_case_empty_payload_should_throw_exception")
    public void execute_edge_case_empty_payload_should_throw_exception() {
        // Arrange
        String payload = "";
        String signature = "valid_signature";

        // Act & Assert
        assertThatThrownBy(() -> ProcessStripeWebhookUseCaseImpl.processWebhook(payload, signature))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("Payload cannot be empty");
    }

    @Test
    @DisplayName("execute_edge_case_null_payload_should_throw_exception")
    public void execute_edge_case_null_payload_should_throw_exception() {
        // Arrange
        String payload = null;
        String signature = "valid_signature";

        // Act & Assert
        assertThatThrownBy(() -> ProcessStripeWebhookUseCaseImpl.processWebhook(payload, signature))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("Payload cannot be null");
    }

    @Test
    @DisplayName("execute_edge_case_empty_signature_should_throw_exception")
    public void execute_edge_case_empty_signature_should_throw_exception() {
        // Arrange
        String payload = "{\"type\": \"customer.subscription.created\"}";
        String signature = "";

        // Act & Assert
        assertThatThrownBy(() -> ProcessStripeWebhookUseCaseImpl.processWebhook(payload, signature))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("Signature cannot be empty");
    }

    @Test
    @DisplayName("execute_edge_case_null_signature_should_throw_exception")
    public void execute_edge_case_null_signature_should_throw_exception() {
        // Arrange
        String payload = "{\"type\": \"customer.subscription.created\"}";
        String signature = null;

        // Act & Assert
        assertThatThrownBy(() -> ProcessStripeWebhookUseCaseImpl.processWebhook(payload, signature))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("Signature cannot be null");
    }

    @Test
    @DisplayName("execute_error_case_invalid_signature_should_throw_exception")
    public void execute_error_case_invalid_signature_should_throw_exception() throws SignatureVerificationException {
        // Arrange
        String payload = "{\"type\": \"customer.subscription.created\"}";
        String signature = "invalid_signature";

        // Act & Assert
        assertThatThrownBy(() -> ProcessStripeWebhookUseCaseImpl.processWebhook(payload, signature))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage(INVALID_STRIPE_SIGNATURE);
    }
}