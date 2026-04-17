// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/security/JwtAuthenticationFilter.java
package com.certifapp.api.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.List;

/**
 * JWT authentication filter — runs once per request.
 *
 * <p>Extracts the Bearer token from the {@code Authorization} header,
 * validates it, and populates the Spring Security context with a
 * {@link UsernamePasswordAuthenticationToken}.</p>
 *
 * <p>Requests without a valid token pass through unauthenticated —
 * access control is handled by {@link SecurityConfig}.</p>
 */
@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtTokenProvider tokenProvider;

    public JwtAuthenticationFilter(JwtTokenProvider tokenProvider) {
        this.tokenProvider = tokenProvider;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain chain)
            throws ServletException, IOException {

        String token = extractToken(request);

        if (token != null && tokenProvider.isAccessToken(token)) {
            try {
                var claims = tokenProvider.validateAndGetClaims(token);
                String userId = claims.getSubject();
                String role = claims.get("role", String.class);

                var auth = new UsernamePasswordAuthenticationToken(
                        userId,
                        null,
                        role != null ? List.of(new SimpleGrantedAuthority("ROLE_" + role))
                                : List.of()
                );
                SecurityContextHolder.getContext().setAuthentication(auth);

            } catch (Exception ignored) {
                // Invalid token — let it pass unauthenticated (403 handled by SecurityConfig)
                SecurityContextHolder.clearContext();
            }
        }

        chain.doFilter(request, response);
    }

    private String extractToken(HttpServletRequest request) {
        String header = request.getHeader("Authorization");
        if (header != null && header.startsWith("Bearer ")) {
            return header.substring(7).trim();
        }
        return null;
    }
}
