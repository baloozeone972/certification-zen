```java
package com.certifapp.domain.port.input.payment;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import com.stripe.exception.SignatureVerificationException;
import com.stripe.model.Event;
import com.stripe.net.Webhook;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class ProcessStripeWebhookUseCaseTest {

    @Mock
    private Webhook mockWebhook;

    @InjectMocks
    private ProcessStripeWebhookUseCaseImpl processStripeWebhookUseCase;

    @BeforeEach
    public void setUp() {
        when(mockWebhook.verify(anyString(), anyString())).thenReturn(Event.class);
    }

    @Test
    @DisplayName("execute_nominal_case_should_process_webhook")
    public void execute_nominal_case_should_process_webhook() throws SignatureVerificationException {
        // Arrange
        String payload = "{\"type\": \"customer.subscription.created\"}";
        String signature = "valid_signature";

        // Act
        processStripeWebhookUseCase.execute(payload, signature);

        // Assert
        verify(mockWebhook).verify(payload, signature);
    }

    @Test
    @DisplayName("execute_edge_case_empty_payload_should_throw_exception")
    public void execute_edge_case_empty_payload_should_throw_exception() {
        // Arrange
        String payload = "";
        String signature = "valid_signature";

        // Act & Assert
        assertThatThrownBy(() -> processStripeWebhookUseCase.execute(payload, signature))
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
        assertThatThrownBy(() -> processStripeWebhookUseCase.execute(payload, signature))
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
        assertThatThrownBy(() -> processStripeWebhookUseCase.execute(payload, signature))
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
        assertThatThrownBy(() -> processStripeWebhookUseCase.execute(payload, signature))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("Signature cannot be null");
    }

    @Test
    @DisplayName("execute_error_case_invalid_signature_should_throw_exception")
    public void execute_error_case_invalid_signature_should_throw_exception() throws SignatureVerificationException {
        // Arrange
        String payload = "{\"type\": \"customer.subscription.created\"}";
        String signature = "invalid_signature";

        when(mockWebhook.verify(anyString(), anyString())).thenThrow(SignatureVerificationException.class);

        // Act & Assert
        assertThatThrownBy(() -> processStripeWebhookUseCase.execute(payload, signature))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("Invalid Stripe-Signature");
    }
}
```
