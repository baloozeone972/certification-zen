// certif-parent/certif-domain/src/test/java/com/certifapp/domain/model/user/UserTest.java
package com.certifapp.domain.model.user;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;

import java.time.OffsetDateTime;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

/**
 * Unit tests for the {@link User} domain record.
 * Verifies constructor, invariants, email normalization, and business methods.
 */
@DisplayName("User")
class UserTest {

    // ── Helpers ──────────────────────────────────────────────────────────────

    private User buildUser(SubscriptionTier tier) {
        return new User(
                UUID.randomUUID(),
                "test@example.com",
                "$2a$12$hashedpassword",
                UserRole.USER,
                tier,
                User.DEFAULT_LOCALE,
                User.DEFAULT_TIMEZONE,
                null, true,
                OffsetDateTime.now(), OffsetDateTime.now()
        );
    }

    // ── Compact constructor ───────────────────────────────────────────────────

    @Nested
    @DisplayName("compact constructor")
    class Constructor {

        @Test
        @DisplayName("valid input → user created")
        void validInput_shouldCreateUser() {
            User u = buildUser(SubscriptionTier.FREE);
            assertThat(u.email()).isEqualTo("test@example.com");
            assertThat(u.role()).isEqualTo(UserRole.USER);
            assertThat(u.subscriptionTier()).isEqualTo(SubscriptionTier.FREE);
        }

        @Test
        @DisplayName("email is lowercased and trimmed")
        void email_shouldBeLowercasedAndTrimmed() {
            User u = new User(UUID.randomUUID(), "  Test@Example.COM  ",
                    "$2a$12$hash", UserRole.USER, SubscriptionTier.FREE,
                    "fr", "Europe/Paris", null, true,
                    OffsetDateTime.now(), OffsetDateTime.now());
            assertThat(u.email()).isEqualTo("test@example.com");
        }

        @Test
        @DisplayName("blank email → IllegalArgumentException")
        void blankEmail_shouldThrow() {
            assertThatThrownBy(() -> new User(UUID.randomUUID(), "  ",
                    "$2a$12$hash", UserRole.USER, SubscriptionTier.FREE,
                    "fr", "Europe/Paris", null, true,
                    OffsetDateTime.now(), OffsetDateTime.now()))
                    .isInstanceOf(IllegalArgumentException.class)
                    .hasMessageContaining("email");
        }

        @Test
        @DisplayName("blank passwordHash → IllegalArgumentException")
        void blankPasswordHash_shouldThrow() {
            assertThatThrownBy(() -> new User(UUID.randomUUID(), "a@b.com",
                    "", UserRole.USER, SubscriptionTier.FREE,
                    "fr", "Europe/Paris", null, true,
                    OffsetDateTime.now(), OffsetDateTime.now()))
                    .isInstanceOf(IllegalArgumentException.class)
                    .hasMessageContaining("passwordHash");
        }

        @Test
        @DisplayName("null role → IllegalArgumentException")
        void nullRole_shouldThrow() {
            assertThatThrownBy(() -> new User(UUID.randomUUID(), "a@b.com",
                    "$2a$12$hash", null, SubscriptionTier.FREE,
                    "fr", "Europe/Paris", null, true,
                    OffsetDateTime.now(), OffsetDateTime.now()))
                    .isInstanceOf(IllegalArgumentException.class)
                    .hasMessageContaining("role");
        }

        @Test
        @DisplayName("null subscriptionTier → IllegalArgumentException")
        void nullTier_shouldThrow() {
            assertThatThrownBy(() -> new User(UUID.randomUUID(), "a@b.com",
                    "$2a$12$hash", UserRole.USER, null,
                    "fr", "Europe/Paris", null, true,
                    OffsetDateTime.now(), OffsetDateTime.now()))
                    .isInstanceOf(IllegalArgumentException.class)
                    .hasMessageContaining("subscriptionTier");
        }
    }

    // ── hasAiAccess() ────────────────────────────────────────────────────────

    @Nested
    @DisplayName("hasAiAccess()")
    class HasAiAccess {

        @Test
        @DisplayName("FREE → false")
        void free_shouldReturnFalse() {
            assertThat(buildUser(SubscriptionTier.FREE).hasAiAccess()).isFalse();
        }

        @Test
        @DisplayName("PRO → true")
        void pro_shouldReturnTrue() {
            assertThat(buildUser(SubscriptionTier.PRO).hasAiAccess()).isTrue();
        }

        @Test
        @DisplayName("PACK → false (AI is PRO-only)")
        void pack_shouldReturnFalse() {
            assertThat(buildUser(SubscriptionTier.PACK).hasAiAccess()).isFalse();
        }
    }

    // ── hasUnlimitedAccess() ─────────────────────────────────────────────────

    @Nested
    @DisplayName("hasUnlimitedAccess()")
    class HasUnlimitedAccess {

        @Test
        @DisplayName("FREE → false")
        void free_shouldReturnFalse() {
            assertThat(buildUser(SubscriptionTier.FREE).hasUnlimitedAccess()).isFalse();
        }

        @Test
        @DisplayName("PRO → true")
        void pro_shouldReturnTrue() {
            assertThat(buildUser(SubscriptionTier.PRO).hasUnlimitedAccess()).isTrue();
        }

        @Test
        @DisplayName("PACK → true")
        void pack_shouldReturnTrue() {
            assertThat(buildUser(SubscriptionTier.PACK).hasUnlimitedAccess()).isTrue();
        }
    }
}
