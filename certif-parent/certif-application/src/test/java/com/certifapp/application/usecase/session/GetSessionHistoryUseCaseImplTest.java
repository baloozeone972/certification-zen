// certif-parent/certif-application/src/test/java/com/certifapp/application/usecase/session/GetSessionHistoryUseCaseImplTest.java
package com.certifapp.application.usecase.session;

import com.certifapp.domain.model.session.ExamSession;
import com.certifapp.domain.port.output.ExamSessionRepository;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.*;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("GetSessionHistoryUseCaseImpl")
class GetSessionHistoryUseCaseImplTest {

    @Mock  ExamSessionRepository sessionRepository;
    @InjectMocks GetSessionHistoryUseCaseImpl useCase;

    private static final UUID USER_ID = UUID.randomUUID();

    @Test @DisplayName("execute — delegates to repository with correct parameters")
    void execute_delegatesToRepository() {
        when(sessionRepository.findByUserId(any(), any(), any(), any(), any(), anyInt(), anyInt()))
            .thenReturn(List.of());

        var filter = new GetSessionHistoryUseCaseImpl.HistoryFilter(null, null, null, null);
        List<ExamSession> result = useCase.execute(USER_ID, filter, 0, 20);

        assertThat(result).isEmpty();
        verify(sessionRepository).findByUserId(eq(USER_ID), any(), any(), any(), any(), eq(0), eq(20));
    }

    @Test @DisplayName("execute — negative page clamped to 0")
    void execute_negativePage_clampedToZero() {
        when(sessionRepository.findByUserId(any(), any(), any(), any(), any(), anyInt(), anyInt()))
            .thenReturn(List.of());
        var filter = new GetSessionHistoryUseCaseImpl.HistoryFilter(null, null, null, null);
        useCase.execute(USER_ID, filter, -5, 10);
        verify(sessionRepository).findByUserId(any(), any(), any(), any(), any(), eq(0), eq(10));
    }

    @Test @DisplayName("execute — oversized page defaults to 20")
    void execute_oversizedPage_defaultsTo20() {
        when(sessionRepository.findByUserId(any(), any(), any(), any(), any(), anyInt(), anyInt()))
            .thenReturn(List.of());
        var filter = new GetSessionHistoryUseCaseImpl.HistoryFilter(null, null, null, null);
        useCase.execute(USER_ID, filter, 0, 9999);
        verify(sessionRepository).findByUserId(any(), any(), any(), any(), any(), eq(0), eq(20));
    }
}
