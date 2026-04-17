// certif-domain/src/main/java/com/certifapp/domain/model/session/SessionStatus.java
package com.certifapp.domain.model.session;

/**
 * Lifecycle status of an {@link ExamSession}.
 *
 * <p>Maps to the {@code status VARCHAR(20)} column in {@code exam_sessions}.</p>
 */
public enum SessionStatus {

    /**
     * Session started — questions served, answers being collected.
     */
    IN_PROGRESS,

    /**
     * Session explicitly submitted by the user or by the server after timer expiry.
     */
    COMPLETED,

    /**
     * User left the session without submitting — score not calculated.
     */
    ABANDONED,

    /**
     * Server-side timer reached zero and the system auto-submitted.
     * Treated identically to {@code COMPLETED} for scoring purposes.
     */
    EXPIRED;

    /**
     * Returns {@code true} if the session has been scored and is no longer modifiable.
     *
     * @return {@code true} for {@code COMPLETED} and {@code EXPIRED}
     */
    public boolean isFinished() {
        return switch (this) {
            case COMPLETED, EXPIRED -> true;
            case IN_PROGRESS, ABANDONED -> false;
        };
    }
}
