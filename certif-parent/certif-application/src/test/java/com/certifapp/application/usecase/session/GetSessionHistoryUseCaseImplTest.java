```java
package com.certifapp.application.usecase.session;

import com.certifapp.domain.model.session.ExamSession;
import com.certifapp.domain.port.input.session.GetSessionHistoryUseCase;
import com.certifapp.domain.port.output.ExamSessionRepository;
import com.certifapp.util.HistoryFilter;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class GetSessionHistoryUseCaseImplTest {

    @Mock
    private ExamSessionRepository sessionRepository;

    @InjectMocks
    private GetSessionHistoryUseCase useCase;

    private UUID userId;
    private HistoryFilter filter;
    private int page;
    private int size;

    @BeforeEach
    public void setUp() {
        userId = UUID.randomUUID();
        filter = new HistoryFilter(UUID.randomUUID(), "mode", LocalDateTime.now().minusDays(30), LocalDateTime.now());
        page = 1;
        size = 10;
    }

    @Test
    @DisplayName("Should return session history for user with valid input")
    public void getExamSessionHistoryForUser_validInput_returnSessionHistory() {
        List<ExamSession> expectedSessions = Arrays.asList(new ExamSession(), new ExamSession());
        when(sessionRepository.findByUserId(
                eq(userId),
                eq(filter.certificationId()),
                eq(filter.mode()),
                eq(filter.from()),
                eq(filter.to()),
                eq(0),
                eq(size)))
                .thenReturn(expectedSessions);

        List<ExamSession> result = useCase.execute(userId, filter, page, size);

        assertThat(result).isEqualTo(expectedSessions);
        verify(sessionRepository, times(1)).findByUserId(
                eq(userId),
                eq(filter.certificationId()),
                eq(filter.mode()),
                eq(filter.from()),
                eq(filter.to()),
                eq(0),
                eq(size));
    }

    @Test
    @DisplayName("Should handle negative page and zero size input")
    public void getExamSessionHistoryForUser_negativePageAndZeroSize_inputHandledCorrectly() {
        List<ExamSession> expectedSessions = Arrays.asList(new ExamSession(), new ExamSession());
        when(sessionRepository.findByUserId(
                eq(userId),
                eq(filter.certificationId()),
                eq(filter.mode()),
                eq(filter.from()),
                eq(filter.to()),
                eq(0),
                eq(20)))
                .thenReturn(expectedSessions);

        List<ExamSession> result = useCase.execute(userId, filter, -1, 0);

        assertThat(result).isEqualTo(expectedSessions);
        verify(sessionRepository, times(1)).findByUserId(
                eq(userId),
                eq(filter.certificationId()),
                eq(filter.mode()),
                eq(filter.from()),
                eq(filter.to()),
                eq(0),
                eq(20));
    }

    @Test
    @DisplayName("Should handle large size input")
    public void getExamSessionHistoryForUser_largeSizeInput_inputHandledCorrectly() {
        List<ExamSession> expectedSessions = Arrays.asList(new ExamSession(), new ExamSession());
        when(sessionRepository.findByUserId(
                eq(userId),
                eq(filter.certificationId()),
                eq(filter.mode()),
                eq(filter.from()),
                eq(filter.to()),
                eq(0),
                eq(20)))
                .thenReturn(expectedSessions);

        List<ExamSession> result = useCase.execute(userId, filter, 1, 150);

        assertThat(result).isEqualTo(expectedSessions);
        verify(sessionRepository, times(1)).findByUserId(
                eq(userId),
                eq(filter.certificationId()),
                eq(filter.mode()),
                eq(filter.from()),
                eq(filter.to()),
                eq(0),
                eq(20));
    }

    @Test
    @DisplayName("Should handle null filter input")
    public void getExamSessionHistoryForUser_nullFilterInput_inputHandledCorrectly() {
        HistoryFilter nullFilter = null;
        List<ExamSession> expectedSessions = Arrays.asList(new ExamSession(), new ExamSession());
        when(sessionRepository.findByUserId(
                eq(userId),
                eq(UUID.randomUUID()),
                eq("mode"),
                eq(LocalDateTime.now().minusDays(30)),
                eq(LocalDateTime.now()),
                eq(0),
                eq(20)))
                .thenReturn(expectedSessions);

        List<ExamSession> result = useCase.execute(userId, nullFilter, page, size);

        assertThat(result).isEqualTo(expectedSessions);
        verify(sessionRepository, times(1)).findByUserId(
                eq(userId),
                eq(UUID.randomUUID()),
                eq("mode"),
                eq(LocalDateTime.now().minusDays(30)),
                eq(LocalDateTime.now()),
                eq(0),
                eq(20));
    }

    @Test
    @DisplayName("Should handle null user id input")
    public void getExamSessionHistoryForUser_nullUserIdInput_inputHandledCorrectly() {
        UUID nullUserId = null;
        HistoryFilter nullFilter = new HistoryFilter(UUID.randomUUID(), "mode", LocalDateTime.now().minusDays(30), LocalDateTime.now());
        List<ExamSession> expectedSessions = Arrays.asList(new ExamSession(), new ExamSession());
        when(sessionRepository.findByUserId(
                eq(null),
                eq(nullFilter.certificationId()),
                eq(nullFilter.mode()),
                eq(nullFilter.from()),
                eq(nullFilter.to()),
                eq(0),
                eq(20)))
                .thenReturn(expectedSessions);

        List<ExamSession> result = useCase.execute(nullUserId, nullFilter, page, size);

        assertThat(result).isEqualTo(expectedSessions);
        verify(sessionRepository, times(1)).findByUserId(
                eq(null),
                eq(nullFilter.certificationId()),
                eq(nullFilter.mode()),
                eq(nullFilter.from()),
                eq(nullFilter.to()),
                eq(0),
                eq(20));
    }
}
```
