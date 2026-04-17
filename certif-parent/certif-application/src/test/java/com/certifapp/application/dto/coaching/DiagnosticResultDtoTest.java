package com.certifapp.application.dto.coaching;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.assertj.core.api.Assertions.assertThat;

@ExtendWith(MockitoExtension.class)
public class DiagnosticResultDtoTest {

    @Mock
    private SomeService someService; // Mock any dependencies if needed

    @InjectMocks
    private DiagnosticResultDto diagnosticResultDto;

    @BeforeEach
    public void setUp() {
        // Setup code if needed
    }

    @DisplayName("DiagnosticResultDto nominal case")
    @Test
    public void diagnosticResultDto_nominalCase() {
        Map<String, Integer> scoreByDomain = Map.of("domain1", 85);
        Map<String, Double> skillMap = Map.of("skill1", 0.9);
        List<RecommendedCertificationDto> recommendedCertifications = List.of(new RecommendedCertificationDto("cert1", "Rationale1", 1));

        DiagnosticResultDto result = diagnosticResultDto.createDiagnosticResultDto(scoreByDomain, skillMap, recommendedCertifications);

        assertThat(result.scoreByDomain()).isEqualTo(Map.of("domain1", 85));
        assertThat(result.skillMap()).isEqualTo(Map.of("skill1", 0.9));
        assertThat(result.recommendedCertifications()).isEqualTo(List.of(new RecommendedCertificationDto("cert1", "Rationale1", 1)));
    }

    @DisplayName("DiagnosticResultDto with empty maps and lists")
    @Test
    public void diagnosticResultDto_emptyMapsAndLists() {
        Map<String, Integer> scoreByDomain = Map.of();
        Map<String, Double> skillMap = Map.of();
        List<RecommendedCertificationDto> recommendedCertifications = List.of();

        DiagnosticResultDto result = diagnosticResultDto.createDiagnosticResultDto(scoreByDomain, skillMap, recommendedCertifications);

        assertThat(result.scoreByDomain()).isEqualTo(Map.of());
        assertThat(result.skillMap()).isEqualTo(Map.of());
        assertThat(result.recommendedCertifications()).isEqualTo(List.of());
    }

    @DisplayName("DiagnosticResultDto null values")
    @Test
    public void diagnosticResultDto_nullValues() {
        Map<String, Integer> scoreByDomain = null;
        Map<String, Double> skillMap = null;
        List<RecommendedCertificationDto> recommendedCertifications = null;

        DiagnosticResultDto result = diagnosticResultDto.createDiagnosticResultDto(scoreByDomain, skillMap, recommendedCertifications);

        assertThat(result.scoreByDomain()).isNull();
        assertThat(result.skillMap()).isNull();
        assertThat(result.recommendedCertifications()).isNull();
    }

    @DisplayName("DiagnosticResultDto with invalid data types")
    @Test
    public void diagnosticResultDto_invalidDataTypes() {
        Map<String, Object> scoreByDomain = Map.of("domain1", "85");
        Map<String, Object> skillMap = Map.of("skill1", "0.9");
        List<Object> recommendedCertifications = List.of(new RecommendedCertificationDto("cert1", "Rationale1", 1));

        DiagnosticResultDto result = diagnosticResultDto.createDiagnosticResultDto(scoreByDomain, skillMap, recommendedCertifications);

        assertThat(result.scoreByDomain()).isEqualTo(Map.of("domain1", "85"));
        assertThat(result.skillMap()).isEqualTo(Map.of("skill1", "0.9"));
        assertThat(result.recommendedCertifications()).isEqualTo(List.of(new RecommendedCertificationDto("cert1", "Rationale1", 1)));
    }
}