package com.certifapp.api.controller;

import com.certifapp.domain.port.input.payment.ProcessStripeWebhookUseCase;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import org.springframework.http.ResponseEntity;

import static com.certifapp.api.controller.WebhookController.*;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class WebhookControllerTest {

    @Mock
    private ProcessStripeWebhookUseCase webhookUseCase;

    @InjectMocks
    private WebhookController controller;

    @BeforeEach
    public void setUp() {
        // Initialization code if needed
    }

    @Test
    @DisplayName("stripeWebhook_nomalCase_webhookProcessedAndOkResponse")
    public void stripeWebhook_nomalCase_webhookProcessedAndOkResponse() {
        // Arrange
        String payload = "{\"event\": \"payment_intent.succeeded\"}";
        String signature = "v1=signature";

        // Act
        ResponseEntity<Void> response = controller.stripeWebhook(payload, signature);

        // Assert
        assertThat(response).isEqualTo(ResponseEntity.ok().build());
        verify(webhookUseCase, times(1)).execute(anyString(), anyString());
    }

    @Test
    @DisplayName("stripeWebhook_edgeCase_emptyPayload_webhookProcessedAndOkResponse")
    public void stripeWebhook_edgeCase_emptyPayload_webhookProcessedAndOkResponse() {
        // Arrange
        String payload = "";
        String signature = "v1=signature";

        // Act
        ResponseEntity<Void> response = controller.stripeWebhook(payload, signature);

        // Assert
        assertThat(response).isEqualTo(ResponseEntity.ok().build());
        verify(webhookUseCase, times(1)).execute(anyString(), anyString());
    }

    @Test
    @DisplayName("stripeWebhook_errorCase_nullPayload_exceptionThrown")
    public void stripeWebhook_errorCase_nullPayload_exceptionThrown() {
        // Arrange
        String payload = null;
        String signature = "v1=signature";

        // Act & Assert
        assertThatNullPointerException().isThrownBy(() -> controller.stripeWebhook(payload, signature));
    }

    @Test
    @DisplayName("stripeWebhook_errorCase_nullSignature_exceptionThrown")
    public void stripeWebhook_errorCase_nullSignature_exceptionThrown() {
        // Arrange
        String payload = "{\"event\": \"payment_intent.succeeded\"}";
        String signature = null;

        // Act & Assert
        assertThatNullPointerException().isThrownBy(() -> controller.stripeWebhook(payload, signature));
    }
}
