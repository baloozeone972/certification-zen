// certif-parent/certif-application/src/test/java/com/certifapp/application/usecase/session/ExportSessionPdfUseCaseImplTest.java
package com.certifapp.application.usecase.session;

import com.certifapp.domain.model.session.*;
import com.certifapp.domain.model.user.*;
import com.certifapp.domain.port.output.*;
import com.certifapp.domain.service.*;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.OffsetDateTime;
import java.util.*;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("ExportSessionPdfUseCaseImpl")
class ExportSessionPdfUseCaseImplTest {

    @Mock ExamSessionRepository sessionRepository;
    @Mock QuestionRepository    questionRepository;
    @Mock UserRepository        userRepository;
    @Mock UserAnswerRepository  answerRepository;
    @Mock PdfExportPort         pdfExportPort;
    @Mock FreemiumGuardService  freemiumGuardService;
    @Mock ScoringService        scoringService;
    @InjectMocks ExportSessionPdfUseCaseImpl useCase;

    private static final UUID SESSION_ID = UUID.randomUUID();
    private static final UUID USER_ID    = UUID.randomUUID();

    private User buildProUser() {
        return new User(USER_ID, "u@test.com", "$2a$12$h", UserRole.USER,
                SubscriptionTier.PRO, "fr", "Europe/Paris", null, true,
                OffsetDateTime.now(), OffsetDateTime.now());
    }

    private ExamSession buildSession() {
        return new ExamSession(SESSION_ID, USER_ID, "ocp21", ExamMode.EXAM,
                SessionStatus.COMPLETED, OffsetDateTime.now(), null, 1800L,
                10, 7, 70.0, true, List.of());
    }

    @Test @DisplayName("execute — PRO user with completed session → returns PDF bytes")
    void execute_proUser_returnsPdf() {
        when(userRepository.findById(USER_ID)).thenReturn(Optional.of(buildProUser()));
        when(sessionRepository.findById(SESSION_ID)).thenReturn(Optional.of(buildSession()));
        when(answerRepository.findBySessionId(SESSION_ID)).thenReturn(List.of());
        when(questionRepository.findAllById(any())).thenReturn(List.of());
        when(pdfExportPort.exportResults(any(), any(), any())).thenReturn(new byte[]{1, 2, 3});

        byte[] pdf = useCase.execute(SESSION_ID, USER_ID);

        assertThat(pdf).isNotEmpty();
        verify(pdfExportPort).exportResults(any(), any(), any());
    }
}
