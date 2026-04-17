package com.certifapp.domain.port.input.user;

import com.certifapp.domain.exception.InvalidCredentialsException;
import com.certifapp.domain.model.user.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

public class AuthenticateUserUseCaseTest {

    private AuthenticateUserUseCase authenticateUserUseCase;
    private UserRepository userRepository;

    @BeforeEach
    public void setUp() {
        userRepository = new InMemoryUserRepository(); // Assuming an in-memory implementation for testing
        authenticateUserUseCase = new AuthenticateUserUseCase(userRepository);
    }

    @Test
    @DisplayName("nominal case: authenticate a valid user")
    public void authenticateUser_validCredentials_UserReturned() throws InvalidCredentialsException {
        String email = "test@example.com";
        String password = "password123";
        User expectedUser = new User(email, "hashedPassword");

        userRepository.save(expectedUser);

        User authenticatedUser = authenticateUserUseCase.execute(email, password);

        assertThat(authenticatedUser).isEqualTo(expectedUser);
    }

    @Test
    @DisplayName("edge case: user not found")
    public void authenticateUser_userNotFound_InvalidCredentialsException() throws InvalidCredentialsException {
        String email = "test@example.com";
        String password = "password123";

        assertThatThrownBy(() -> authenticateUserUseCase.execute(email, password))
                .isInstanceOf(InvalidCredentialsException.class)
                .hasMessage("Invalid credentials");
    }

    @Test
    @DisplayName("edge case: invalid password")
    public void authenticateUser_invalidPassword_InvalidCredentialsException() throws InvalidCredentialsException {
        String email = "test@example.com";
        String password = "wrongpassword";
        User expectedUser = new User(email, "hashedPassword");

        userRepository.save(expectedUser);

        assertThatThrownBy(() -> authenticateUserUseCase.execute(email, password))
                .isInstanceOf(InvalidCredentialsException.class)
                .hasMessage("Invalid credentials");
    }
}