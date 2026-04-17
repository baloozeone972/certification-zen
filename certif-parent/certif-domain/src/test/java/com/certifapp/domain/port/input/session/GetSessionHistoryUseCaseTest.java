package com.certifapp.domain.port.input.session;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

public class GetSessionHistoryUseCaseTest {

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

        List<ExamSession> result = getSessionHistoryUseCase.execute(userId, filter, page, size);

        assertThat(result).isEqualTo(expectedSessions);
    }

    @Test
    @DisplayName("Should retrieve all sessions when no pagination is provided")
    public void execute_noPagination_expectedAllSessionsRetrieved() {
        List<ExamSession> expectedSessions = List.of(new ExamSession(), new ExamSession());

        int page = 0;
        int size = Integer.MAX_VALUE;

        List<ExamSession> result = getSessionHistoryUseCase.execute(userId, filter, page, size);

        assertThat(result).isEqualTo(expectedSessions);
    }

    @Test
    @DisplayName("Should handle negative page number gracefully")
    public void execute_negativePage_expectedDefaultPagination() {
        List<ExamSession> expectedSessions = List.of(new ExamSession(), new ExamSession());

        int page = -1;

        List<ExamSession> result = getSessionHistoryUseCase.execute(userId, filter, page, size);

        assertThat(result).isEqualTo(expectedSessions);
    }

    @Test
    @DisplayName("Should handle negative page size gracefully")
    public void execute_negativePageSize_expectedDefaultPagination() {
        List<ExamSession> expectedSessions = List.of(new ExamSession(), new ExamSession());

        int size = -1;

        List<ExamSession> result = getSessionHistoryUseCase.execute(userId, filter, page, size);

        assertThat(result).isEqualTo(expectedSessions);
    }

    @Test
    @DisplayName("Should handle large page size gracefully")
    public void execute_largePageSize_expectedDefaultPagination() {
        List<ExamSession> expectedSessions = List.of(new ExamSession(), new ExamSession());

        int size = 1001;

        List<ExamSession> result = getSessionHistoryUseCase.execute(userId, filter, page, size);

        assertThat(result).isEqualTo(expectedSessions);
    }

    @Test
    @DisplayName("Should handle null filter gracefully")
    public void execute_nullFilter_expectedAllSessionsRetrieved() {
        List<ExamSession> expectedSessions = List.of(new ExamSession(), new ExamSession());

        HistoryFilter filter = null;

        List<ExamSession> result = getSessionHistoryUseCase.execute(userId, filter, page, size);

        assertThat(result).isEqualTo(expectedSessions);
    }

    @Test
    @DisplayName("Should handle null user ID gracefully")
    public void execute_nullUserId_expectedException() {
        assertThatThrownBy(() -> getSessionHistoryUseCase.execute(null, filter, page, size))
                .isInstanceOf(NullPointerException.class);
    }
}