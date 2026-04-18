package com.certifapp.domain.exception;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

public class InvalidCredentialsExceptionTest {

    @Test
    @DisplayName("InvalidCredentialsException should have the correct message for nominal case")
    public void invalidCredentialsException_nominalCase_expectedMessage() {
        InvalidCredentialsException exception = new InvalidCredentialsException();
        assertThat(exception.getMessage()).isEqualTo("Invalid email or password");
    }

    @Test
    @DisplayName("InvalidCredentialsException should have the correct message for null email")
    public void invalidCredentialsException_nullEmail_expectedMessage() {
        InvalidCredentialsException exception = new InvalidCredentialsException(null, "password");
        assertThat(exception.getMessage()).isEqualTo("Invalid email or password");
    }

    @Test
    @DisplayName("InvalidCredentialsException should have the correct message for null password")
    public void invalidCredentialsException_nullPassword_expectedMessage() {
        InvalidCredentialsException exception = new InvalidCredentialsException("email", null);
        assertThat(exception.getMessage()).isEqualTo("Invalid email or password");
    }

    @Test
    @DisplayName("InvalidCredentialsException should have the correct message for empty email")
    public void invalidCredentialsException_emptyEmail_expectedMessage() {
        InvalidCredentialsException exception = new InvalidCredentialsException("", "password");
        assertThat(exception.getMessage()).isEqualTo("Invalid email or password");
    }

    @Test
    @DisplayName("InvalidCredentialsException should have the correct message for empty password")
    public void invalidCredentialsException_emptyPassword_expectedMessage() {
        InvalidCredentialsException exception = new InvalidCredentialsException("email", "");
        assertThat(exception.getMessage()).isEqualTo("Invalid email or password");
    }
}