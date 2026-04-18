// certif-parent/certif-application/src/test/java/com/certifapp/application/usecase/exam/GetExamResultsUseCaseImplTest.java
package com.certifapp.application.usecase.exam;

import com.certifapp.domain.exception.ExamSessionNotFoundException;
import com.certifapp.domain.model.session.*;
import com.certifapp.domain.port.output.ExamSessionRepository;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.OffsetDateTime;
import java.util.*;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("GetExamResultsUseCaseImpl")
class GetExamResultsUseCaseImplTest {

    @Mock  ExamSessionRepository sessionRepository;
    @InjectMocks GetExamResultsUseCaseImpl useCase;

    private static final UUID SESSION_ID = UUID.randomUUID();
    private static final UUID USER_ID    = UUID.randomUUID();

    private ExamSession buildSession() {
        return new ExamSession(SESSION_ID, USER_ID, "ocp21", ExamMode.EXAM,
                SessionStatus.COMPLETED, OffsetDateTime.now(), null, null,
                10, 7, 70.0, true, List.of());
    }

    @Test @DisplayName("execute — session found and owned by user → returns session")
    void execute_sessionFound_returnsSession() {
        ExamSession session = buildSession();
        when(sessionRepository.findById(SESSION_ID)).thenReturn(Optional.of(session));
        assertThat(useCase.execute(SESSION_ID, USER_ID)).isEqualTo(session);
    }

    @Test @DisplayName("execute — session not found → throws ExamSessionNotFoundException")
    void execute_sessionNotFound_throwsException() {
        when(sessionRepository.findById(SESSION_ID)).thenReturn(Optional.empty());
        assertThatThrownBy(() -> useCase.execute(SESSION_ID, USER_ID))
            .isInstanceOf(ExamSessionNotFoundException.class);
    }

    @Test @DisplayName("execute — session owned by different user → throws ExamSessionNotFoundException")
    void execute_wrongUser_throwsException() {
        ExamSession otherSession = buildSession();
        when(sessionRepository.findById(SESSION_ID)).thenReturn(Optional.of(otherSession));
        // Different userId
        assertThatThrownBy(() -> useCase.execute(SESSION_ID, UUID.randomUUID()))
            .isInstanceOf(ExamSessionNotFoundException.class);
    }
}
