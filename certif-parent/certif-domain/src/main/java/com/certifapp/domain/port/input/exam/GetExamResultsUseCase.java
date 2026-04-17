// certif-parent/certif-domain/src/main/java/com/certifapp/domain/port/input/exam/GetExamResultsUseCase.java
package com.certifapp.domain.port.input.exam;

import com.certifapp.domain.model.session.ExamSession;

import java.util.UUID;

/**
 * Use case: retrieve the full results of a completed exam session.
 */
public interface GetExamResultsUseCase {
    /**
     * @param sessionId target session UUID
     * @param userId    requesting user (ownership check)
     * @return the completed {@link ExamSession} with all answers and scores
     * @throws com.certifapp.domain.exception.ExamSessionNotFoundException if not found
     */
    ExamSession execute(UUID sessionId, UUID userId);
}
