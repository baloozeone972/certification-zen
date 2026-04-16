// certif-parent/certif-domain/src/main/java/com/certifapp/domain/exception/CertificationNotFoundException.java
package com.certifapp.domain.exception;

/**
 * Thrown when a certification with the given id does not exist.
 */
public class CertificationNotFoundException extends CertifAppException {

    private final String certificationId;
    public CertificationNotFoundException(String certificationId) {
        super("Certification not found: " + certificationId);
        this.certificationId = certificationId;
    }
    public String getCertificationId() { return certificationId; }
}
