```java
package com.certifapp.domain.port.input.session;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class GetSessionHistoryUseCaseTest {

    @Mock
    private ExamSessionRepository examSessionRepository;

    @InjectMocks
    private GetSessionHistoryUseCase getSessionHistoryUseCase;

    private UUID userId = UUID.randomUUID();
    private HistoryFilter filter;
    private int page = 0;
    private int size = 10;

    @BeforeEach
    public void setUp() {
        filter = HistoryFilter.noFilter();
    }

    @Test
    @DisplayName("Should retrieve session history for given user and filter with default pagination")
    public void execute_nominalCase_expectedSessionsRetrieved() {
        List<ExamSession> expectedSessions = List.of(new ExamSession(), new ExamSession());
        when(examSessionRepository.findByUserAndFilter(any(UUID.class), any(HistoryFilter.class), eq(page), eq(size)))
                .thenReturn(expectedSessions);

        List<ExamSession> result = getSessionHistoryUseCase.execute(userId, filter, page, size);

        assertThat(result).isEqualTo(expectedSessions);
        verify(examSessionRepository, times(1))
                .findByUserAndFilter(eq(userId), eq(filter), eq(page), eq(size));
    }

    @Test
    @DisplayName("Should retrieve all sessions when no pagination is provided")
    public void execute_noPagination_expectedAllSessionsRetrieved() {
        List<ExamSession> expectedSessions = List.of(new ExamSession(), new ExamSession());
        when(examSessionRepository.findByUserAndFilter(any(UUID.class), any(HistoryFilter.class), eq(0), eq(Integer.MAX_VALUE)))
                .thenReturn(expectedSessions);

        int page = 0;
        int size = Integer.MAX_VALUE;

        List<ExamSession> result = getSessionHistoryUseCase.execute(userId, filter, page, size);

        assertThat(result).isEqualTo(expectedSessions);
        verify(examSessionRepository, times(1))
                .findByUserAndFilter(eq(userId), eq(filter), eq(page), eq(size));
    }

    @Test
    @DisplayName("Should handle negative page number gracefully")
    public void execute_negativePage_expectedDefaultPagination() {
        List<ExamSession> expectedSessions = List.of(new ExamSession(), new ExamSession());
        when(examSessionRepository.findByUserAndFilter(any(UUID.class), any(HistoryFilter.class), eq(0), eq(size)))
                .thenReturn(expectedSessions);

        int page = -1;

        List<ExamSession> result = getSessionHistoryUseCase.execute(userId, filter, page, size);

        assertThat(result).isEqualTo(expectedSessions);
        verify(examSessionRepository, times(1))
                .findByUserAndFilter(eq(userId), eq(filter), eq(0), eq(size));
    }

    @Test
    @DisplayName("Should handle negative page size gracefully")
    public void execute_negativePageSize_expectedDefaultPagination() {
        List<ExamSession> expectedSessions = List.of(new ExamSession(), new ExamSession());
        when(examSessionRepository.findByUserAndFilter(any(UUID.class), any(HistoryFilter.class), eq(page), eq(Integer.MAX_VALUE)))
                .thenReturn(expectedSessions);

        int size = -1;

        List<ExamSession> result = getSessionHistoryUseCase.execute(userId, filter, page, size);

        assertThat(result).isEqualTo(expectedSessions);
        verify(examSessionRepository, times(1))
                .findByUserAndFilter(eq(userId), eq(filter), eq(page), eq(Integer.MAX_VALUE));
    }

    @Test
    @DisplayName("Should handle large page size gracefully")
    public void execute_largePageSize_expectedDefaultPagination() {
        List<ExamSession> expectedSessions = List.of(new ExamSession(), new ExamSession());
        when(examSessionRepository.findByUserAndFilter(any(UUID.class), any(HistoryFilter.class), eq(page), eq(Integer.MAX_VALUE)))
                .thenReturn(expectedSessions);

        int size = 1001;

        List<ExamSession> result = getSessionHistoryUseCase.execute(userId, filter, page, size);

        assertThat(result).isEqualTo(expectedSessions);
        verify(examSessionRepository, times(1))
                .findByUserAndFilter(eq(userId), eq(filter), eq(page), eq(Integer.MAX_VALUE));
    }

    @Test
    @DisplayName("Should handle null filter gracefully")
    public void execute_nullFilter_expectedAllSessionsRetrieved() {
        List<ExamSession> expectedSessions = List.of(new ExamSession(), new ExamSession());
        when(examSessionRepository.findByUserAndFilter(any(UUID.class), eq(HistoryFilter.noFilter()), eq(page), eq(size)))
                .thenReturn(expectedSessions);

        HistoryFilter filter = null;

        List<ExamSession> result = getSessionHistoryUseCase.execute(userId, filter, page, size);

        assertThat(result).isEqualTo(expectedSessions);
        verify(examSessionRepository, times(1))
                .findByUserAndFilter(eq(userId), eq(HistoryFilter.noFilter()), eq(page), eq(size));
    }

    @Test
    @DisplayName("Should handle null user ID gracefully")
    public void execute_nullUserId_expectedException() {
        List<ExamSession> expectedSessions = List.of(new ExamSession(), new ExamSession());
        when(examSessionRepository.findByUserAndFilter(eq(UUID.randomUUID()), any(HistoryFilter.class), eq(page), eq(size)))
                .thenReturn(expectedSessions);

        UUID userId = null;

        assertThatThrownBy(() -> getSessionHistoryUseCase.execute(userId, filter, page, size))
                .isInstanceOf(NullPointerException.class);
    }
}
```
