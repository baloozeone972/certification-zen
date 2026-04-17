// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/security/JwtTokenProvider.java
package com.certifapp.api.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtBuilder;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.UUID;

/**
 * JWT access and refresh token provider.
 *
 * <p>Access tokens expire in 15 minutes (900s).
 * Refresh tokens expire in 7 days (604800s).
 * Both are signed with HMAC-SHA256 using the configured secret.</p>
 */
@Component
public class JwtTokenProvider {

    private final SecretKey secretKey;
    private final long accessExpiryMs;
    private final long refreshExpiryMs;

    public JwtTokenProvider(
            @Value("${app.jwt.secret}") String secret,
            @Value("${app.jwt.access-expiry:900}") long accessExpirySec,
            @Value("${app.jwt.refresh-expiry:604800}") long refreshExpirySec) {

        this.secretKey = Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
        this.accessExpiryMs = accessExpirySec * 1000L;
        this.refreshExpiryMs = refreshExpirySec * 1000L;
    }

    /**
     * Generates a short-lived access token (15 minutes).
     *
     * @param userId user UUID
     * @param role   user role name (e.g. "USER", "ADMIN")
     * @return signed JWT string
     */
    public String generateAccessToken(UUID userId, String role) {
        return buildToken(userId.toString(), role, accessExpiryMs, "access");
    }

    /**
     * Generates a long-lived refresh token (7 days).
     *
     * @param userId user UUID
     * @return signed JWT string
     */
    public String generateRefreshToken(UUID userId) {
        return buildToken(userId.toString(), null, refreshExpiryMs, "refresh");
    }

    /**
     * Validates a JWT and returns its claims.
     *
     * @param token the JWT string to validate
     * @return parsed {@link Claims}
     * @throws JwtException if the token is invalid, expired or malformed
     */
    public Claims validateAndGetClaims(String token) {
        return Jwts.parser()
                .verifyWith(secretKey)
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }

    /**
     * Extracts the user UUID from a validated token.
     *
     * @param token the JWT string
     * @return the user UUID stored in the subject claim
     */
    public UUID extractUserId(String token) {
        return UUID.fromString(validateAndGetClaims(token).getSubject());
    }

    /**
     * Returns {@code true} if the token is a valid access token (type = "access").
     *
     * @param token the JWT string
     * @return {@code true} if valid and type is access
     */
    public boolean isAccessToken(String token) {
        try {
            Claims claims = validateAndGetClaims(token);
            return "access".equals(claims.get("type", String.class));
        } catch (JwtException e) {
            return false;
        }
    }

    // ── Private ──────────────────────────────────────────────────────────────

    private String buildToken(String subject, String role, long expiryMs, String type) {
        Date now = new Date();
        Date expiry = new Date(now.getTime() + expiryMs);

        JwtBuilder builder = Jwts.builder()
                .subject(subject)
                .claim("type", type)
                .issuedAt(now)
                .expiration(expiry)
                .signWith(secretKey);

        if (role != null) builder.claim("role", role);
        return builder.compact();
    }
}
