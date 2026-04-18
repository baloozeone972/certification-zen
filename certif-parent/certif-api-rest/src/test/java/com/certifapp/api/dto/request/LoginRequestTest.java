package com.certifapp.api.dto.request;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.assertj.core.api.Assertions.assertThat;

@ExtendWith(MockitoExtension.class)
public class LoginRequestTest {

    @InjectMocks
    private LoginRequest loginRequest;

    @BeforeEach
    public void setUp() {
        // Initialize the LoginRequest object with default values
        loginRequest = new LoginRequest("user@example.com", "password123");
    }

    @Test
    @DisplayName("should create a valid LoginRequest with non-blank email and password")
    public void shouldCreateValidLoginRequestWithNonBlankEmailAndPassword() {
        // Nominal case: both email and password are not blank

        String email = "user@example.com";
        String password = "password123";

        // Create a new LoginRequest object
        LoginRequest request = new LoginRequest(email, password);

        // Assert that the request is valid
        assertThat(request.email()).isEqualTo(email);
        assertThat(request.password()).isEqualTo(password);
    }

    @Test
    @DisplayName("should throw IllegalArgumentException if email is blank")
    public void shouldThrowIllegalArgumentExceptionIfEmailIsBlank() {
        // Edge case: email is blank

        String email = "";
        String password = "password123";

        // Attempt to create a new LoginRequest object with a blank email
        assertThatThrownBy(() -> new LoginRequest(email, password))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("email must not be blank");
    }

    @Test
    @DisplayName("should throw IllegalArgumentException if password is blank")
    public void shouldThrowIllegalArgumentExceptionIfPasswordIsBlank() {
        // Edge case: password is blank

        String email = "user@example.com";
        String password = "";

        // Attempt to create a new LoginRequest object with a blank password
        assertThatThrownBy(() -> new LoginRequest(email, password))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("password must not be blank");
    }

    @Test
    @DisplayName("should throw IllegalArgumentException if email is null")
    public void shouldThrowIllegalArgumentExceptionIfEmailIsNull() {
        // Error case: email is null

        String email = null;
        String password = "password123";

        // Attempt to create a new LoginRequest object with a null email
        assertThatThrownBy(() -> new LoginRequest(email, password))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("email must not be blank");
    }

    @Test
    @DisplayName("should throw IllegalArgumentException if password is null")
    public void shouldThrowIllegalArgumentExceptionIfPasswordIsNull() {
        // Error case: password is null

        String email = "user@example.com";
        String password = null;

        // Attempt to create a new LoginRequest object with a null password
        assertThatThrownBy(() -> new LoginRequest(email, password))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("password must not be blank");
    }

    @Test
    @DisplayName("should throw IllegalArgumentException if email is not in valid format")
    public void shouldThrowIllegalArgumentExceptionIfEmailIsNotInValidFormat() {
        // Error case: email is not in a valid format

        String email = "invalid_email";
        String password = "password123";

        // Attempt to create a new LoginRequest object with an invalid email
        assertThatThrownBy(() -> new LoginRequest(email, password))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("email must be a valid email address");
    }
}
