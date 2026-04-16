```java
package com.certifapp.application.usecase.session;

import com.certifapp.domain.model.session.ExamSession;
import com.certifapp.domain.port.input.session.GetSessionHistoryUseCase;
import com.certifapp.domain.port.output.ExamSessionRepository;
import com.certifapp.domain.port.output.UserAnswerRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;

import java.time.LocalDateTime;
import java.util.*;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class GetUserProgressUseCaseImplTest {

    @Mock
    private ExamSessionRepository sessionRepository;

    @InjectMocks
    private GetUserProgressUseCaseImpl getUserProgressUseCase;

    @BeforeEach
    public void setUp() {
        // Setup code if needed
    }

    @Test
    @DisplayName("Nominal case: user has sessions")
    public void execute_userHasSessions_expectedProgressMetrics() {
        UUID userId = UUID.randomUUID();
        String certificationId = "cert123";
        List<ExamSession> sessions = Arrays.asList(
                new ExamSession(UUID.randomUUID(), LocalDateTime.now(), userId, 85.0, true),
                new ExamSession(UUID.randomUUID(), LocalDateTime.now(), userId, 75.0, false)
        );

        when(sessionRepository.findByUserId(userId, certificationId, null, null, null, 0, 1000))
                .thenReturn(sessions);

        Map<String, Double> result = getUserProgressUseCase.execute(userId, certificationId);

        assertThat(result.get("totalSessions")).isEqualTo(2.0);
        assertThat(result.get("bestScore")).isEqualTo(85.0);
        assertThat(result.get("averageScore")).isEqualTo(80.0);
        assertThat(result.get("passRate")).isEqualTo(50.0);
    }

    @Test
    @DisplayName("Edge case: no sessions for user")
    public void execute_noSessionsForUser_expectedZeroMetrics() {
        UUID userId = UUID.randomUUID();
        String certificationId = "cert123";

        when(sessionRepository.findByUserId(userId, certificationId, null, null, null, 0, 1000))
                .thenReturn(Collections.emptyList());

        Map<String, Double> result = getUserProgressUseCase.execute(userId, certificationId);

        assertThat(result.get("totalSessions")).isEqualTo(0.0);
        assertThat(result.get("bestScore")).isEqualTo(0.0);
        assertThat(result.get("averageScore")).isEqualTo(0.0);
        assertThat(result.get("passRate")).isEqualTo(0.0);
    }

    @Test
    @DisplayName("Edge case: no finished sessions")
    public void execute_noFinishedSessions_expectedNonZeroMetrics() {
        UUID userId = UUID.randomUUID();
        String certificationId = "cert123";
        List<ExamSession> sessions = Arrays.asList(
                new ExamSession(UUID.randomUUID(), LocalDateTime.now(), userId, 85.0, false),
                new ExamSession(UUID.randomUUID(), LocalDateTime.now(), userId, 75.0, false)
        );

        when(sessionRepository.findByUserId(userId, certificationId, null, null, null, 0, 1000))
                .thenReturn(sessions);

        Map<String, Double> result = getUserProgressUseCase.execute(userId, certificationId);

        assertThat(result.get("totalSessions")).isEqualTo(2.0);
        assertThat(result.get("bestScore")).isEqualTo(85.0);
        assertThat(result.get("averageScore")).isEqualTo(80.0);
        assertThat(result.get("passRate")).isEqualTo(0.0);
    }

    @Test
    @DisplayName("Error case: repository throws exception")
    public void execute_repositoryThrowsException_expectedException() {
        UUID userId = UUID.randomUUID();
        String certificationId = "cert123";

        when(sessionRepository.findByUserId(userId, certificationId, null, null, null, 0, 1000))
                .thenThrow(new RuntimeException("Simulated repository error"));

        assertThatThrownBy(() -> getUserProgressUseCase.execute(userId, certificationId))
                .isInstanceOf(RuntimeException.class)
                .hasMessageContaining("Simulated repository error");
    }
}
```
