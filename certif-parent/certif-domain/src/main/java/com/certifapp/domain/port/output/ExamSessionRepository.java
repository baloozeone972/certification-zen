// certif-parent/certif-domain/src/main/java/com/certifapp/domain/port/output/ExamSessionRepository.java
package com.certifapp.domain.port.output;

import com.certifapp.domain.model.session.ExamSession;
import com.certifapp.domain.model.session.ExamMode;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

/** Output port: persistence operations for {@link ExamSession}. */
public interface ExamSessionRepository {
    Optional<ExamSession> findById(UUID id);
    /** Count exams started by a user today for a given certification (for freemium guard). */
    int countTodayByUserAndCertification(UUID userId, String certificationId, ExamMode mode);
    List<ExamSession>     findByUserId(UUID userId, String certificationId,
                                       ExamMode mode, LocalDate from, LocalDate to,
                                       int page, int size);
    ExamSession           save(ExamSession session);
}
