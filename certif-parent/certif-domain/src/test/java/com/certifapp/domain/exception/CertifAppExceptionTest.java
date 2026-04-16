```java
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
public class CertifAppExceptionTest {

    @Mock
    private SomeDependency someDependency;

    @InjectMocks
    private CertifAppException certifAppException;

    @BeforeEach
    public void setUp() {
        // Setup any necessary initializations or mocks here
    }

    @AfterEach
    public void tearDown() {
        // Clean up after each test if necessary
    }

    @Test
    @DisplayName("should throw exception with default message when no arguments provided")
    public void shouldThrowExceptionWithDefaultMessageWhenNoArgumentsProvided() {
        // Nominal case: Create an instance of CertifAppException without any arguments
        CertifAppException exception = new CertifAppException();

        // Verify that the exception has a default message
        assertThat(exception.getMessage()).isNotEmpty();
    }

    @Test
    @DisplayName("should throw exception with custom message when provided")
    public void shouldThrowExceptionWithCustomMessageWhenProvided() {
        // Nominal case: Create an instance of CertifAppException with a custom message
        String customMessage = "Custom error message";
        CertifAppException exception = new CertifAppException(customMessage);

        // Verify that the exception has the provided custom message
        assertThat(exception.getMessage()).isEqualTo(customMessage);
    }

    @Test
    @DisplayName("should throw exception with custom cause when provided")
    public void shouldThrowExceptionWithCustomCauseWhenProvided() {
        // Nominal case: Create an instance of CertifAppException with a custom cause
        Throwable cause = new RuntimeException("Caused by this");
        CertifAppException exception = new CertifAppException(cause);

        // Verify that the exception has the provided cause
        assertThat(exception.getCause()).isEqualTo(cause);
    }

    @Test
    @DisplayName("should throw exception with custom message and cause when provided")
    public void shouldThrowExceptionWithCustomMessageAndCauseWhenProvided() {
        // Nominal case: Create an instance of CertifAppException with a custom message and cause
        String customMessage = "Custom error message";
        Throwable cause = new RuntimeException("Caused by this");
        CertifAppException exception = new CertifAppException(customMessage, cause);

        // Verify that the exception has the provided custom message and cause
        assertThat(exception.getMessage()).isEqualTo(customMessage);
        assertThat(exception.getCause()).isEqualTo(cause);
    }

    @Test
    @DisplayName("should throw IllegalArgumentException when null message provided")
    public void shouldThrowIllegalArgumentExceptionWhenNullMessageProvided() {
        // Error case: Attempt to create an instance with a null message
        Exception exception = assertThrows(IllegalArgumentException.class, () -> {
            new CertifAppException((String) null);
        });

        // Verify the error message
        assertThat(exception.getMessage()).isEqualTo("message cannot be null");
    }

    @Test
    @DisplayName("should throw IllegalArgumentException when null cause provided")
    public void shouldThrowIllegalArgumentExceptionWhenNullCauseProvided() {
        // Error case: Attempt to create an instance with a null cause
        Exception exception = assertThrows(IllegalArgumentException.class, () -> {
            new CertifAppException((Throwable) null);
        });

        // Verify the error message
        assertThat(exception.getMessage()).isEqualTo("cause cannot be null");
    }
}
```
