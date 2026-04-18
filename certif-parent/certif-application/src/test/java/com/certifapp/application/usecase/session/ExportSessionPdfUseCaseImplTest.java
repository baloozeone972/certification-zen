package com.certifapp.application.usecase.session;

import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

import java.util.*;
import java.util.stream.Collectors;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class ExportSessionPdfUseCaseImplTest {

    @Mock
    private ExamSessionRepository sessionRepository;

    @Mock
    private QuestionRepository questionRepository;

    @Mock
    private UserRepository userRepository;

    @Mock
    private UserAnswerRepository answerRepository;

    @Mock
    private PdfExportPort pdfExportPort;

    @Mock
    private FreemiumGuardService freemiumGuardService;

    @Mock
    private ScoringService scoringService;

    @InjectMocks
    private ExportSessionPdfUseCaseImpl exportSessionPdfUseCase;

    private UUID sessionId;
    private UUID userId;
    private ExamSession session;
    private List<UserAnswer> answers;
    private List<Question> questions;
    private byte[] pdfBytes;

    @BeforeEach
    public void setUp() {
        sessionId = UUID.randomUUID();
        userId = UUID.randomUUID();
        session = new ExamSession(sessionId, userId, null);
        answers = new ArrayList<>();
        questions = new ArrayList<>();
        pdfBytes = new byte[0];
    }

    @Test
    @DisplayName("should export PDF for PRO user")
    public void execute_proUser_exportPdf() {
        when(userRepository.findById(userId)).thenReturn(Optional.of(new com.certifapp.domain.model.user.User(userId, SubscriptionTier.PRO)));
        when(sessionRepository.findById(sessionId)).thenReturn(Optional.of(session));
        when(answerRepository.findBySessionId(sessionId)).thenReturn(answers);
        when(questionRepository.findById(any(UUID.class))).thenReturn(Optional.ofNullable(null));
        when(pdfExportPort.exportResults(any(), any(), any())).thenReturn(pdfBytes);

        byte[] result = exportSessionPdfUseCase.execute(sessionId, userId);

        assertThat(result).isEqualTo(pdfBytes);
        verify(userRepository).findById(userId);
        verify(sessionRepository).findById(sessionId);
        verify(answerRepository).findBySessionId(sessionId);
        verify(questionRepository).findById(any(UUID.class));
        verify(pdfExportPort).exportResults(any(), any(), any());
    }

    @Test
    @DisplayName("should throw ExamSessionNotFoundException for non-existent session")
    public void execute_nonExistentSession_throwException() {
        when(userRepository.findById(userId)).thenReturn(Optional.of(new com.certifapp.domain.model.user.User(userId, SubscriptionTier.PRO)));
        when(sessionRepository.findById(sessionId)).thenReturn(Optional.empty());

        assertThatThrownBy(() -> exportSessionPdfUseCase.execute(sessionId, userId))
                .isInstanceOf(ExamSessionNotFoundException.class)
                .hasMessageContaining(sessionId.toString());

        verify(userRepository).findById(userId);
        verify(sessionRepository).findById(sessionId);
    }

    @Test
    @DisplayName("should throw ExamSessionNotFoundException for session with wrong user")
    public void execute_wrongUser_throwException() {
        UUID otherUserId = UUID.randomUUID();
        when(userRepository.findById(userId)).thenReturn(Optional.of(new com.certifapp.domain.model.user.User(userId, SubscriptionTier.PRO)));
        when(sessionRepository.findById(sessionId)).thenReturn(Optional.of(new ExamSession(sessionId, otherUserId, null)));

        assertThatThrownBy(() -> exportSessionPdfUseCase.execute(sessionId, userId))
                .isInstanceOf(ExamSessionNotFoundException.class)
                .hasMessageContaining(sessionId.toString());

        verify(userRepository).findById(userId);
        verify(sessionRepository).findById(sessionId);
    }

    @Test
    @DisplayName("should throw SubscriptionRequiredException for FREE user")
    public void execute_freeUser_throwException() {
        when(userRepository.findById(userId)).thenReturn(Optional.of(new com.certifapp.domain.model.user.User(userId, SubscriptionTier.FREE)));

        assertThatThrownBy(() -> exportSessionPdfUseCase.execute(sessionId, userId))
                .isInstanceOf(SubscriptionRequiredException.class)
                .hasMessageContaining("PDF Export");

        verify(userRepository).findById(userId);
    }

    @Test
    @DisplayName("should handle null questions gracefully")
    public void execute_nullQuestions_exportPdf() {
        when(userRepository.findById(userId)).thenReturn(Optional.of(new com.certifapp.domain.model.user.User(userId, SubscriptionTier.PRO)));
        when(sessionRepository.findById(sessionId)).thenReturn(Optional.of(session));
        when(answerRepository.findBySessionId(sessionId)).thenReturn(answers);
        when(questionRepository.findById(any(UUID.class))).thenReturn(Optional.ofNullable(null));
        when(pdfExportPort.exportResults(any(), any(), any())).thenReturn(pdfBytes);

        byte[] result = exportSessionPdfUseCase.execute(sessionId, userId);

        assertThat(result).isEqualTo(pdfBytes);
        verify(userRepository).findById(userId);
        verify(sessionRepository).findById(sessionId);
        verify(answerRepository).findBySessionId(sessionId);
        verify(questionRepository).findById(any(UUID.class));
        verify(pdfExportPort).exportResults(any(), any(), any());
    }
}
