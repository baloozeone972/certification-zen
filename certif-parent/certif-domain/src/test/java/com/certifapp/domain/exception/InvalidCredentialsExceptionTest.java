package com.certifapp.domain.exception;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.assertj.core.api.Assertions.assertThat;

@ExtendWith(MockitoExtension.class)
public class InvalidCredentialsExceptionTest {

    @BeforeEach
    public void setUp() {
        // Setup code if needed
    }

    @Test
    @DisplayName("InvalidCredentialsException should have the correct message for nominal case")
    public void invalidCredentialsException_nominalCase_expectedMessage() {
        InvalidCredentialsException exception = new InvalidCredentialsException();
        assertThat(exception.getMessage()).isEqualTo("Invalid email or password");
    }
}

