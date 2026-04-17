// certif-parent/certif-domain/src/main/java/com/certifapp/domain/port/input/exam/SubmitExamUseCase.java
package com.certifapp.domain.port.input.exam;

import com.certifapp.domain.model.session.ExamSession;

import java.util.UUID;

/**
 * Use case: finalise an exam session, calculate and persist the score.
 *
 * <p>Canonical scoring: {@code percentage = correctCount * 100.0 / totalQuestions}
 * {@code passed = percentage >= certification.passingScore()}</p>
 */
public interface SubmitExamUseCase {

    /**
     * Closes the session, calculates scores and marks it as COMPLETED.
     *
     * @param sessionId the session to close
     * @param userId    the submitting user (ownership check)
     * @return the updated {@link ExamSession} with final scores
     * @throws com.certifapp.domain.exception.ExamSessionNotFoundException  if not found
     * @throws com.certifapp.domain.exception.ExamAlreadyCompletedException if already closed
     */
    ExamSession execute(UUID sessionId, UUID userId);
}
