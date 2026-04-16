// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/user/TokenPairDto.java
package com.certifapp.application.dto.user;

/**
 * JWT token pair returned after successful authentication.
 *
 * @param accessToken   short-lived JWT (15 minutes)
 * @param refreshToken  long-lived JWT used to obtain new access tokens (7 days)
 * @param expiresIn     access token validity in seconds (900)
 * @param tokenType     always {@code "Bearer"}
 */
public record TokenPairDto(
        String accessToken,
        String refreshToken,
        int    expiresIn,
        String tokenType
) {
    /** Convenience factory with standard 15-minute access token. */
    public static TokenPairDto of(String accessToken, String refreshToken) {
        return new TokenPairDto(accessToken, refreshToken, 900, "Bearer");
    }
}
