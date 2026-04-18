// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/controller/AdminController.java
package com.certifapp.api.controller;

import com.certifapp.api.dto.request.ImportQuestionsRequest;
import com.certifapp.api.dto.response.ApiResponse;
import com.certifapp.api.security.CurrentUser;
import com.certifapp.domain.model.question.*;
import com.certifapp.domain.port.input.admin.ImportQuestionsUseCase;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * REST controller for admin back-office operations.
 * All endpoints require the ADMIN role.
 */
@RestController
@RequestMapping("/api/v1/admin")
@Tag(name = "Admin", description = "Back-office: question import and enrichment")
@SecurityRequirement(name = "BearerAuth")
@PreAuthorize("hasRole('ADMIN')")
public class AdminController {

    private final ImportQuestionsUseCase importUseCase;

    public AdminController(ImportQuestionsUseCase importUseCase) {
        this.importUseCase = importUseCase;
    }

    /**
     * Bulk import questions from a JSON payload.
     *
     * @param request certification id + question list
     * @return 201 Created with import summary
     */
    @PostMapping("/questions/import")
    @Operation(summary = "Bulk import questions (ADMIN only)")
    public ResponseEntity<ApiResponse<ImportQuestionsUseCase.ImportResult>> importQuestions(
            @Valid @RequestBody ImportQuestionsRequest request) {

        UUID adminId = CurrentUser.id();
        // Map API request items to domain Question objects (simplified — full mapping in adapter)
        List<Question> questions = request.questions().stream()
                .map(item -> buildQuestionFromImport(item, request.certificationId()))
                .toList();

        var result = importUseCase.execute(request.certificationId(), questions, adminId);
        return ResponseEntity.status(HttpStatus.CREATED).body(ApiResponse.created(result));
    }

    // ── Helpers ────────────────────────────────────────────────────────────────

    private Question buildQuestionFromImport(
            ImportQuestionsRequest.QuestionImportItem item, String certId) {

        char[] labels = {'A', 'B', 'C', 'D', 'E'};
        List<QuestionOption> options = new ArrayList<>();
        for (int i = 0; i < item.options().size(); i++) {
            options.add(new QuestionOption(null, null, labels[i],
                    item.options().get(i), i == item.correctIndex(), i));
        }

        DifficultyLevel diff = item.difficulty() != null
                ? DifficultyLevel.fromJson(item.difficulty())
                : DifficultyLevel.MEDIUM;

        return new Question(
                null, item.legacyId(), certId, null,
                item.statement(), diff, QuestionType.SINGLE_CHOICE,
                options, item.explanation(), null,
                ExplanationStatus.ORIGINAL, null, null, null, true, null);
    }
}
