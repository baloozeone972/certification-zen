// certif-parent/certif-domain/src/main/java/com/certifapp/domain/port/input/session/GetSessionHistoryUseCase.java
package com.certifapp.domain.port.input.session;

import com.certifapp.domain.model.session.ExamMode;
import com.certifapp.domain.model.session.ExamSession;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

/**
 * Use case: retrieve paginated exam session history for one user.
 */
public interface GetSessionHistoryUseCase {

    /**
     * Optional filter criteria for session history.
     *
     * @param certificationId filter by certification (null = all)
     * @param mode            filter by exam mode (null = all)
     * @param from            start date inclusive (null = no lower bound)
     * @param to              end date inclusive (null = no upper bound)
     */
    record HistoryFilter(String certificationId, ExamMode mode, LocalDate from, LocalDate to) {
        public static HistoryFilter noFilter() {
            return new HistoryFilter(null, null, null, null);
        }
    }

    /**
     * @param userId   the user whose history is requested
     * @param filter   optional filter criteria
     * @param page     0-based page number
     * @param size     page size (max 100)
     * @return page of sessions ordered by startedAt descending
     */
    List<ExamSession> execute(UUID userId, HistoryFilter filter, int page, int size);
}
