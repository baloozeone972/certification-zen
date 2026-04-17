// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/dto/request/CreateGroupRequest.java
package com.certifapp.api.dto.request;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/**
 * HTTP request body for {@code POST /api/v1/community/groups}.
 *
 * @param name            group display name
 * @param certificationId target certification
 * @param maxMembers      member capacity (2-50)
 * @param isPublic        whether the group is publicly listed
 */
public record CreateGroupRequest(
        @NotBlank @Size(max = 100) String name,
        @NotBlank String certificationId,
        @Min(2) @Max(50) int maxMembers,
        boolean isPublic
) {
}
