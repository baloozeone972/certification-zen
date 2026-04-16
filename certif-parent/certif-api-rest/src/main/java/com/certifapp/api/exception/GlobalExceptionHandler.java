// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/exception/GlobalExceptionHandler.java
package com.certifapp.api.exception;

import com.certifapp.api.dto.response.ErrorResponse;
import com.certifapp.domain.exception.*;
import io.jsonwebtoken.JwtException;
import org.springframework.http.*;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Global exception handler mapping domain exceptions to HTTP responses.
 *
 * <p>Maps domain exceptions to appropriate HTTP status codes.
 * All responses use the {@link ErrorResponse} record for consistency.</p>
 */
@RestControllerAdvice
public class GlobalExceptionHandler {

    // ── Domain exceptions → HTTP ───────────────────────────────────────────

    @ExceptionHandler(CertificationNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleCertificationNotFound(
            CertificationNotFoundException ex) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body(ErrorResponse.of(404, ex.getMessage()));
    }

    @ExceptionHandler(QuestionNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleQuestionNotFound(
            QuestionNotFoundException ex) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body(ErrorResponse.of(404, ex.getMessage()));
    }

    @ExceptionHandler(ExamSessionNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleSessionNotFound(
            ExamSessionNotFoundException ex) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body(ErrorResponse.of(404, ex.getMessage()));
    }

    @ExceptionHandler(UserNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleUserNotFound(UserNotFoundException ex) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body(ErrorResponse.of(404, ex.getMessage()));
    }

    @ExceptionHandler(DuplicateEmailException.class)
    public ResponseEntity<ErrorResponse> handleDuplicateEmail(DuplicateEmailException ex) {
        return ResponseEntity.status(HttpStatus.CONFLICT)
                .body(ErrorResponse.of(409, ex.getMessage()));
    }

    @ExceptionHandler(InvalidCredentialsException.class)
    public ResponseEntity<ErrorResponse> handleInvalidCredentials(InvalidCredentialsException ex) {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                .body(ErrorResponse.of(401, "Invalid email or password"));
    }

    @ExceptionHandler(ExamAlreadyCompletedException.class)
    public ResponseEntity<ErrorResponse> handleAlreadyCompleted(ExamAlreadyCompletedException ex) {
        return ResponseEntity.status(HttpStatus.CONFLICT)
                .body(ErrorResponse.of(409, ex.getMessage()));
    }

    @ExceptionHandler(FreemiumLimitExceededException.class)
    public ResponseEntity<ErrorResponse> handleFreemiumLimit(FreemiumLimitExceededException ex) {
        return ResponseEntity.status(HttpStatus.PAYMENT_REQUIRED)
                .body(ErrorResponse.of(402, ex.getMessage()));
    }

    @ExceptionHandler(SubscriptionRequiredException.class)
    public ResponseEntity<ErrorResponse> handleSubscriptionRequired(
            SubscriptionRequiredException ex) {
        return ResponseEntity.status(HttpStatus.PAYMENT_REQUIRED)
                .body(ErrorResponse.of(402, ex.getMessage()));
    }

    @ExceptionHandler(StudyGroupFullException.class)
    public ResponseEntity<ErrorResponse> handleGroupFull(StudyGroupFullException ex) {
        return ResponseEntity.status(HttpStatus.CONFLICT)
                .body(ErrorResponse.of(409, ex.getMessage()));
    }

    // ── Validation ──────────────────────────────────────────────────────────

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ErrorResponse> handleValidationErrors(
            MethodArgumentNotValidException ex) {

        List<ErrorResponse.FieldError> fieldErrors = ex.getBindingResult()
                .getFieldErrors()
                .stream()
                .map(f -> new ErrorResponse.FieldError(f.getField(), f.getDefaultMessage()))
                .toList();

        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body(ErrorResponse.of(400, "Validation failed", fieldErrors));
    }

    // ── JWT ─────────────────────────────────────────────────────────────────

    @ExceptionHandler(JwtException.class)
    public ResponseEntity<ErrorResponse> handleJwtException(JwtException ex) {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                .body(ErrorResponse.of(401, "Invalid or expired token"));
    }

    // ── Fallback ─────────────────────────────────────────────────────────────

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> handleGeneric(Exception ex) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(ErrorResponse.of(500, "An unexpected error occurred"));
    }
}
