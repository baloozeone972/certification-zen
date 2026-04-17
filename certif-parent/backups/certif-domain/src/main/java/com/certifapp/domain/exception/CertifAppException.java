// certif-parent/certif-domain/src/main/java/com/certifapp/domain/exception/CertifAppException.java
package com.certifapp.domain.exception;

/**
 * Base unchecked exception for all CertifApp domain errors.
 * All domain exceptions must extend this class to allow unified handling
 * in the API layer via {@code GlobalExceptionHandler}.
 */
public class CertifAppException extends RuntimeException {

    /** Error code for structured API error responses. */
    private final String errorCode;

    /**
     * Constructs a domain exception with a human-readable message.
     *
     * @param message error description (exposed in API error response)
     */
    public CertifAppException(String message) {
        super(message);
        this.errorCode = this.getClass().getSimpleName()
                .replace("Exception", "")
                .toUpperCase();
    }

    /**
     * Constructs a domain exception with a message and a root cause.
     *
     * @param message error description
     * @param cause   root cause (not propagated to client responses)
     */
    public CertifAppException(String message, Throwable cause) {
        super(message, cause);
        this.errorCode = this.getClass().getSimpleName()
                .replace("Exception", "")
                .toUpperCase();
    }

    /**
     * Returns the machine-readable error code derived from the class name.
     * Example: {@code FreemiumLimitExceededException} → {@code "FREEMIUM_LIMIT_EXCEEDED"} (after mapping).
     *
     * @return error code string
     */
    public String getErrorCode() {
        return errorCode;
    }
}