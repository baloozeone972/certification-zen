// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/community/StudyGroupDto.java
package com.certifapp.application.dto.community;

import java.util.UUID;

/**
 * Study group summary.
 *
 * @param id               group UUID
 * @param name             group name
 * @param certificationId  target certification
 * @param memberCount      current number of members
 * @param maxMembers       member capacity
 * @param isPublic         whether the group is publicly listed
 * @param inviteCode       short code to join (null for private groups returned to non-members)
 */
public record StudyGroupDto(
        UUID    id,
        String  name,
        String  certificationId,
        int     memberCount,
        int     maxMembers,
        boolean isPublic,
        String  inviteCode
) {}
