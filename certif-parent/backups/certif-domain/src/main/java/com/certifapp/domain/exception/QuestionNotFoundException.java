// certif-parent/certif-domain/src/main/java/com/certifapp/domain/exception/QuestionNotFoundException.java
package com.certifapp.domain.exception;

/**
 * Thrown when a question with the given UUID does not exist.
 */
public class QuestionNotFoundException extends CertifAppException {

    private final java.util.UUID questionId;

    public QuestionNotFoundException(java.util.UUID questionId) {
        super("Question not found: " + questionId);
        this.questionId = questionId;
    }

    public java.util.UUID getQuestionId() {
        return questionId;
    }
}
