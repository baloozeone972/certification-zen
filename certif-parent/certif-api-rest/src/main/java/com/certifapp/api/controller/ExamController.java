// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/controller/ExamController.java
package com.certifapp.api.controller;

import com.certifapp.api.dto.request.StartExamRequest;
import com.certifapp.api.dto.request.SubmitAnswerRequest;
import com.certifapp.api.dto.response.ApiResponse;
import com.certifapp.api.security.CurrentUser;
import com.certifapp.domain.model.session.ExamMode;
import com.certifapp.domain.model.session.ExamSession;
import com.certifapp.domain.model.session.UserAnswer;
import com.certifapp.domain.port.input.exam.GetExamResultsUseCase;
import com.certifapp.domain.port.input.exam.StartExamSessionUseCase;
import com.certifapp.domain.port.input.exam.SubmitAnswerUseCase;
import com.certifapp.domain.port.input.exam.SubmitExamUseCase;
import com.certifapp.domain.port.input.session.ExportSessionPdfUseCase;
import com.certifapp.domain.port.input.session.GetSessionHistoryUseCase;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

/**
 * REST controller for exam session lifecycle.
 *
 * <p>All endpoints require JWT authentication.</p>
 */
@RestController
@RequestMapping("/api/v1/exams")
@Tag(name = "Exams", description = "Exam session management")
@SecurityRequirement(name = "BearerAuth")
public class ExamController {

    private final StartExamSessionUseCase startUseCase;
    private final SubmitAnswerUseCase submitAnswerUseCase;
    private final SubmitExamUseCase submitExamUseCase;
    private final GetExamResultsUseCase resultsUseCase;
    private final GetSessionHistoryUseCase historyUseCase;
    private final ExportSessionPdfUseCase pdfUseCase;

    public ExamController(
            StartExamSessionUseCase startUseCase,
            SubmitAnswerUseCase submitAnswerUseCase,
            SubmitExamUseCase submitExamUseCase,
            GetExamResultsUseCase resultsUseCase,
            GetSessionHistoryUseCase historyUseCase,
            ExportSessionPdfUseCase pdfUseCase) {
        this.startUseCase = startUseCase;
        this.submitAnswerUseCase = submitAnswerUseCase;
        this.submitExamUseCase = submitExamUseCase;
        this.resultsUseCase = resultsUseCase;
        this.historyUseCase = historyUseCase;
        this.pdfUseCase = pdfUseCase;
    }

    /**
     * Start a new exam session.
     *
     * @param request session configuration
     * @return 201 Created with session and drawn questions (without correct answers)
     */
    @PostMapping("/sessions")
    @Operation(summary = "Start a new exam session")
    public ResponseEntity<ApiResponse<ExamSession>> startSession(
            @Valid @RequestBody StartExamRequest request) {

        UUID userId = CurrentUser.id();
        var command = new StartExamSessionUseCase.StartExamCommand(
                userId,
                request.certificationId(),
                com.certifapp.domain.model.session.ExamMode.valueOf(request.mode()),
                request.selectedThemes() != null ? request.selectedThemes() : List.of(),
                request.questionCount(),
                request.durationMinutes()
        );
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.created(startUseCase.execute(command)));
    }

    /**
     * Submit a single answer during an in-progress session.
     *
     * @param id      session UUID
     * @param request answer data
     * @return 200 OK with the recorded answer and correctness flag
     */
    @PostMapping("/sessions/{id}/answers")
    @Operation(summary = "Submit an answer to one question")
    public ResponseEntity<ApiResponse<UserAnswer>> submitAnswer(
            @PathVariable UUID id,
            @Valid @RequestBody SubmitAnswerRequest request) {

        UUID userId = CurrentUser.id();
        var command = new SubmitAnswerUseCase.SubmitAnswerCommand(
                id, userId, request.questionId(),
                request.selectedOptionId(), request.responseTimeMs());
        return ResponseEntity.ok(ApiResponse.ok(submitAnswerUseCase.execute(command)));
    }

    /**
     * Finalise the exam session and calculate the score.
     *
     * @param id session UUID
     * @return 200 OK with completed session and final scores
     */
    @PostMapping("/sessions/{id}/submit")
    @Operation(summary = "Finalise the exam and calculate the score")
    public ResponseEntity<ApiResponse<ExamSession>> submitExam(@PathVariable UUID id) {
        UUID userId = CurrentUser.id();
        return ResponseEntity.ok(ApiResponse.ok(submitExamUseCase.execute(id, userId)));
    }

    /**
     * Get the full results of a completed session.
     *
     * @param id session UUID
     * @return 200 OK with session results
     */
    @GetMapping("/sessions/{id}/results")
    @Operation(summary = "Get exam session results")
    public ResponseEntity<ApiResponse<ExamSession>> getResults(@PathVariable UUID id) {
        UUID userId = CurrentUser.id();
        return ResponseEntity.ok(ApiResponse.ok(resultsUseCase.execute(id, userId)));
    }

    /**
     * Export session results as a PDF (PRO subscribers only).
     *
     * @param id session UUID
     * @return 200 OK with PDF bytes
     */
    @GetMapping("/sessions/{id}/export-pdf")
    @Operation(summary = "Export session results as PDF (PRO only)")
    public ResponseEntity<byte[]> exportPdf(@PathVariable UUID id) {
        UUID userId = CurrentUser.id();
        byte[] pdf = pdfUseCase.execute(id, userId);
        return ResponseEntity.ok()
                .contentType(MediaType.APPLICATION_PDF)
                .header(HttpHeaders.CONTENT_DISPOSITION,
                        "attachment; filename=certifapp_results_" + id + ".pdf")
                .body(pdf);
    }

    /**
     * Get paginated session history.
     *
     * @param certificationId optional filter by certification
     * @param mode            optional filter by exam mode
     * @param page            0-based page number
     * @param size            page size (default 20)
     * @return 200 OK with session history
     */
    @GetMapping("/history")
    @Operation(summary = "Get paginated exam session history")
    public ResponseEntity<ApiResponse<List<ExamSession>>> getHistory(
            @RequestParam(required = false) String certificationId,
            @RequestParam(required = false) String mode,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {

        UUID userId = CurrentUser.id();
        ExamMode examMode = mode != null ? ExamMode.valueOf(mode) : null;
        var filter = new GetSessionHistoryUseCase.HistoryFilter(certificationId, examMode, null, null);
        return ResponseEntity.ok(ApiResponse.ok(historyUseCase.execute(userId, filter, page, size)));
    }
}