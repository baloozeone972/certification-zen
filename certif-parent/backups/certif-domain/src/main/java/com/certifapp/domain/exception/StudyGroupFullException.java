// certif-parent/certif-domain/src/main/java/com/certifapp/domain/exception/StudyGroupFullException.java
package com.certifapp.domain.exception;

/**
 * Thrown when a user tries to join a study group that has reached its member limit.
 */
public class StudyGroupFullException extends CertifAppException {

    private final java.util.UUID groupId;

    public StudyGroupFullException(java.util.UUID groupId, int maxMembers) {
        super("Study group " + groupId + " is full (max: " + maxMembers + ")");
        this.groupId = groupId;
    }

    public java.util.UUID getGroupId() {
        return groupId;
    }
}
