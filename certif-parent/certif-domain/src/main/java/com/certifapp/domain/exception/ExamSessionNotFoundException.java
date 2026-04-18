// certif-parent/certif-domain/src/main/java/com/certifapp/domain/exception/ExamSessionNotFoundException.java
package com.certifapp.domain.exception;

/**
 * Thrown when an exam session with the given UUID does not exist.
 */
public record ExamSessionNotFoundException(java.util.UUID sessionId) extends CertifAppException {

    public ExamSessionNotFoundException {
        super("Exam session not found: " + sessionId);
    }
}