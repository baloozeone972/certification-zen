// certif-parent/certif-application/src/main/java/com/certifapp/application/usecase/session/GetUserProgressUseCaseImpl.java
package com.certifapp.application.usecase.session;

import com.certifapp.domain.model.session.ExamSession;
import com.certifapp.domain.port.output.ExamSessionRepository;

import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * Computes aggregated progress statistics for a user and certification.
 *
 * <p>This is intentionally kept as a simple computation on the domain model —
 * no JPQL aggregation queries, ensuring the domain remains testable in isolation.</p>
 */
public class GetUserProgressUseCaseImpl {

    private final ExamSessionRepository sessionRepository;

    public GetUserProgressUseCaseImpl(ExamSessionRepository sessionRepository) {
        this.sessionRepository = sessionRepository;
    }

    /**
     * Returns aggregated statistics: total sessions, best score, average, pass rate.
     *
     * @param userId          the user
     * @param certificationId target certification
     * @return map of metric name → value (bestScore, averageScore, passRate, totalSessions)
     */
    public Map<String, Double> execute(UUID userId, String certificationId) {
        List<ExamSession> sessions = sessionRepository.findByUserId(
                userId, certificationId, null, null, null, 0, 1000);

        if (sessions.isEmpty()) {
            return Map.of("totalSessions", 0.0, "bestScore", 0.0,
                    "averageScore", 0.0, "passRate", 0.0);
        }

        var finishedSessions = sessions.stream()
                .filter(s -> s.status().isFinished()).toList();

        if (finishedSessions.isEmpty()) {
            return Map.of("totalSessions", (double) sessions.size(),
                    "bestScore", 0.0, "averageScore", 0.0, "passRate", 0.0);
        }

        double best = finishedSessions.stream().mapToDouble(ExamSession::percentage).max().orElse(0);
        double avg = finishedSessions.stream().mapToDouble(ExamSession::percentage).average().orElse(0);
        long passed = finishedSessions.stream().filter(ExamSession::passed).count();
        double passRate = (double) passed / finishedSessions.size() * 100.0;

        return Map.of(
                "totalSessions", (double) finishedSessions.size(),
                "bestScore", best,
                "averageScore", avg,
                "passRate", passRate
        );
    }
}
