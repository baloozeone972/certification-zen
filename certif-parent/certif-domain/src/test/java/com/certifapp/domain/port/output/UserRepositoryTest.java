// certif-parent/certif-domain/src/test/java/com/certifapp/domain/port/output/UserRepositoryTest.java
package com.certifapp.domain.port.output;

import com.certifapp.domain.model.user.*;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.OffsetDateTime;
import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.Mockito.*;

/**
 * Contract tests for {@link UserRepository} output port.
 * The interface is mocked — adapter implementation tested in UserRepositoryAdapterTest.
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("UserRepository — port contract")
class UserRepositoryTest {

    @Mock
    private UserRepository repository;

    private User buildUser(UUID id, String email) {
        return new User(id, email, "$2a$12$hash", UserRole.USER,
                SubscriptionTier.FREE, "fr", "Europe/Paris",
                null, true, OffsetDateTime.now(), OffsetDateTime.now());
    }

    // ── findById ─────────────────────────────────────────────────────────────

    @Test
    @DisplayName("findById — user found → Optional.of(user)")
    void findById_found_returnsUser() {
        UUID id   = UUID.randomUUID();
        User user = buildUser(id, "a@test.com");
        when(repository.findById(id)).thenReturn(Optional.of(user));

        assertThat(repository.findById(id)).contains(user);
        verify(repository).findById(id);
    }

    @Test
    @DisplayName("findById — unknown id → Optional.empty()")
    void findById_notFound_returnsEmpty() {
        UUID id = UUID.randomUUID();
        when(repository.findById(id)).thenReturn(Optional.empty());

        assertThat(repository.findById(id)).isEmpty();
    }

    // ── findByEmail ──────────────────────────────────────────────────────────

    @Test
    @DisplayName("findByEmail — existing email → Optional.of(user)")
    void findByEmail_found_returnsUser() {
        String email = "b@test.com";
        User user    = buildUser(UUID.randomUUID(), email);
        when(repository.findByEmail(email)).thenReturn(Optional.of(user));

        assertThat(repository.findByEmail(email)).contains(user);
    }

    @Test
    @DisplayName("findByEmail — unknown email → Optional.empty()")
    void findByEmail_notFound_returnsEmpty() {
        when(repository.findByEmail("x@test.com")).thenReturn(Optional.empty());
        assertThat(repository.findByEmail("x@test.com")).isEmpty();
    }

    // ── findByStripeCustomerId ────────────────────────────────────────────────

    @Test
    @DisplayName("findByStripeCustomerId — known customer → Optional.of(user)")
    void findByStripeCustomerId_found_returnsUser() {
        User user = buildUser(UUID.randomUUID(), "c@test.com");
        when(repository.findByStripeCustomerId("cus_123")).thenReturn(Optional.of(user));

        assertThat(repository.findByStripeCustomerId("cus_123")).contains(user);
    }

    @Test
    @DisplayName("findByStripeCustomerId — unknown customer → Optional.empty()")
    void findByStripeCustomerId_notFound_returnsEmpty() {
        when(repository.findByStripeCustomerId("cus_unknown")).thenReturn(Optional.empty());
        assertThat(repository.findByStripeCustomerId("cus_unknown")).isEmpty();
    }

    // ── existsByEmail ─────────────────────────────────────────────────────────

    @Test
    @DisplayName("existsByEmail — registered email → true")
    void existsByEmail_registered_returnsTrue() {
        when(repository.existsByEmail("d@test.com")).thenReturn(true);
        assertThat(repository.existsByEmail("d@test.com")).isTrue();
    }

    @Test
    @DisplayName("existsByEmail — unknown email → false")
    void existsByEmail_unknown_returnsFalse() {
        when(repository.existsByEmail("z@test.com")).thenReturn(false);
        assertThat(repository.existsByEmail("z@test.com")).isFalse();
    }

    // ── save ─────────────────────────────────────────────────────────────────

    @Test
    @DisplayName("save — returns persisted user")
    void save_returnsPersistedUser() {
        User user    = buildUser(UUID.randomUUID(), "e@test.com");
        when(repository.save(user)).thenReturn(user);
        assertThat(repository.save(user)).isEqualTo(user);
    }

    // ── deleteById ───────────────────────────────────────────────────────────

    @Test
    @DisplayName("deleteById — invoked once")
    void deleteById_invokedOnce() {
        UUID id = UUID.randomUUID();
        repository.deleteById(id);
        verify(repository, times(1)).deleteById(id);
    }
}
