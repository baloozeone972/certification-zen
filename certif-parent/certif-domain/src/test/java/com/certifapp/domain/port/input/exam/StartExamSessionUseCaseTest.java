```java
package com.certifapp.domain.port.input.exam;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

import com.certifapp.domain.exception.CertificationNotFoundException;
import com.certifapp.domain.exception.FreemiumLimitExceededException;
import com.certifapp.domain.model.session.ExamMode;
import com.certifapp.domain.model.session.ExamSession;
import java.util.List;
import java.util.UUID;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class StartExamSessionUseCaseTest {

    @Mock
    private ExamSessionRepository examSessionRepository;

    @InjectMocks
    private StartExamSessionUseCase startExamSessionUseCase;

    @BeforeEach
    public void setUp() {
        // Setup code if needed
    }

    @AfterEach
    public void tearDown() {
        // Teardown code if needed
    }

    @DisplayName("Nominal case: valid command with default parameters")
    @Test
    public void startExamSession_validCommand_defaultParameters_success() throws CertificationNotFoundException, FreemiumLimitExceededException {
        UUID userId = UUID.randomUUID();
        String certificationId = "cert123";
        ExamMode mode = ExamMode.EXAM;
        List<String> selectedThemes = List.of("theme1", "theme2");
        int questionCount = 0;
        int durationMinutes = 0;

        StartExamCommand command = new StartExamCommand(userId, certificationId, mode, selectedThemes, questionCount, durationMinutes);
        ExamSession expectedSession = mock(ExamSession.class);

        when(examSessionRepository.create(any())).thenReturn(expectedSession);

        ExamSession result = startExamSessionUseCase.execute(command);

        assertThat(result).isSameAs(expectedSession);
        verify(examSessionRepository).create(any());
    }

    @DisplayName("Edge case: null userId")
    @Test
    public void startExamSession_nullUserId_exception() {
        UUID userId = null;
        String certificationId = "cert123";
        ExamMode mode = ExamMode.EXAM;
        List<String> selectedThemes = List.of();
        int questionCount = 0;
        int durationMinutes = 0;

        StartExamCommand command = new StartExamCommand(userId, certificationId, mode, selectedThemes, questionCount, durationMinutes);

        IllegalArgumentException exception = Assertions.assertThrows(IllegalArgumentException.class, () -> {
            startExamSessionUseCase.execute(command);
        });

        assertThat(exception.getMessage()).isEqualTo("userId must not be null");
    }

    @DisplayName("Edge case: blank certificationId")
    @Test
    public void startExamSession_blankCertificationId_exception() {
        UUID userId = UUID.randomUUID();
        String certificationId = "";
        ExamMode mode = ExamMode.EXAM;
        List<String> selectedThemes = List.of();
        int questionCount = 0;
        int durationMinutes = 0;

        StartExamCommand command = new StartExamCommand(userId, certificationId, mode, selectedThemes, questionCount, durationMinutes);

        IllegalArgumentException exception = Assertions.assertThrows(IllegalArgumentException.class, () -> {
            startExamSessionUseCase.execute(command);
        });

        assertThat(exception.getMessage()).isEqualTo("certificationId must not be blank");
    }

    @DisplayName("Edge case: null mode")
    @Test
    public void startExamSession_nullMode_exception() {
        UUID userId = UUID.randomUUID();
        String certificationId = "cert123";
        ExamMode mode = null;
        List<String> selectedThemes = List.of();
        int questionCount = 0;
        int durationMinutes = 0;

        StartExamCommand command = new StartExamCommand(userId, certificationId, mode, selectedThemes, questionCount, durationMinutes);

        IllegalArgumentException exception = Assertions.assertThrows(IllegalArgumentException.class, () -> {
            startExamSessionUseCase.execute(command);
        });

        assertThat(exception.getMessage()).isEqualTo("mode must not be null");
    }

    @DisplayName("Error case: certification not found")
    @Test
    public void startExamSession_certificationNotFound_exception() throws CertificationNotFoundException, FreemiumLimitExceededException {
        UUID userId = UUID.randomUUID();
        String certificationId = "nonexistentCert";
        ExamMode mode = ExamMode.EXAM;
        List<String> selectedThemes = List.of();
        int questionCount = 0;
        int durationMinutes = 0;

        StartExamCommand command = new StartExamCommand(userId, certificationId, mode, selectedThemes, questionCount, durationMinutes);

        when(examSessionRepository.create(any())).thenThrow(new CertificationNotFoundException("Certification not found"));

        FreemiumLimitExceededException exception = Assertions.assertThrows(FreemiumLimitExceededException.class, () -> {
            startExamSessionUseCase.execute(command);
        });

        assertThat(exception.getMessage()).isEqualTo("Freemium limit exceeded");
    }

    @DisplayName("Error case: freemium limit exceeded")
    @Test
    public void startExamSession_freemiumLimitExceeded_exception() throws CertificationNotFoundException, FreemiumLimitExceededException {
        UUID userId = UUID.randomUUID();
        String certificationId = "cert123";
        ExamMode mode = ExamMode.FREE;
        List<String> selectedThemes = List.of();
        int questionCount = 0;
        int durationMinutes = 60;

        StartExamCommand command = new StartExamCommand(userId, certificationId, mode, selectedThemes, questionCount, durationMinutes);

        when(examSessionRepository.create(any())).thenThrow(new FreemiumLimitExceededException("Freemium limit exceeded"));

        FreemiumLimitExceededException exception = Assertions.assertThrows(FreemiumLimitExceededException.class, () -> {
            startExamSessionUseCase.execute(command);
        });

        assertThat(exception.getMessage()).isEqualTo("Freemium limit exceeded");
    }
}
```
