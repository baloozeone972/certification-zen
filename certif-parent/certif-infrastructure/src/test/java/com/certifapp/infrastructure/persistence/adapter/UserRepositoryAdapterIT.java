// certif-parent/certif-infrastructure/src/test/java/com/certifapp/infrastructure/persistence/adapter/UserRepositoryAdapterIT.java
package com.certifapp.infrastructure.persistence.adapter;

import com.certifapp.domain.exception.DuplicateEmailException;
import com.certifapp.domain.model.user.*;
import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.context.annotation.Import;
import org.springframework.test.context.ActiveProfiles;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import java.time.OffsetDateTime;
import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.*;

/**
 * Integration test for {@link UserRepositoryAdapter} using Testcontainers PostgreSQL.
 *
 * <p>Uses {@code @DataJpaTest} to load only JPA slices + Flyway migrations.
 * The PostgreSQL container is shared across all tests in this class.</p>
 */
@Testcontainers
@DataJpaTest
@ActiveProfiles("test")
@Import({UserRepositoryAdapter.class,
         com.certifapp.infrastructure.persistence.mapper.UserMapperImpl.class})
@DisplayName("UserRepositoryAdapter — Integration Tests")
class UserRepositoryAdapterIT {

    @Container
    static PostgreSQLContainer<?> postgres =
            new PostgreSQLContainer<>("pgvector/pgvector:pg16")
                    .withDatabaseName("certifapp_test")
                    .withUsername("certifapp")
                    .withPassword("test");

    @Autowired
    private UserRepositoryAdapter userRepositoryAdapter;

    @Test
    @DisplayName("save() and findByEmail() — round trip")
    void saveAndFindByEmail_shouldRoundTrip() {
        // Arrange
        User user = buildUser("test@example.com");

        // Act
        User saved  = userRepositoryAdapter.save(user);
        Optional<User> found = userRepositoryAdapter.findByEmail("test@example.com");

        // Assert
        assertThat(saved.id()).isNotNull();
        assertThat(found).isPresent();
        assertThat(found.get().email()).isEqualTo("test@example.com");
        assertThat(found.get().role()).isEqualTo(UserRole.USER);
        assertThat(found.get().subscriptionTier()).isEqualTo(SubscriptionTier.FREE);
    }

    @Test
    @DisplayName("existsByEmail() returns true for existing email")
    void existsByEmail_shouldReturnTrueForExisting() {
        userRepositoryAdapter.save(buildUser("exists@example.com"));
        assertThat(userRepositoryAdapter.existsByEmail("exists@example.com")).isTrue();
    }

    @Test
    @DisplayName("existsByEmail() returns false for unknown email")
    void existsByEmail_shouldReturnFalseForUnknown() {
        assertThat(userRepositoryAdapter.existsByEmail("unknown@example.com")).isFalse();
    }

    @Test
    @DisplayName("findById() returns empty for unknown UUID")
    void findById_unknownId_shouldReturnEmpty() {
        assertThat(userRepositoryAdapter.findById(UUID.randomUUID())).isEmpty();
    }

    @Test
    @DisplayName("deleteById() removes the user")
    void deleteById_shouldRemoveUser() {
        User saved = userRepositoryAdapter.save(buildUser("delete@example.com"));
        userRepositoryAdapter.deleteById(saved.id());
        assertThat(userRepositoryAdapter.findById(saved.id())).isEmpty();
    }

    // ── Helpers ──────────────────────────────────────────────────────────────

    private static User buildUser(String email) {
        OffsetDateTime now = OffsetDateTime.now();
        return new User(null, email, "$2b$12$test_hash",
                UserRole.USER, SubscriptionTier.FREE,
                "fr", "Europe/Paris", null, true, now, now);
    }
}
