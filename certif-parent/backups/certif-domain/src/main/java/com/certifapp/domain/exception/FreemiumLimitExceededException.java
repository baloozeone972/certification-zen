// certif-parent/certif-domain/src/main/java/com/certifapp/domain/exception/FreemiumLimitExceededException.java
package com.certifapp.domain.exception;

/**
 * Thrown when a FREE-tier user exceeds their daily exam or question limit.
 */
public class FreemiumLimitExceededException extends CertifAppException {

    public FreemiumLimitExceededException(String message) {
        super(message);
    }

    public static FreemiumLimitExceededException dailyExams() {
        return new FreemiumLimitExceededException(
                "FREE tier: maximum 2 exams per day per certification reached");
    }

    public static FreemiumLimitExceededException questionCount() {
        return new FreemiumLimitExceededException(
                "FREE tier: maximum 20 questions per session");
    }
}
