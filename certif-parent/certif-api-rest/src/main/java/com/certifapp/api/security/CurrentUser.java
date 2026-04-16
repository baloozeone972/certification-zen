// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/security/CurrentUser.java
package com.certifapp.api.security;

import org.springframework.security.core.context.SecurityContextHolder;

import java.util.UUID;

/**
 * Utility class to extract the authenticated user's UUID from the security context.
 *
 * <p>Usage in controllers:
 * {@code UUID userId = CurrentUser.id();}</p>
 */
public final class CurrentUser {

    private CurrentUser() {}

    /**
     * Returns the UUID of the currently authenticated user.
     *
     * @return the user UUID extracted from the JWT subject claim
     * @throws IllegalStateException if no authenticated user is present in the context
     */
    public static UUID id() {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || !auth.isAuthenticated() || auth.getPrincipal() == null) {
            throw new IllegalStateException("No authenticated user in security context");
        }
        return UUID.fromString(auth.getPrincipal().toString());
    }
}
