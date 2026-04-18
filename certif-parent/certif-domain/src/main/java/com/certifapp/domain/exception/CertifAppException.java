// certif-parent/certif-domain/src/main/java/com/certifapp/domain/exception/CertifAppException.java
package com.certifapp.domain.exception;

/**
 * Base unchecked exception for all CertifApp domain errors.
 * All domain exceptions extend this class to allow unified handling
 * in the API layer via {@code GlobalExceptionHandler}.
 */
public class CertifAppException extends RuntimeException {

    private final String errorCode;

    /** Default no-arg constructor. */
    public CertifAppException() {
        super("CertifApp error");
        this.errorCode = "CERTIF_APP_ERROR";
    }

    /**
     * Constructs with a message.
     * @param message error description
     * @throws IllegalArgumentException if message is null
     */
    public CertifAppException(String message) {
        super(message);
        if (message == null) throw new IllegalArgumentException("message cannot be null");
        this.errorCode = deriveErrorCode();
    }

    /**
     * Constructs with a root cause.
     * @param cause root cause
     * @throws IllegalArgumentException if cause is null
     */
    public CertifAppException(Throwable cause) {
        super(cause);
        if (cause == null) throw new IllegalArgumentException("cause cannot be null");
        this.errorCode = deriveErrorCode();
    }

    /**
     * Constructs with a message and root cause.
     * @param message error description
     * @param cause   root cause
     */
    public CertifAppException(String message, Throwable cause) {
        super(message, cause);
        this.errorCode = deriveErrorCode();
    }

    /** Returns the machine-readable error code derived from the class name. */
    public String getErrorCode() {
        return errorCode;
    }

    private String deriveErrorCode() {
        return getClass().getSimpleName()
                .replace("Exception", "")
                .toUpperCase();
    }
}
