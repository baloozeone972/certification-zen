package com.certifapp.api.exception;

import com.certifapp.api.dto.response.ErrorResponse;
import com.certifapp.domain.exception.*;
import io.jsonwebtoken.JwtException;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class GlobalExceptionHandlerTest {

    @InjectMocks
    private GlobalExceptionHandler globalExceptionHandler;

    @Mock
    private CertificationNotFoundException certificationNotFoundException;

    @Mock
    private QuestionNotFoundException questionNotFoundException;

    @Mock
    private ExamSessionNotFoundException examSessionNotFoundException;

    @Mock
    private UserNotFoundException userNotFoundException;

    @Mock
    private DuplicateEmailException duplicateEmailException;

    @Mock
    private InvalidCredentialsException invalidCredentialsException;

    @Mock
    private ExamAlreadyCompletedException alreadyCompletedException;

    @Mock
    private FreemiumLimitExceededException freemiumLimitExceededException;

    @Mock
    private SubscriptionRequiredException subscriptionRequiredException;

    @Mock
    private StudyGroupFullException studyGroupFullException;

    @Mock
    private MethodArgumentNotValidException methodArgumentNotValidException;

    @Mock
    private JwtException jwtException;

    @Test
    @DisplayName("should return 404 Not Found for CertificationNotFoundException")
    public void handleCertificationNotFound() {
        when(certificationNotFoundException.getMessage()).thenReturn("Certification not found");

        ResponseEntity<ErrorResponse> response = globalExceptionHandler.handleCertificationNotFound(certificationNotFoundException);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.NOT_FOUND);
        assertThat(response.getBody().getCode()).isEqualTo(404);
        assertThat(response.getBody().getMessage()).isEqualTo("Certification not found");
    }

    @Test
    @DisplayName("should return 404 Not Found for QuestionNotFoundException")
    public void handleQuestionNotFound() {
        when(questionNotFoundException.getMessage()).thenReturn("Question not found");

        ResponseEntity<ErrorResponse> response = globalExceptionHandler.handleQuestionNotFound(questionNotFoundException);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.NOT_FOUND);
        assertThat(response.getBody().getCode()).isEqualTo(404);
        assertThat(response.getBody().getMessage()).isEqualTo("Question not found");
    }

    @Test
    @DisplayName("should return 404 Not Found for ExamSessionNotFoundException")
    public void handleSessionNotFound() {
        when(examSessionNotFoundException.getMessage()).thenReturn("Exam session not found");

        ResponseEntity<ErrorResponse> response = globalExceptionHandler.handleSessionNotFound(examSessionNotFoundException);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.NOT_FOUND);
        assertThat(response.getBody().getCode()).isEqualTo(404);
        assertThat(response.getBody().getMessage()).isEqualTo("Exam session not found");
    }

    @Test
    @DisplayName("should return 404 Not Found for UserNotFoundException")
    public void handleUserNotFound() {
        when(userNotFoundException.getMessage()).thenReturn("User not found");

        ResponseEntity<ErrorResponse> response = globalExceptionHandler.handleUserNotFound(userNotFoundException);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.NOT_FOUND);
        assertThat(response.getBody().getCode()).isEqualTo(404);
        assertThat(response.getBody().getMessage()).isEqualTo("User not found");
    }

    @Test
    @DisplayName("should return 409 Conflict for DuplicateEmailException")
    public void handleDuplicateEmail() {
        when(duplicateEmailException.getMessage()).thenReturn("Email already registered");

        ResponseEntity<ErrorResponse> response = globalExceptionHandler.handleDuplicateEmail(duplicateEmailException);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.CONFLICT);
        assertThat(response.getBody().getCode()).isEqualTo(409);
        assertThat(response.getBody().getMessage()).isEqualTo("Email already registered");
    }

    @Test
    @DisplayName("should return 401 Unauthorized for InvalidCredentialsException")
    public void handleInvalidCredentials() {
        ResponseEntity<ErrorResponse> response = globalExceptionHandler.handleInvalidCredentials(invalidCredentialsException);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.UNAUTHORIZED);
        assertThat(response.getBody().getCode()).isEqualTo(401);
        assertThat(response.getBody().getMessage()).isEqualTo("Invalid email or password");
    }

    @Test
    @DisplayName("should return 409 Conflict for ExamAlreadyCompletedException")
    public void handleExamAlreadyCompleted() {
        when(alreadyCompletedException.getMessage()).thenReturn("Exam already completed");

        ResponseEntity<ErrorResponse> response = globalExceptionHandler.handleAlreadyCompleted(alreadyCompletedException);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.CONFLICT);
        assertThat(response.getBody().getCode()).isEqualTo(409);
        assertThat(response.getBody().getMessage()).isEqualTo("Exam already completed");
    }

    @Test
    @DisplayName("should return 402 Payment Required for FreemiumLimitExceededException")
    public void handleFreemiumLimit() {
        when(freemiumLimitExceededException.getMessage()).thenReturn("Free tier limit exceeded");

        ResponseEntity<ErrorResponse> response = globalExceptionHandler.handleFreemiumLimit(freemiumLimitExceededException);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.PAYMENT_REQUIRED);
        assertThat(response.getBody().getCode()).isEqualTo(402);
        assertThat(response.getBody().getMessage()).isEqualTo("Free tier limit exceeded");
    }

    @Test
    @DisplayName("should return 402 Payment Required for SubscriptionRequiredException")
    public void handleSubscriptionRequired() {
        when(subscriptionRequiredException.getMessage()).thenReturn("Subscription required");

        ResponseEntity<ErrorResponse> response = globalExceptionHandler.handleSubscriptionRequired(subscriptionRequiredException);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.PAYMENT_REQUIRED);
        assertThat(response.getBody().getCode()).isEqualTo(402);
        assertThat(response.getBody().getMessage()).isEqualTo("Subscription required");
    }

    @Test
    @DisplayName("should return 409 Conflict for StudyGroupFullException")
    public void handleStudyGroupFull() {
        when(studyGroupFullException.getMessage()).thenReturn("Study group is full");

        ResponseEntity<ErrorResponse> response = globalExceptionHandler.handleGroupFull(studyGroupFullException);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.CONFLICT);
        assertThat(response.getBody().getCode()).isEqualTo(409);
        assertThat(response.getBody().getMessage()).isEqualTo("Study group is full");
    }

    @Test
    @DisplayName("should return 400 Bad Request for MethodArgumentNotValidException")
    public void handleValidationErrors() {
        when(methodArgumentNotValidException.getBindingResult().getFieldErrors())
                .thenReturn(List.of(
                        new ErrorResponse.FieldError("field1", "error message1"),
                        new ErrorResponse.FieldError("field2", "error message2")
                ));

        ResponseEntity<ErrorResponse> response = globalExceptionHandler.handleValidationErrors(methodArgumentNotValidException);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.BAD_REQUEST);
        assertThat(response.getBody().getCode()).isEqualTo(400);
        assertThat(response.getBody().getMessage()).isEqualTo("Validation failed");
        assertThat(response.getBody().getDetails()).hasSize(2)
                .contains(new ErrorResponse.FieldError("field1", "error message1"))
                .contains(new ErrorResponse.FieldError("field2", "error message2"));
    }

    @Test
    @DisplayName("should return 401 Unauthorized for JwtException")
    public void handleJwtException() {
        ResponseEntity<ErrorResponse> response = globalExceptionHandler.handleJwtException(jwtException);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.UNAUTHORIZED);
        assertThat(response.getBody().getCode()).isEqualTo(401);
        assertThat(response.getBody().getMessage()).isEqualTo("Invalid or expired token");
    }

    @Test
    @DisplayName("should return 500 Internal Server Error for generic Exception")
    public void handleGeneric() {
        ResponseEntity<ErrorResponse> response = globalExceptionHandler.handleGeneric(new Exception("Generic error"));

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.INTERNAL_SERVER_ERROR);
        assertThat(response.getBody().getCode()).isEqualTo(500);
        assertThat(response.getBody().getMessage()).isEqualTo("An unexpected error occurred");
    }
}

