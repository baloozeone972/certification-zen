package com.certifapp.domain.exception;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class DuplicateEmailExceptionTest {

    @InjectMocks
    private DuplicateEmailException exception;

    @BeforeEach
    public void setUp() {
        exception = new DuplicateEmailException("test@example.com");
    }

    @DisplayName("Nominal case: Email is already registered")
    @Test
    public void shouldCreateExceptionWithCorrectMessage() {
        String email = "test@example.com";
        DuplicateEmailException exception = new DuplicateEmailException(email);
        assertThat(exception.getMessage()).isEqualTo("Email already registered: " + email);
    }

    @DisplayName("Edge case: Email is null")
    @Test
    public void shouldThrowNullPointerExceptionWhenEmailIsNull() {
        assertThatThrownBy(() -> new DuplicateEmailException(null))
                .isInstanceOf(NullPointerException.class)
                .hasMessage("email");
    }

    @DisplayName("Error case: Empty email string")
    @Test
    public void shouldThrowIllegalArgumentExceptionWhenEmailIsEmpty() {
        assertThatThrownBy(() -> new DuplicateEmailException(""))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("email cannot be empty");
    }
}
