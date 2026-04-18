// certif-parent/certif-domain/src/main/java/com/certifapp/domain/exception/InvalidCredentialsException.java
package com.certifapp.domain.exception;

/**
 * Thrown when email/password authentication fails.
 */
public record InvalidCredentialsException(String message) extends CertifAppException {
    public InvalidCredentialsException() {
        this("Invalid email or password");
    }
}