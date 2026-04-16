// certif-domain/src/main/java/com/certifapp/domain/model/user/UserRole.java
package com.certifapp.domain.model.user;

/**
 * Security role assigned to a {@link User}.
 *
 * <p>Maps to the {@code role VARCHAR(20)} column with CHECK constraint
 * {@code IN ('USER', 'ADMIN', 'PARTNER')}.</p>
 *
 * <p>Spring Security uses these values as granted authorities
 * prefixed with {@code ROLE_} (e.g. {@code ROLE_ADMIN}).</p>
 */
public enum UserRole {

    /** Standard end-user — access to all public and freemium features. */
    USER,

    /** Back-office administrator — access to question enrichment, challenge publishing, metrics. */
    ADMIN,

    /** API partner — programmatic access for B2B integrations. */
    PARTNER
}
