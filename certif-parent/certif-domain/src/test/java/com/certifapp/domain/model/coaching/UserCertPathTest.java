package com.certifapp.domain.model.coaching;

import java.util.UUID;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import org.mockito.junit.jupiter.MockitoExtension;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

import java.time.OffsetDateTime;
import java.util.List;

@ExtendWith(MockitoExtension.class)
public class UserCertPathTest {

    @InjectMocks
    private UserCertPath userCertPath;

    @BeforeEach
    public void setUp() {
        userCertPath = new UserCertPath(
                UUID.randomUUID(),
                UUID.randomUUID(),
                "Java Developer",
                "Learn Java for project X",
                List.of(new PathStep("cert1", 1, "Initial step", 4)),
                "AI rationale",
                OffsetDateTime.now(),
                OffsetDateTime.now()
        );
    }

    @Test
    @DisplayName("UserCertPath should be created with valid parameters")
    public void testConstructor_NominalCase() {
        assertThat(userCertPath).isNotNull();
        assertThat(userCertPath.userId()).isNotNull();
        assertThat(userCertPath.roleType()).isEqualTo("Java Developer");
        assertThat(userCertPath.projectGoal()).isEqualTo("Learn Java for project X");
        assertThat(userCertPath.steps()).hasSize(1);
        assertThat(userCertPath.aiRationale()).isEqualTo("AI rationale");
    }

    @Test
    @DisplayName("UserCertPath should throw IllegalArgumentException if userId is null")
    public void testConstructor_UserIdNull() {
        UUID nullUUID = null;
        assertThrows(IllegalArgumentException.class, () -> new UserCertPath(
                nullUUID,
                UUID.randomUUID(),
                "Java Developer",
                "Learn Java for project X",
                List.of(new PathStep("cert1", 1, "Initial step", 4)),
                "AI rationale",
                OffsetDateTime.now(),
                OffsetDateTime.now()
        ));
    }

    @Test
    @DisplayName("UserCertPath should create an empty list if steps are null")
    public void testConstructor_StepsNull() {
        UUID userId = UUID.randomUUID();
        UserCertPath pathWithNullSteps = new UserCertPath(
                UUID.randomUUID(),
                userId,
                "Java Developer",
                "Learn Java for project X",
                null,
                "AI rationale",
                OffsetDateTime.now(),
                OffsetDateTime.now()
        );
        assertThat(pathWithNullSteps.steps()).isEmpty();
    }

    @Test
    @DisplayName("UserCertPath should create an immutable copy of steps")
    public void testConstructor_StepsMutable() {
        UUID userId = UUID.randomUUID();
        List<PathStep> mutableSteps = List.of(new PathStep("cert1", 1, "Initial step", 4));
        UserCertPath pathWithMutableSteps = new UserCertPath(
                UUID.randomUUID(),
                userId,
                "Java Developer",
                "Learn Java for project X",
                mutableSteps,
                "AI rationale",
                OffsetDateTime.now(),
                OffsetDateTime.now()
        );
        assertThat(pathWithMutableSteps.steps()).isNotSameAs(mutableSteps);
    }

    @Test
    @DisplayName("PathStep should be created with valid parameters")
    public void testPathStep_NominalCase() {
        PathStep step = new PathStep("cert1", 1, "Initial step", 4);
        assertThat(step).isNotNull();
        assertThat(step.certificationId()).isEqualTo("cert1");
        assertThat(step.order()).isEqualTo(1);
        assertThat(step.rationale()).isEqualTo("Initial step");
        assertThat(step.estimatedWeeks()).isEqualTo(4);
    }

    @Test
    @DisplayName("PathStep should throw IllegalArgumentException if certificationId is blank")
    public void testPathStep_CertificationIdBlank() {
        assertThrows(IllegalArgumentException.class, () -> new PathStep(
                "  ",
                1,
                "Initial step",
                4
        ));
    }

    @Test
    @DisplayName("PathStep should throw IllegalArgumentException if order is less than 1")
    public void testPathStep_OrderLessThanOne() {
        assertThrows(IllegalArgumentException.class, () -> new PathStep(
                "cert1",
                0,
                "Initial step",
                4
        ));
    }

    @Test
    @DisplayName("PathStep should throw IllegalArgumentException if estimatedWeeks is less than 0")
    public void testPathStep_EstimatedWeeksLessThanZero() {
        assertThrows(IllegalArgumentException.class, () -> new PathStep(
                "cert1",
                1,
                "Initial step",
                -1
        ));
    }
}
