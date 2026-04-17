package com.certifapp.domain.exception;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;

public class CertifAppExceptionTest {

    @Test
    @DisplayName("should throw exception with default message when no arguments provided")
    public void shouldThrowExceptionWithDefaultMessageWhenNoArgumentsProvided() {
        // Arrange
        CertifAppException exception = new CertifAppException();

        // Act & Assert
        assertThat(exception.getMessage()).isNotEmpty();
    }

    @Test
    @DisplayName("should throw exception with custom message when provided")
    public void shouldThrowExceptionWithCustomMessageWhenProvided() {
        // Arrange
        String customMessage = "Custom error message";
        CertifAppException exception = new CertifAppException(customMessage);

        // Act & Assert
        assertThat(exception.getMessage()).isEqualTo(customMessage);
    }

    @Test
    @DisplayName("should throw exception with custom cause when provided")
    public void shouldThrowExceptionWithCustomCauseWhenProvided() {
        // Arrange
        Throwable cause = new RuntimeException("Caused by this");
        CertifAppException exception = new CertifAppException(cause);

        // Act & Assert
        assertThat(exception.getCause()).isEqualTo(cause);
    }

    @Test
    @DisplayName("should throw exception with custom message and cause when provided")
    public void shouldThrowExceptionWithCustomMessageAndCauseWhenProvided() {
        // Arrange
        String customMessage = "Custom error message";
        Throwable cause = new RuntimeException("Caused by this");
        CertifAppException exception = new CertifAppException(customMessage, cause);

        // Act & Assert
        assertThat(exception.getMessage()).isEqualTo(customMessage);
        assertThat(exception.getCause()).isEqualTo(cause);
    }

    @Test
    @DisplayName("should throw IllegalArgumentException when null message provided")
    public void shouldThrowIllegalArgumentExceptionWhenNullMessageProvided() {
        // Arrange & Act & Assert
        Exception exception = assertThrows(IllegalArgumentException.class, () -> {
            new CertifAppException((String) null);
        });
        assertThat(exception.getMessage()).isEqualTo("message cannot be null");
    }

    @Test
    @DisplayName("should throw IllegalArgumentException when null cause provided")
    public void shouldThrowIllegalArgumentExceptionWhenNullCauseProvided() {
        // Arrange & Act & Assert
        Exception exception = assertThrows(IllegalArgumentException.class, () -> {
            new CertifAppException((Throwable) null);
        });
        assertThat(exception.getMessage()).isEqualTo("cause cannot be null");
    }
}