// certif-parent/certif-application/src/test/java/com/certifapp/application/usecase/payment/ProcessStripeWebhookUseCaseImplTest.java
package com.certifapp.application.usecase.payment;

import com.certifapp.domain.model.user.*;
import com.certifapp.domain.port.output.StripePort;
import com.certifapp.domain.port.output.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.OffsetDateTime;
import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("ProcessStripeWebhookUseCaseImpl")
class ProcessStripeWebhookUseCaseImplTest {

    @Mock StripePort     stripePort;
    @Mock UserRepository userRepository;
    @InjectMocks ProcessStripeWebhookUseCaseImpl useCase;

    private User freeUser;

    @BeforeEach
    void setUp() {
        freeUser = new User(UUID.randomUUID(), "user@test.com", "$2a$12$hash",
                UserRole.USER, SubscriptionTier.FREE, "fr", "Europe/Paris",
                "cus_test123", true, OffsetDateTime.now(), OffsetDateTime.now());
    }

    // ── subscription.created ─────────────────────────────────────────────────

    @Nested @DisplayName("customer.subscription.created")
    class SubscriptionCreated {

        @Test @DisplayName("active subscription → upgrades user to PRO")
        void active_shouldUpgradeToPro() {
            var event = new StripePort.StripeEvent("evt_1", "customer.subscription.created",
                    "cus_test123", "active", null);
            when(stripePort.parseAndVerify(any(), any())).thenReturn(event);
            when(userRepository.findByStripeCustomerId("cus_test123")).thenReturn(Optional.of(freeUser));

            useCase.execute("payload", "sig");

            ArgumentCaptor<User> captor = ArgumentCaptor.forClass(User.class);
            verify(userRepository).save(captor.capture());
            assertThat(captor.getValue().subscriptionTier()).isEqualTo(SubscriptionTier.PRO);
        }

        @Test @DisplayName("past_due subscription → keeps FREE tier")
        void pastDue_shouldKeepFree() {
            var event = new StripePort.StripeEvent("evt_2", "customer.subscription.created",
                    "cus_test123", "past_due", null);
            when(stripePort.parseAndVerify(any(), any())).thenReturn(event);
            when(userRepository.findByStripeCustomerId("cus_test123")).thenReturn(Optional.of(freeUser));

            useCase.execute("payload", "sig");

            verify(userRepository, never()).save(any()); // already FREE — idempotent
        }
    }

    // ── subscription.deleted ─────────────────────────────────────────────────

    @Nested @DisplayName("customer.subscription.deleted")
    class SubscriptionDeleted {

        @Test @DisplayName("PRO user → downgraded to FREE")
        void proUser_shouldDowngradeToFree() {
            User proUser = new User(freeUser.id(), freeUser.email(), freeUser.passwordHash(),
                    freeUser.role(), SubscriptionTier.PRO, freeUser.locale(), freeUser.timezone(),
                    "cus_test123", true, freeUser.createdAt(), freeUser.updatedAt());
            var event = new StripePort.StripeEvent("evt_3", "customer.subscription.deleted",
                    "cus_test123", "canceled", null);
            when(stripePort.parseAndVerify(any(), any())).thenReturn(event);
            when(userRepository.findByStripeCustomerId("cus_test123")).thenReturn(Optional.of(proUser));

            useCase.execute("payload", "sig");

            ArgumentCaptor<User> captor = ArgumentCaptor.forClass(User.class);
            verify(userRepository).save(captor.capture());
            assertThat(captor.getValue().subscriptionTier()).isEqualTo(SubscriptionTier.FREE);
        }
    }

    // ── checkout.session.completed (PACK) ────────────────────────────────────

    @Nested @DisplayName("checkout.session.completed")
    class CheckoutCompleted {

        @Test @DisplayName("mode=payment → upgrades to PACK")
        void paymentMode_shouldUpgradeToPack() {
            var event = new StripePort.StripeEvent("evt_4", "checkout.session.completed",
                    "cus_test123", null, "payment");
            when(stripePort.parseAndVerify(any(), any())).thenReturn(event);
            when(userRepository.findByStripeCustomerId("cus_test123")).thenReturn(Optional.of(freeUser));

            useCase.execute("payload", "sig");

            ArgumentCaptor<User> captor = ArgumentCaptor.forClass(User.class);
            verify(userRepository).save(captor.capture());
            assertThat(captor.getValue().subscriptionTier()).isEqualTo(SubscriptionTier.PACK);
        }

        @Test @DisplayName("mode=subscription → no direct upgrade (handled by subscription.created)")
        void subscriptionMode_shouldNotUpgrade() {
            var event = new StripePort.StripeEvent("evt_5", "checkout.session.completed",
                    "cus_test123", null, "subscription");
            when(stripePort.parseAndVerify(any(), any())).thenReturn(event);

            useCase.execute("payload", "sig");

            verify(userRepository, never()).save(any());
        }
    }

    // ── Idempotence ───────────────────────────────────────────────────────────

    @Test @DisplayName("idempotent — no write when tier already correct")
    void idempotent_shouldNotSaveIfTierUnchanged() {
        User proUser = new User(freeUser.id(), freeUser.email(), freeUser.passwordHash(),
                freeUser.role(), SubscriptionTier.PRO, freeUser.locale(), freeUser.timezone(),
                "cus_test123", true, freeUser.createdAt(), freeUser.updatedAt());
        var event = new StripePort.StripeEvent("evt_6", "customer.subscription.created",
                "cus_test123", "active", null);
        when(stripePort.parseAndVerify(any(), any())).thenReturn(event);
        when(userRepository.findByStripeCustomerId("cus_test123")).thenReturn(Optional.of(proUser));

        useCase.execute("payload", "sig");

        verify(userRepository, never()).save(any());
    }

    // ── Unknown customer ──────────────────────────────────────────────────────

    @Test @DisplayName("unknown customerId → no exception, no write")
    void unknownCustomer_shouldLogAndSkip() {
        var event = new StripePort.StripeEvent("evt_7", "customer.subscription.created",
                "cus_unknown", "active", null);
        when(stripePort.parseAndVerify(any(), any())).thenReturn(event);
        when(userRepository.findByStripeCustomerId("cus_unknown")).thenReturn(Optional.empty());

        assertThatCode(() -> useCase.execute("payload", "sig")).doesNotThrowAnyException();
        verify(userRepository, never()).save(any());
    }
}
