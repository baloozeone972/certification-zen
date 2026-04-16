// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/dto/response/TokenResponse.java
package com.certifapp.api.dto.response;

/**
 * JWT token pair returned after authentication.
 *
 * @param accessToken  short-lived JWT (15 minutes)
 * @param refreshToken long-lived JWT (7 days)
 * @param expiresIn    access token validity in seconds (900)
 * @param tokenType    always "Bearer"
 */
public record TokenResponse(
        String accessToken,
        String refreshToken,
        int    expiresIn,
        String tokenType
) {
    public static TokenResponse of(String access, String refresh) {
        return new TokenResponse(access, refresh, 900, "Bearer");
    }
}
