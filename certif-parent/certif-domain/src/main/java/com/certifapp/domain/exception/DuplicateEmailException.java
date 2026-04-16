// certif-parent/certif-domain/src/main/java/com/certifapp/domain/exception/DuplicateEmailException.java
package com.certifapp.domain.exception;

/**
 * Thrown when attempting to register with an email already in use.
 */
public class DuplicateEmailException extends CertifAppException {

    public DuplicateEmailException(String email) {
        super("Email already registered: " + email);
    }
}
