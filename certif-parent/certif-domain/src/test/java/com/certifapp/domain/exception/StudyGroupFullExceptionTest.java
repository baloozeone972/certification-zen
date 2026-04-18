package com.certifapp.domain.exception;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;

public class StudyGroupFullExceptionTest {

    @DisplayName("Test nominal case with non-empty group ID")
    @Test
    public void testConstructor_NonEmptyGroupId_expectedBehavior() {
        UUID groupId = UUID.randomUUID();
        StudyGroupFullException exception = new StudyGroupFullException(groupId, 10);

        assertThat(exception.getMessage()).isEqualTo("Study group " + groupId + " is full (max: 10)");
        assertThat(exception.getGroupId()).isEqualTo(groupId);
    }

    @DisplayName("Test edge case with empty group ID")
    @Test
    public void testConstructor_EmptyGroupId_expectedBehavior() {
        UUID groupId = null;
        StudyGroupFullException exception = new StudyGroupFullException(groupId, 10);

        assertThat(exception.getMessage()).isEqualTo("Study group (null) is full (max: 10)");
        assertThat(exception.getGroupId()).isEqualTo(groupId);
    }

    @DisplayName("Test error case with negative max members")
    @Test
    public void testConstructor_NegativeMaxMembers_expectedBehavior() {
        UUID groupId = UUID.randomUUID();
        StudyGroupFullException exception = new StudyGroupFullException(groupId, -5);

        assertThat(exception.getMessage()).isEqualTo("Study group " + groupId + " is full (max: -5)");
        assertThat(exception.getGroupId()).isEqualTo(groupId);
    }
}