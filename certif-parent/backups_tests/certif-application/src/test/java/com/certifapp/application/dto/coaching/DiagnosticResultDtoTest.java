package com.certifapp.application.dto.coaching;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.assertj.core.api.Assertions.assertThat;

@ExtendWith(MockitoExtension.class)
public class DiagnosticResultDtoTest {

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

        DiagnosticResultDto diagnosticResultDto = new DiagnosticResultDto(scoreByDomain, skillMap, recommendedCertifications);

        assertThat(diagnosticResultDto.scoreByDomain()).isEqualTo(Map.of("domain1", 85));
        assertThat(diagnosticResultDto.skillMap()).isEqualTo(Map.of("skill1", 0.9));
        assertThat(diagnosticResultDto.recommendedCertifications()).isEqualTo(List.of(new RecommendedCertificationDto("cert1", "Rationale1", 1)));
    }

    @DisplayName("DiagnosticResultDto with empty maps and lists")
    @Test
    public void diagnosticResultDto_emptyMapsAndLists() {
        Map<String, Integer> scoreByDomain = Map.of();
        Map<String, Double> skillMap = Map.of();
        List<RecommendedCertificationDto> recommendedCertifications = List.of();

        DiagnosticResultDto diagnosticResultDto = new DiagnosticResultDto(scoreByDomain, skillMap, recommendedCertifications);

        assertThat(diagnosticResultDto.scoreByDomain()).isEqualTo(Map.of());
        assertThat(diagnosticResultDto.skillMap()).isEqualTo(Map.of());
        assertThat(diagnosticResultDto.recommendedCertifications()).isEqualTo(List.of());
    }

    @DisplayName("DiagnosticResultDto null values")
    @Test
    public void diagnosticResultDto_nullValues() {
        Map<String, Integer> scoreByDomain = null;
        Map<String, Double> skillMap = null;
        List<RecommendedCertificationDto> recommendedCertifications = null;

        DiagnosticResultDto diagnosticResultDto = new DiagnosticResultDto(scoreByDomain, skillMap, recommendedCertifications);

        assertThat(diagnosticResultDto.scoreByDomain()).isNull();
        assertThat(diagnosticResultDto.skillMap()).isNull();
        assertThat(diagnosticResultDto.recommendedCertifications()).isNull();
    }

    @DisplayName("DiagnosticResultDto with invalid data types")
    @Test
    public void diagnosticResultDto_invalidDataTypes() {
        Map<String, Object> scoreByDomain = Map.of("domain1", "85");
        Map<String, Object> skillMap = Map.of("skill1", "0.9");
        List<Object> recommendedCertifications = List.of(new RecommendedCertificationDto("cert1", "Rationale1", 1));

        DiagnosticResultDto diagnosticResultDto = new DiagnosticResultDto(scoreByDomain, skillMap, recommendedCertifications);

        assertThat(diagnosticResultDto.scoreByDomain()).isEqualTo(Map.of("domain1", "85"));
        assertThat(diagnosticResultDto.skillMap()).isEqualTo(Map.of("skill1", "0.9"));
        assertThat(diagnosticResultDto.recommendedCertifications()).isEqualTo(List.of(new RecommendedCertificationDto("cert1", "Rationale1", 1)));
    }
}

