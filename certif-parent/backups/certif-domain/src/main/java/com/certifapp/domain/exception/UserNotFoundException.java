// certif-parent/certif-domain/src/main/java/com/certifapp/domain/exception/UserNotFoundException.java
package com.certifapp.domain.exception;

/**
 * Thrown when a user with the given id or email does not exist.
 */
public class UserNotFoundException extends CertifAppException {

    public UserNotFoundException(String identifier) {
        super("User not found: " + identifier);
    }
}
