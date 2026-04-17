// certif-parent/certif-domain/src/main/java/com/certifapp/domain/exception/ExamAlreadyCompletedException.java
package com.certifapp.domain.exception;

/**
 * Thrown when trying to submit or answer a session that is already completed.
 */
public class ExamAlreadyCompletedException extends CertifAppException {

    private final java.util.UUID sessionId;

    public ExamAlreadyCompletedException(java.util.UUID sessionId) {
        super("Exam session already completed: " + sessionId);
        this.sessionId = sessionId;
    }

    public java.util.UUID getSessionId() {
        return sessionId;
    }
}
