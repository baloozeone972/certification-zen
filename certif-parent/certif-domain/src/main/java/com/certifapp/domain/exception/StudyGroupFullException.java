// certif-parent/certif-domain/src/main/java/com/certifapp/domain/exception/StudyGroupFullException.java
package com.certifapp.domain.exception;

/**
 * Thrown when a user tries to join a study group that has reached its member limit.
 */
public record StudyGroupFullException(java.util.UUID groupId, int maxMembers) extends CertifAppException {

    public StudyGroupFullException {
        super("Study group " + groupId + " is full (max: " + maxMembers + ")");
    }
}