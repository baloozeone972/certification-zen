// certif-parent/certif-domain/src/main/java/com/certifapp/domain/exception/CertificationNotFoundException.java
package com.certifapp.domain.exception;

/**
 * Thrown when a certification with the given id does not exist.
 */
public record CertificationNotFoundException(String certificationId) extends CertifAppException {

    public CertificationNotFoundException {
        super("Certification not found: " + certificationId);
    }
}