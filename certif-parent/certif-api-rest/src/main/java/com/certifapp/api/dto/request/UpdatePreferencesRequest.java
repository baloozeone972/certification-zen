// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/dto/request/UpdatePreferencesRequest.java
package com.certifapp.api.dto.request;

import jakarta.validation.constraints.Pattern;

/**
 * HTTP request body for {@code PATCH /api/v1/users/me/preferences}.
 * All fields are optional — null means "keep current value".
 *
 * @param theme                  light | dark | system
 * @param language               BCP-47 tag
 * @param defaultMode            EXAM | FREE | REVISION
 * @param notificationsEnabled   push and email notification toggle
 */
public record UpdatePreferencesRequest(
        @Pattern(regexp = "light|dark|system") String theme,
        String language,
        @Pattern(regexp = "EXAM|FREE|REVISION") String defaultMode,
        Boolean notificationsEnabled
) {}
