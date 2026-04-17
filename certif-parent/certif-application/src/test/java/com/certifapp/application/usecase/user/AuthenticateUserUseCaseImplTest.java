package com.certifapp.application.usecase.user;

import com.certifapp.domain.exception.InvalidCredentialsException;
import com.certifapp.domain.model.user.SubscriptionTier;
import com.certifapp.domain.model.user.User;
import com.certifapp.domain.model.user.UserRole;
import com.certifapp.domain.port.output.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.OffsetDateTime;
import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@DisplayName("AuthenticateUserUseCaseImpl")
class AuthenticateUserUseCaseImplTest {

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private AuthenticateUserUseCaseImpl useCase;

    @BeforeEach
    void setUp() {
        useCase = new AuthenticateUserUseCaseImpl(
                userRepository,
                (raw, hash) -> hash.equals("hashed_" + raw));
    }

    @Test
    @DisplayName("Valid credentials — returns authenticated user")
    void validCredentials_shouldReturnUser() {
        // Arrange
        User user = new User(UUID.randomUUID(), "user@example.com", "hashed_Password123",
                UserRole.USER, SubscriptionTier.PRO, "fr", "Europe/Paris",
                null, true, OffsetDateTime.now(), OffsetDateTime.now());
        when(userRepository.findByEmail("user@example.com")).thenReturn(Optional.of(user));

        // Act
        User result = useCase.execute("user@example.com", "Password123");

        // Assert
        assertThat(result.email()).isEqualTo("user@example.com");
    }

    @Test
    @DisplayName("Wrong password — throws InvalidCredentialsException")
    void wrongPassword_shouldThrow() {
        // Arrange
        User user = new User(UUID.randomUUID(), "user@example.com", "hashed_correct",
                UserRole.USER, SubscriptionTier.FREE, "fr", "Europe/Paris",
                null, true, OffsetDateTime.now(), OffsetDateTime.now());
        when(userRepository.findByEmail("user@example.com")).thenReturn(Optional.of(user));

        // Act & Assert
        assertThatThrownBy(() -> useCase.execute("user@example.com", "wrongPassword"))
                .isInstanceOf(InvalidCredentialsException.class);
    }

    @Test
    @DisplayName("Unknown email — throws InvalidCredentialsException")
    void unknownEmail_shouldThrow() {
        // Arrange
        when(userRepository.findByEmail("unknown@example.com")).thenReturn(Optional.empty());

        // Act & Assert
        assertThatThrownBy(() -> useCase.execute("unknown@example.com", "pass"))
                .isInstanceOf(InvalidCredentialsException.class);
    }

    @Test
    @DisplayName("Inactive user — throws InvalidCredentialsException")
    void inactiveUser_shouldThrow() {
        // Arrange
        User user = new User(UUID.randomUUID(), "user@example.com", "hashed_Password123",
                UserRole.USER, SubscriptionTier.FREE, "fr", "Europe/Paris",
                null, false, OffsetDateTime.now(), OffsetDateTime.now());
        when(userRepository.findByEmail("user@example.com")).thenReturn(Optional.of(user));

        // Act & Assert
        assertThatThrownBy(() -> useCase.execute("user@example.com", "Password123"))
                .isInstanceOf(InvalidCredentialsException.class);
    }
}