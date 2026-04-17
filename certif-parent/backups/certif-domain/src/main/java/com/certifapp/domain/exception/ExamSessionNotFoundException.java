// certif-parent/certif-domain/src/main/java/com/certifapp/domain/exception/ExamSessionNotFoundException.java
package com.certifapp.domain.exception;

/**
 * Thrown when an exam session with the given UUID does not exist.
 */
public class ExamSessionNotFoundException extends CertifAppException {

    private final java.util.UUID sessionId;

    public ExamSessionNotFoundException(java.util.UUID sessionId) {
        super("Exam session not found: " + sessionId);
        this.sessionId = sessionId;
    }

    public java.util.UUID getSessionId() {
        return sessionId;
    }
}
