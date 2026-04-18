// certif-parent/certif-application/src/main/java/com/certifapp/application/usecase/exam/GetExamResultsUseCaseImpl.java
package com.certifapp.application.usecase.exam;

import com.certifapp.domain.exception.ExamSessionNotFoundException;
import com.certifapp.domain.model.session.ExamSession;
import com.certifapp.domain.port.input.exam.GetExamResultsUseCase;
import com.certifapp.domain.port.output.ExamSessionRepository;

import java.util.UUID;

/**
 * Implementation of {@link GetExamResultsUseCase}.
 */
public class GetExamResultsUseCaseImpl implements GetExamResultsUseCase {

    private final ExamSessionRepository sessionRepository;

    public GetExamResultsUseCaseImpl(ExamSessionRepository sessionRepository) {
        this.sessionRepository = sessionRepository;
    }

    @Override
    public ExamSession execute(UUID sessionId, UUID userId) {
        return sessionRepository.findById(sessionId)
                .filter(session -> session.userId().equals(userId))
                .orElseThrow(() -> new ExamSessionNotFoundException(sessionId));
    }
}