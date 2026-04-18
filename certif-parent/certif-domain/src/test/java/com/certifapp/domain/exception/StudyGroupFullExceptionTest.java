package com.certifapp.domain.exception;

import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class StudyGroupFullExceptionTest {

    @InjectMocks
    private StudyGroupFullException studyGroupFullException;

    @Mock
    private CertifAppException certifAppException;

    @BeforeEach
    public void setUp() {
        when(certifAppException.getMessage()).thenReturn("Study group UUID is full (max: 10)");
    }

    @AfterEach
    public void tearDown() {
        verifyNoMoreInteractions(certifAppException);
    }

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
        UUID groupId = UUID.randomUUID();
        when(certifAppException.getMessage()).thenReturn("Study group (null) is full (max: 10)");

        StudyGroupFullException exception = new StudyGroupFullException(groupId, 10);

        assertThat(exception.getMessage()).isEqualTo("Study group " + groupId + " is full (max: 10)");
        assertThat(exception.getGroupId()).isEqualTo(groupId);
    }

    @DisplayName("Test error case with negative max members")
    @Test
    public void testConstructor_NegativeMaxMembers_expectedBehavior() {
        UUID groupId = UUID.randomUUID();
        when(certifAppException.getMessage()).thenReturn("Study group UUID is full (max: -5)");

        StudyGroupFullException exception = new StudyGroupFullException(groupId, -5);

        assertThat(exception.getMessage()).isEqualTo("Study group " + groupId + " is full (max: -5)");
        assertThat(exception.getGroupId()).isEqualTo(groupId);
    }
}
