// certif-parent/certif-application/src/test/java/com/certifapp/application/usecase/user/RegisterUserUseCaseImplTest.java
package com.certifapp.application.usecase.user;

import com.certifapp.domain.exception.DuplicateEmailException;
import com.certifapp.domain.model.user.*;
import com.certifapp.domain.port.input.user.RegisterUserUseCase;
import com.certifapp.domain.port.output.UserPreferencesRepository;
import com.certifapp.domain.port.output.UserRepository;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.OffsetDateTime;
import java.util.UUID;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

/**
 * Unit tests for {@link RegisterUserUseCaseImpl}.
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("RegisterUserUseCaseImpl")
class RegisterUserUseCaseImplTest {

    @Mock private UserRepository            userRepository;
    @Mock private UserPreferencesRepository preferencesRepository;

    private RegisterUserUseCaseImpl useCase;

    @BeforeEach
    void setUp() {
        useCase = new RegisterUserUseCaseImpl(
                userRepository, preferencesRepository,
                password -> "$2b$12$hashed_" + password);
    }

    @Test
    @DisplayName("New user registration — creates user with FREE tier and default preferences")
    void newRegistration_shouldCreateFreeUser() {
        // Arrange
        when(userRepository.existsByEmail("user@example.com")).thenReturn(false);
        User saved = new User(UUID.randomUUID(), "user@example.com", "$2b$12$hash",
                UserRole.USER, SubscriptionTier.FREE, "fr", "Europe/Paris",
                null, true, OffsetDateTime.now(), OffsetDateTime.now());
        when(userRepository.save(any(User.class))).thenReturn(saved);
        when(preferencesRepository.save(any(UserPreferences.class)))
                .thenAnswer(inv -> inv.getArgument(0));

        RegisterUserUseCase.RegisterUserCommand cmd =
                new RegisterUserUseCase.RegisterUserCommand(
                        "user@example.com", "Password123", "fr", "Europe/Paris");

        // Act
        User result = useCase.execute(cmd);

        // Assert
        assertThat(result.email()).isEqualTo("user@example.com");
        assertThat(result.subscriptionTier()).isEqualTo(SubscriptionTier.FREE);
        assertThat(result.role()).isEqualTo(UserRole.USER);
        verify(preferencesRepository).save(any(UserPreferences.class));
    }

    @Test
    @DisplayName("Duplicate email — throws DuplicateEmailException")
    void duplicateEmail_shouldThrow() {
        when(userRepository.existsByEmail("existing@example.com")).thenReturn(true);

        RegisterUserUseCase.RegisterUserCommand cmd =
                new RegisterUserUseCase.RegisterUserCommand(
                        "existing@example.com", "Password123", "fr", "Europe/Paris");

        assertThatThrownBy(() -> useCase.execute(cmd))
                .isInstanceOf(DuplicateEmailException.class)
                .hasMessageContaining("existing@example.com");
    }

    @Test
    @DisplayName("Email is lowercased on registration")
    void email_shouldBeLowercased() {
        when(userRepository.existsByEmail("user@example.com")).thenReturn(false);
        User saved = new User(UUID.randomUUID(), "user@example.com", "$2b$12$hash",
                UserRole.USER, SubscriptionTier.FREE, "fr", "Europe/Paris",
                null, true, OffsetDateTime.now(), OffsetDateTime.now());
        when(userRepository.save(any(User.class))).thenReturn(saved);
        when(preferencesRepository.save(any(UserPreferences.class)))
                .thenAnswer(inv -> inv.getArgument(0));

        RegisterUserUseCase.RegisterUserCommand cmd =
                new RegisterUserUseCase.RegisterUserCommand(
                        "USER@EXAMPLE.COM", "Password123", "fr", "Europe/Paris");

        User result = useCase.execute(cmd);
        assertThat(result.email()).isEqualTo("user@example.com");
    }

    @Test
    @DisplayName("Password too short — throws IllegalArgumentException")
    void shortPassword_shouldThrow() {
        assertThatThrownBy(() ->
                new RegisterUserUseCase.RegisterUserCommand("u@x.com", "short", "fr", null))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessageContaining("at least 8 characters");
    }
}
