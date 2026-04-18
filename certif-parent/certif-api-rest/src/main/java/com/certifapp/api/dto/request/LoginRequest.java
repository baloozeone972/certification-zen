// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/dto/request/LoginRequest.java
package com.certifapp.api.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

/**
 * HTTP request body for {@code POST /api/v1/auth/login}.
 *
 * @param email    user email
 * @param password plain-text password
 */
public record LoginRequest(
        @NotBlank @Email String email,
        @NotBlank String password
) {
}
