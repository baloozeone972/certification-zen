// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/dto/response/ErrorResponse.java
package com.certifapp.api.dto.response;

import java.time.OffsetDateTime;
import java.util.List;

/**
 * Standardised error response body.
 *
 * @param status    HTTP status code
 * @param message   error summary
 * @param errors    per-field validation errors (empty for non-validation errors)
 * @param timestamp error timestamp
 */
public record ErrorResponse(
        int                status,
        String             message,
        List<FieldError>   errors,
        OffsetDateTime     timestamp
) {

    /** Field-level validation error. */
    public record FieldError(String field, String message) {}

    public static ErrorResponse of(int status, String message) {
        return new ErrorResponse(status, message, List.of(), OffsetDateTime.now());
    }

    public static ErrorResponse of(int status, String message, List<FieldError> errors) {
        return new ErrorResponse(status, message, errors, OffsetDateTime.now());
    }
}
