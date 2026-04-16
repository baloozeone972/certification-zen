// certif-parent/certif-domain/src/main/java/com/certifapp/domain/exception/InvalidCredentialsException.java
package com.certifapp.domain.exception;

/**
 * Thrown when email/password authentication fails.
 */
public class InvalidCredentialsException extends CertifAppException {

    public InvalidCredentialsException() {
        super("Invalid email or password");
    }
}
