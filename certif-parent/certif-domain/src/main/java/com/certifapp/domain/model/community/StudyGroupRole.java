// certif-domain/src/main/java/com/certifapp/domain/model/community/StudyGroupRole.java
package com.certifapp.domain.model.community;

/**
 * Role of a member within a {@link StudyGroup}.
 *
 * <p>Maps to the {@code role VARCHAR(20)} column in {@code study_group_members}.</p>
 */
public enum StudyGroupRole {

    /**
     * Group creator — can delete the group and manage members.
     */
    OWNER,

    /**
     * Trusted member — can kick members and pin messages.
     */
    MODERATOR,

    /**
     * Regular participant.
     */
    MEMBER;

    /**
     * Returns {@code true} if this role grants moderation privileges.
     *
     * @return {@code true} for {@code OWNER} and {@code MODERATOR}
     */
    public boolean canModerate() {
        return this == OWNER || this == MODERATOR;
    }
}
