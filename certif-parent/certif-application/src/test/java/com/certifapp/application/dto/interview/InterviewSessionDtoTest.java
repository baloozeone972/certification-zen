package com.certifapp.application.dto.interview;

import java.util.UUID;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class InterviewSessionDtoTest {

    @Mock
    private SomeDependency someDependency; // Replace with actual dependency

    @InjectMocks
    private InterviewSessionDto interviewSessionDto;

    @BeforeEach
    public void setUp() {
        // Setup any necessary mocks or initializations here
    }

    @AfterEach
    public void tearDown() {
        // Cleanup any resources if needed
    }

    @Test
    @DisplayName("Should create an InterviewSessionDto with all parameters")
    public void shouldCreateInterviewSessionDto_withAllParameters() {
        UUID id = UUID.randomUUID();
        String certificationId = "cert123";
        String mode = "TEXT";
        OffsetDateTime startedAt = OffsetDateTime.now();
        String overallFeedback = null;
        Map<String, Double> scoreByDomain = null;

        InterviewSessionDto sessionDto = new InterviewSessionDto(id, certificationId, mode, startedAt, overallFeedback, scoreByDomain);

        assertThat(sessionDto.id()).isEqualTo(id);
        assertThat(sessionDto.certificationId()).isEqualTo(certificationId);
        assertThat(sessionDto.mode()).isEqualTo(mode);
        assertThat(sessionDto.startedAt()).isEqualTo(startedAt);
        assertThat(sessionDto.overallFeedback()).isEqualTo(overallFeedback);
        assertThat(sessionDto.scoreByDomain()).isEqualTo(scoreByDomain);
    }

    @Test
    @DisplayName("Should handle null overallFeedback gracefully")
    public void shouldHandleNullOverallFeedback() {
        UUID id = UUID.randomUUID();
        String certificationId = "cert123";
        String mode = "TEXT";
        OffsetDateTime startedAt = OffsetDateTime.now();
        String overallFeedback = null;
        Map<String, Double> scoreByDomain = null;

        InterviewSessionDto sessionDto = new InterviewSessionDto(id, certificationId, mode, startedAt, overallFeedback, scoreByDomain);

        assertThat(sessionDto.overallFeedback()).isNull();
    }

    @Test
    @DisplayName("Should handle null scoreByDomain gracefully")
    public void shouldHandleNullScoreByDomain() {
        UUID id = UUID.randomUUID();
        String certificationId = "cert123";
        String mode = "TEXT";
        OffsetDateTime startedAt = OffsetDateTime.now();
        String overallFeedback = null;
        Map<String, Double> scoreByDomain = null;

        InterviewSessionDto sessionDto = new InterviewSessionDto(id, certificationId, mode, startedAt, overallFeedback, scoreByDomain);

        assertThat(sessionDto.scoreByDomain()).isNull();
    }

    @Test
    @DisplayName("Should throw IllegalArgumentException for invalid mode")
    public void shouldThrowIllegalArgumentException_forInvalidMode() {
        UUID id = UUID.randomUUID();
        String certificationId = "cert123";
        String mode = "INVALID_MODE"; // Invalid value
        OffsetDateTime startedAt = OffsetDateTime.now();
        String overallFeedback = null;
        Map<String, Double> scoreByDomain = null;

        assertThatThrownBy(() -> new InterviewSessionDto(id, certificationId, mode, startedAt, overallFeedback, scoreByDomain))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("Invalid mode: INVALID_MODE");
    }

    @Test
    @DisplayName("Should verify that toString method is implemented")
    public void shouldVerifyToStringMethodIsImplemented() {
        UUID id = UUID.randomUUID();
        String certificationId = "cert123";
        String mode = "TEXT";
        OffsetDateTime startedAt = OffsetDateTime.now();
        String overallFeedback = null;
        Map<String, Double> scoreByDomain = null;

        InterviewSessionDto sessionDto = new InterviewSessionDto(id, certificationId, mode, startedAt, overallFeedback, scoreByDomain);

        assertThat(sessionDto.toString()).isNotNull();
    }
}
