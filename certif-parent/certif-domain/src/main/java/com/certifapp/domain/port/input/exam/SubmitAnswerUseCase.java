// certif-parent/certif-domain/src/main/java/com/certifapp/domain/port/input/exam/SubmitAnswerUseCase.java
package com.certifapp.domain.port.input.exam;

import com.certifapp.domain.model.session.UserAnswer;

import java.util.UUID;

/**
 * Use case: record a single answer during an in-progress exam session.
 */
public interface SubmitAnswerUseCase {

    /**
     * Persists the answer and returns it with the {@code isCorrect} flag set.
     *
     * @param command answer data
     * @return the persisted {@link UserAnswer} with correctness evaluated
     * @throws com.certifapp.domain.exception.ExamSessionNotFoundException  if session not found
     * @throws com.certifapp.domain.exception.ExamAlreadyCompletedException if session is closed
     */
    UserAnswer execute(SubmitAnswerCommand command);

    /**
     * Command for one answer submission.
     *
     * @param sessionId        the session UUID
     * @param userId           the answering user (ownership check)
     * @param questionId       the answered question UUID
     * @param selectedOptionId the chosen option UUID — null means skip
     * @param responseTimeMs   time taken to answer in milliseconds
     */
    record SubmitAnswerCommand(
            UUID sessionId,
            UUID userId,
            UUID questionId,
            UUID selectedOptionId,
            long responseTimeMs
    ) {
    }
}
