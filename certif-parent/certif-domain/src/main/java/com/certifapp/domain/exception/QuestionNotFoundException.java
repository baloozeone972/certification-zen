// certif-parent/certif-domain/src/main/java/com/certifapp/domain/exception/QuestionNotFoundException.java
package com.certifapp.domain.exception;

/**
 * Thrown when a question with the given UUID does not exist.
 */
public record QuestionNotFoundException(java.util.UUID questionId) extends CertifAppException {

    public QuestionNotFoundException {
        super("Question not found: " + questionId);
    }
}