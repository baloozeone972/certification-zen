// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/dto/request/RefreshTokenRequest.java
package com.certifapp.api.dto.request;

import jakarta.validation.constraints.NotBlank;

/**
 * HTTP request body for {@code POST /api/v1/auth/refresh}.
 *
 * @param refreshToken the long-lived JWT refresh token
 */
public record RefreshTokenRequest(@NotBlank String refreshToken) {}
