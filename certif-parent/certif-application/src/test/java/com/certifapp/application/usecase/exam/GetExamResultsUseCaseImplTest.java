package com.certifapp.application.usecase.exam;

import com.certifapp.domain.exception.ExamSessionNotFoundException;
import com.certifapp.domain.model.session.ExamSession;
import com.certifapp.domain.port.output.ExamSessionRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class GetExamResultsUseCaseImplTest {

    @Mock
    private ExamSessionRepository sessionRepository;

    @InjectMocks
    private GetExamResultsUseCaseImpl getExamResultsUseCase;

    private UUID sessionId = UUID.randomUUID();
    private UUID userId = UUID.randomUUID();
    private ExamSession examSession;

    @BeforeEach
    public void setUp() {
        examSession = new ExamSession(sessionId, userId);
    }

    @Test
    @DisplayName("execute_nominal_case")
    public void execute_nominal_case() {
        // Arrange
        when(sessionRepository.findById(eq(sessionId))).thenReturn(Optional.of(examSession));

        // Act
        ExamSession result = getExamResultsUseCase.execute(sessionId, userId);

        // Assert
        assertThat(result).isEqualTo(examSession);
        verify(sessionRepository, times(1)).findById(eq(sessionId));
    }

    @Test
    @DisplayName("execute_edge_case_no_session")
    public void execute_edge_case_no_session() {
        // Arrange
        when(sessionRepository.findById(eq(sessionId))).thenReturn(Optional.empty());

        // Act & Assert
        ExamSessionNotFoundException exception = assertThrows(ExamSessionNotFoundException.class,
                () -> getExamResultsUseCase.execute(sessionId, userId));

        assertThat(exception.getMessage()).isEqualTo("Exam session not found for sessionId: " + sessionId);
        verify(sessionRepository, times(1)).findById(eq(sessionId));
    }

    @Test
    @DisplayName("execute_error_case_user_id_mismatch")
    public void execute_error_case_user_id_mismatch() {
        // Arrange
        when(sessionRepository.findById(eq(sessionId))).thenReturn(Optional.of(examSession));

        // Act & Assert
        ExamSessionNotFoundException exception = assertThrows(ExamSessionNotFoundException.class,
                () -> getExamResultsUseCase.execute(sessionId, UUID.randomUUID()));

        assertThat(exception.getMessage()).isEqualTo("Exam session not found for sessionId: " + sessionId);
        verify(sessionRepository, times(1)).findById(eq(sessionId));
    }
}