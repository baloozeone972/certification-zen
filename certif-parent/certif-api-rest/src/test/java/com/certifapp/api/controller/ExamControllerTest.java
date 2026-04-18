package com.certifapp.api.controller;

import com.certifapp.api.dto.request.StartExamRequest;
import com.certifapp.api.dto.request.SubmitAnswerRequest;
import com.certifapp.api.dto.response.ApiResponse;
import com.certifapp.domain.model.session.ExamSession;
import com.certifapp.domain.model.session.UserAnswer;
import com.certifapp.domain.port.input.exam.*;
import com.certifapp.domain.port.input.session.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;

@ExtendWith(MockitoExtension.class)
public class ExamControllerTest {

    @Mock
    private StartExamSessionUseCase startUseCase;

    @Mock
    private SubmitAnswerUseCase submitAnswerUseCase;

    @Mock
    private SubmitExamUseCase submitExamUseCase;

    @Mock
    private GetExamResultsUseCase resultsUseCase;

    @Mock
    private GetSessionHistoryUseCase historyUseCase;

    @Mock
    private ExportSessionPdfUseCase pdfUseCase;

    @InjectMocks
    private ExamController examController;

    @BeforeEach
    public void setUp() {
        // Setup mock behavior here if needed
    }

    @Test
    @DisplayName("startSession_nominal_case")
    public void startSession_nominal_case() {
        UUID sessionId = UUID.randomUUID();
        StartExamRequest request = new StartExamRequest("cert123", "MIXED", null, 10, 60);
        ExamSession session = new ExamSession(sessionId, UUID.randomUUID(), null, null);

        when(startUseCase.execute(any(StartExamSessionUseCase.StartExamCommand.class))).thenReturn(session);

        ResponseEntity<ApiResponse<ExamSession>> response = examController.startSession(request);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.CREATED);
        assertThat(response.getBody().getData()).isNotNull();
        verify(startUseCase).execute(any(StartExamSessionUseCase.StartExamCommand.class));
    }

    @Test
    @DisplayName("submitAnswer_nominal_case")
    public void submitAnswer_nominal_case() {
        UUID sessionId = UUID.randomUUID();
        SubmitAnswerRequest request = new SubmitAnswerRequest(sessionId, UUID.randomUUID(), UUID.randomUUID(), 100);
        UserAnswer answer = new UserAnswer(UUID.randomUUID(), UUID.randomUUID(), UUID.randomUUID(), true);

        when(submitAnswerUseCase.execute(eq(sessionId), any(SubmitAnswerUseCase.SubmitAnswerCommand.class))).thenReturn(answer);

        ResponseEntity<ApiResponse<UserAnswer>> response = examController.submitAnswer(sessionId, request);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(response.getBody().getData()).isNotNull();
        verify(submitAnswerUseCase).execute(eq(sessionId), any(SubmitAnswerUseCase.SubmitAnswerCommand.class));
    }

    @Test
    @DisplayName("submitExam_nominal_case")
    public void submitExam_nominal_case() {
        UUID sessionId = UUID.randomUUID();
        ExamSession session = new ExamSession(sessionId, UUID.randomUUID(), null, null);

        when(submitExamUseCase.execute(eq(sessionId), any(UUID.class))).thenReturn(session);

        ResponseEntity<ApiResponse<ExamSession>> response = examController.submitExam(sessionId);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(response.getBody().getData()).isNotNull();
        verify(submitExamUseCase).execute(eq(sessionId), any(UUID.class));
    }

    @Test
    @DisplayName("getResults_nominal_case")
    public void getResults_nominal_case() {
        UUID sessionId = UUID.randomUUID();
        ExamSession session = new ExamSession(sessionId, UUID.randomUUID(), null, null);

        when(resultsUseCase.execute(eq(sessionId), any(UUID.class))).thenReturn(session);

        ResponseEntity<ApiResponse<ExamSession>> response = examController.getResults(sessionId);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(response.getBody().getData()).isNotNull();
        verify(resultsUseCase).execute(eq(sessionId), any(UUID.class));
    }

    @Test
    @DisplayName("exportPdf_nominal_case")
    public void exportPdf_nominal_case() {
        UUID sessionId = UUID.randomUUID();
        byte[] pdfBytes = new byte[0];

        when(pdfUseCase.execute(eq(sessionId), any(UUID.class))).thenReturn(pdfBytes);

        ResponseEntity<byte[]> response = examController.exportPdf(sessionId);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(response.getBody()).isNotNull();
        verify(pdfUseCase).execute(eq(sessionId), any(UUID.class));
    }

    @Test
    @DisplayName("getHistory_nominal_case")
    public void getHistory_nominal_case() {
        String certificationId = "cert123";
        String mode = "MIXED";
        int page = 0;
        int size = 20;

        UUID userId = UUID.randomUUID();
        ExamSession session = new ExamSession(UUID.randomUUID(), userId, null, null);
        List<ExamSession> sessions = List.of(session);

        when(historyUseCase.execute(eq(userId), any(GetSessionHistoryUseCase.HistoryFilter.class), eq(page), eq(size))).thenReturn(sessions);

        ResponseEntity<ApiResponse<List<ExamSession>>> response = examController.getHistory(certificationId, mode, page, size);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(response.getBody().getData()).isNotNull();
        verify(historyUseCase).execute(eq(userId), any(GetSessionHistoryUseCase.HistoryFilter.class), eq(page), eq(size));
    }
}
