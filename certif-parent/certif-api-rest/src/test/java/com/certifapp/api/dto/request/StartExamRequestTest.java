package com.certifapp.api.dto.request;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.assertj.core.api.Assertions.assertThat;

@ExtendWith(MockitoExtension.class)
public class StartExamRequestTest {

    @InjectMocks
    private StartExamRequest startExamRequest;

    private MockMvc mockMvc;

    @BeforeEach
    public void setUp() {
        mockMvc = MockMvcBuilders.standaloneSetup(startExamRequest).build();
    }

    @DisplayName("Valid request with default values")
    @Test
    public void startExamRequest_defaultValues_validRequest() {
        assertThat(startExamRequest.certificationId()).isNotBlank();
        assertThat(startExamRequest.mode()).isEqualTo("EXAM");
        assertThat(startExamRequest.selectedThemes()).isEmpty();
        assertThat(startExamRequest.questionCount()).isEqualTo(0);
        assertThat(startExamRequest.durationMinutes()).isEqualTo(0);
    }

    @DisplayName("Valid request with custom values")
    @Test
    public void startExamRequest_customValues_validRequest() {
        StartExamRequest request = new StartExamRequest(
                "certification-slug", "FREE",
                List.of("THEME1", "THEME2"), 50, 60);

        assertThat(request.certificationId()).isEqualTo("certification-slug");
        assertThat(request.mode()).isEqualTo("FREE");
        assertThat(request.selectedThemes()).containsExactly("THEME1", "THEME2");
        assertThat(request.questionCount()).isEqualTo(50);
        assertThat(request.durationMinutes()).isEqualTo(60);
    }

    @DisplayName("Invalid request with null certificationId")
    @Test
    public void startExamRequest_nullCertificationId_invalidRequest() {
        try {
            new StartExamRequest(null, "EXAM", List.of(), 0, 0);
        } catch (IllegalArgumentException e) {
            assertThat(e.getMessage()).contains("must not be blank");
        }
    }

    @DisplayName("Invalid request with empty certificationId")
    @Test
    public void startExamRequest_emptyCertificationId_invalidRequest() {
        try {
            new StartExamRequest("", "EXAM", List.of(), 0, 0);
        } catch (IllegalArgumentException e) {
            assertThat(e.getMessage()).contains("must not be blank");
        }
    }

    @DisplayName("Invalid request with invalid mode")
    @Test
    public void startExamRequest_invalidMode_invalidRequest() {
        try {
            new StartExamRequest("certification-slug", "INVALID_MODE", List.of(), 0, 0);
        } catch (IllegalArgumentException e) {
            assertThat(e.getMessage()).contains("must match \"EXAM|FREE|REVISION\"");
        }
    }

    @DisplayName("Invalid request with questionCount greater than max")
    @Test
    public void startExamRequest_questionCountGreaterThanMax_invalidRequest() {
        try {
            new StartExamRequest("certification-slug", "EXAM", List.of(), 201, 0);
        } catch (IllegalArgumentException e) {
            assertThat(e.getMessage()).contains("must be less than or equal to 200");
        }
    }

    @DisplayName("Invalid request with negative durationMinutes")
    @Test
    public void startExamRequest_negativeDurationMinutes_invalidRequest() {
        try {
            new StartExamRequest("certification-slug", "EXAM", List.of(), 0, -1);
        } catch (IllegalArgumentException e) {
            assertThat(e.getMessage()).contains("must be greater than or equal to 0");
        }
    }

}