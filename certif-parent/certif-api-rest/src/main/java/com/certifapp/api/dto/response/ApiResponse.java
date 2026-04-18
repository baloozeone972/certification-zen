// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/dto/response/ApiResponse.java
package com.certifapp.api.dto.response;

import java.time.OffsetDateTime;

/**
 * Generic API response wrapper for consistent JSON envelope.
 *
 * <p>All successful API responses are wrapped in this record:
 * {@code {"data": {...}, "message": "OK", "timestamp": "..."}}</p>
 *
 * @param data      the response payload
 * @param message   human-readable status message
 * @param timestamp response timestamp
 */
public record ApiResponse<T>(T data, String message, OffsetDateTime timestamp) {

    /**
     * Convenience factory for successful responses.
     */
    public static <T> ApiResponse<T> ok(T data) {
        return new ApiResponse<>(data, "OK", OffsetDateTime.now());
    }

    /**
     * Convenience factory for created responses.
     */
    public static <T> ApiResponse<T> created(T data) {
        return new ApiResponse<>(data, "Created", OffsetDateTime.now());
    }
}
