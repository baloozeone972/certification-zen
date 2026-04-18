// certif-parent/certif-domain/src/main/java/com/certifapp/domain/exception/UserNotFoundException.java
package com.certifapp.domain.exception;

/**
 * Thrown when a user with the given id or email does not exist.
 */
public record UserNotFoundException(String identifier) extends CertifAppException {
    public UserNotFoundException {
        super("User not found: " + identifier);
    }
}