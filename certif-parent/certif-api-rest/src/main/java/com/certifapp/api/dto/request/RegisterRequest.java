// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/dto/request/RegisterRequest.java
package com.certifapp.api.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/**
 * HTTP request body for {@code POST /api/v1/auth/register}.
 *
 * @param email    user email — must be unique and valid format
 * @param password plain-text password — minimum 8 characters
 * @param locale   BCP-47 locale tag (default: fr)
 * @param timezone IANA timezone (default: Europe/Paris)
 */
public record RegisterRequest(
        @NotBlank @Email(message = "Email invalide")
        String email,

        @NotBlank @Size(min = 8, message = "Le mot de passe doit contenir au moins 8 caractères")
        String password,

        @Size(max = 10)
        String locale,

        @Size(max = 50)
        String timezone
) {
}
