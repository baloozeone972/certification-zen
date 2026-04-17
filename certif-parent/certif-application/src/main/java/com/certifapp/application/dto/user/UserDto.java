// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/user/UserDto.java
package com.certifapp.application.dto.user;

import java.time.OffsetDateTime;
import java.util.UUID;

/**
 * User profile data returned by the API. Never includes passwordHash.
 *
 * @param id               user UUID
 * @param email            email address
 * @param role             USER | ADMIN | PARTNER
 * @param subscriptionTier FREE | PRO | PACK
 * @param locale           BCP-47 locale
 * @param timezone         IANA timezone
 * @param createdAt        account creation timestamp
 */
public record UserDto(
        UUID id,
        String email,
        String role,
        String subscriptionTier,
        String locale,
        String timezone,
        OffsetDateTime createdAt
) {
}
