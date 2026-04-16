// certif-parent/certif-application/src/main/java/com/certifapp/application/usecase/session/GetSessionHistoryUseCaseImpl.java
package com.certifapp.application.usecase.session;

import com.certifapp.domain.model.session.ExamSession;
import com.certifapp.domain.port.input.session.GetSessionHistoryUseCase;
import com.certifapp.domain.port.output.ExamSessionRepository;

import java.util.List;
import java.util.UUID;

/**
 * Implementation of {@link GetSessionHistoryUseCase}.
 */
public class GetSessionHistoryUseCaseImpl implements GetSessionHistoryUseCase {

    private final ExamSessionRepository sessionRepository;

    public GetSessionHistoryUseCaseImpl(ExamSessionRepository sessionRepository) {
        this.sessionRepository = sessionRepository;
    }

    @Override
    public List<ExamSession> execute(UUID userId, HistoryFilter filter, int page, int size) {
        int effectivePage = Math.max(0, page);
        int effectiveSize = (size <= 0 || size > 100) ? 20 : size;

        return sessionRepository.findByUserId(
                userId,
                filter.certificationId(),
                filter.mode(),
                filter.from(),
                filter.to(),
                effectivePage,
                effectiveSize);
    }
}
