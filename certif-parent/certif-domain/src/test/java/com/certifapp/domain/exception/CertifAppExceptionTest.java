// certif-parent/certif-domain/src/test/java/com/certifapp/domain/exception/CertifAppExceptionTest.java
package com.certifapp.domain.exception;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

/**
 * Unit tests for {@link CertifAppException}.
 * Verifies constructors, message propagation and null validation.
 */
@DisplayName("CertifAppException")
class CertifAppExceptionTest {

    @Test
    @DisplayName("no-arg constructor → non-empty message")
    void noArg_shouldHaveNonEmptyMessage() {
        CertifAppException ex = new CertifAppException();
        assertThat(ex.getMessage()).isNotBlank();
    }

    @Test
    @DisplayName("String constructor → message stored correctly")
    void stringConstructor_shouldStoreMessage() {
        CertifAppException ex = new CertifAppException("Custom error");
        assertThat(ex.getMessage()).isEqualTo("Custom error");
    }

    @Test
    @DisplayName("Throwable constructor → cause stored correctly")
    void throwableConstructor_shouldStoreCause() {
        Throwable cause = new RuntimeException("root");
        CertifAppException ex = new CertifAppException(cause);
        assertThat(ex.getCause()).isEqualTo(cause);
    }

    @Test
    @DisplayName("String+Throwable constructor → both stored")
    void fullConstructor_shouldStoreBoth() {
        Throwable cause = new RuntimeException("root");
        CertifAppException ex = new CertifAppException("msg", cause);
        assertThat(ex.getMessage()).isEqualTo("msg");
        assertThat(ex.getCause()).isEqualTo(cause);
    }

    @Test
    @DisplayName("null message → IllegalArgumentException")
    void nullMessage_shouldThrowIllegalArgument() {
        assertThatThrownBy(() -> new CertifAppException((String) null))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("message cannot be null");
    }

    @Test
    @DisplayName("null cause → IllegalArgumentException")
    void nullCause_shouldThrowIllegalArgument() {
        assertThatThrownBy(() -> new CertifAppException((Throwable) null))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("cause cannot be null");
    }

    @Test
    @DisplayName("getErrorCode() → non-null derived code")
    void getErrorCode_shouldReturnNonNull() {
        CertifAppException ex = new CertifAppException("test");
        assertThat(ex.getErrorCode()).isNotNull().isNotBlank();
    }

    @Test
    @DisplayName("is instance of RuntimeException")
    void shouldBeRuntimeException() {
        assertThat(new CertifAppException("test")).isInstanceOf(RuntimeException.class);
    }
}
