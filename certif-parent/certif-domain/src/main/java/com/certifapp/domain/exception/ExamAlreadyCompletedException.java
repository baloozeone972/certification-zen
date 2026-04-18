// certif-parent/certif-domain/src/main/java/com/certifapp/domain/exception/ExamAlreadyCompletedException.java
package com.certifapp.domain.exception;

/**
 * Thrown when trying to submit or answer a session that is already completed.
 */
public record ExamAlreadyCompletedException(java.util.UUID sessionId) extends CertifAppException {

    public ExamAlreadyCompletedException {
        super("Exam session already completed: " + sessionId);
    }
}