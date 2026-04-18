package com.certifapp.api.controller;

import com.certifapp.api.dto.request.ImportQuestionsRequest;
import com.certifapp.api.dto.response.ApiResponse;
import com.certifapp.domain.port.input.admin.ImportQuestionsUseCase;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.anyList;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class AdminControllerTest {

    @Mock
    private ImportQuestionsUseCase importUseCase;

    @InjectMocks
    private AdminController adminController;

    @BeforeEach
    public void setUp() {
        // Setup code if needed
    }

    @AfterEach
    public void tearDown() {
        verifyNoMoreInteractions(importUseCase);
    }

    @Test
    @DisplayName("importQuestions_nominal_case")
    public void importQuestions_nominal_case() {
        // Arrange
        String adminId = UUID.randomUUID().toString();
        when(CurrentUser.id()).thenReturn(UUID.fromString(adminId));

        ImportQuestionsRequest request = new ImportQuestionsRequest(
                "cert123",
                List.of(new ImportQuestionsRequest.QuestionImportItem(
                        "question1", 1, Arrays.asList("A", "B"), 0, "Easy", null))
        );

        ImportQuestionsUseCase.ImportResult result = new ImportQuestionsUseCase.ImportResult(
                Collections.emptyList(), 1L, 1L
        );
        when(importUseCase.execute(eq("cert123"), anyList(), eq(UUID.fromString(adminId)))).thenReturn(result);

        // Act
        ResponseEntity<ApiResponse<ImportQuestionsUseCase.ImportResult>> response = adminController.importQuestions(request);

        // Assert
        assertThat(response).isNotNull();
        assertEquals(HttpStatus.CREATED, response.getStatusCode());
        ApiResponse<ImportQuestionsUseCase.ImportResult> responseBody = response.getBody();
        assertThat(responseBody).isNotNull();
        assertEquals(1L, responseBody.getData().getCreatedCount());
        verify(importUseCase, times(1)).execute(eq("cert123"), anyList(), eq(UUID.fromString(adminId)));
    }

    @Test
    @DisplayName("importQuestions_edge_case_empty_request")
    public void importQuestions_edge_case_empty_request() {
        // Arrange
        String adminId = UUID.randomUUID().toString();
        when(CurrentUser.id()).thenReturn(UUID.fromString(adminId));

        ImportQuestionsRequest request = new ImportQuestionsRequest(
                "cert123",
                Collections.emptyList()
        );

        // Act
        ResponseEntity<ApiResponse<ImportQuestionsUseCase.ImportResult>> response = adminController.importQuestions(request);

        // Assert
        assertThat(response).isNotNull();
        assertEquals(HttpStatus.CREATED, response.getStatusCode());
        ApiResponse<ImportQuestionsUseCase.ImportResult> responseBody = response.getBody();
        assertThat(responseBody).isNotNull();
        assertEquals(0L, responseBody.getData().getCreatedCount());
        verify(importUseCase, times(1)).execute(eq("cert123"), anyList(), eq(UUID.fromString(adminId)));
    }

    @Test
    @DisplayName("importQuestions_error_case_null_request")
    public void importQuestions_error_case_null_request() {
        // Arrange

        // Act & Assert
        assertThrows(NullPointerException.class, () -> adminController.importQuestions(null));
    }
}

