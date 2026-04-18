package com.certifapp.application.dto.learning;

import java.util.UUID;
import org.junit.jupiter.api.extension.ExtendWith;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

import java.time.LocalDate;
import java.util.Collections;
import java.util.List;

@ExtendWith(MockitoExtension.class)
public class AdaptivePlanDtoTest {

    @Mock
    private SomeDependency someDependency; // Replace with actual dependency

    @InjectMocks
    private AdaptivePlanService adaptivePlanService; // Replace with actual service using AdaptivePlanDto

    @BeforeEach
    public void setUp() {
        // Setup any initial conditions before each test
    }

    @Test
    @DisplayName("nominal case: creating an AdaptivePlanDto with valid values")
    public void createAdaptivePlanDto_validValues_success() {
        UUID userId = UUID.randomUUID();
        String certificationId = "cert123";
        int dueTodayCount = 5;
        List<String> weakThemes = List.of("theme1", "theme2");
        double predictedScore = 80.5;
        LocalDate recommendedExamDate = LocalDate.now().plusDays(7);

        AdaptivePlanDto adaptivePlanDto = new AdaptivePlanDto(
                userId,
                certificationId,
                dueTodayCount,
                weakThemes,
                predictedScore,
                recommendedExamDate
        );

        assertThat(adaptivePlanDto.userId()).isEqualTo(userId);
        assertThat(adaptivePlanDto.certificationId()).isEqualTo(certificationId);
        assertThat(adaptivePlanDto.dueTodayCount()).isEqualTo(dueTodayCount);
        assertThat(adaptivePlanDto.weakThemes()).isEqualTo(weakThemes);
        assertThat(adaptivePlanDto.predictedScore()).isEqualTo(predictedScore);
        assertThat(adaptivePlanDto.recommendedExamDate()).isEqualTo(recommendedExamDate);
    }

    @Test
    @DisplayName("edge case: creating an AdaptivePlanDto with null weakThemes")
    public void createAdaptivePlanDto_nullWeakThemes_success() {
        UUID userId = UUID.randomUUID();
        String certificationId = "cert123";
        int dueTodayCount = 5;
        double predictedScore = 80.5;
        LocalDate recommendedExamDate = LocalDate.now().plusDays(7);

        AdaptivePlanDto adaptivePlanDto = new AdaptivePlanDto(
                userId,
                certificationId,
                dueTodayCount,
                null,
                predictedScore,
                recommendedExamDate
        );

        assertThat(adaptivePlanDto.userId()).isEqualTo(userId);
        assertThat(adaptivePlanDto.certificationId()).isEqualTo(certificationId);
        assertThat(adaptivePlanDto.dueTodayCount()).isEqualTo(dueTodayCount);
        assertThat(adaptivePlanDto.weakThemes()).isNull();
        assertThat(adaptivePlanDto.predictedScore()).isEqualTo(predictedScore);
        assertThat(adaptivePlanDto.recommendedExamDate()).isEqualTo(recommendedExamDate);
    }

    @Test
    @DisplayName("error case: creating an AdaptivePlanDto with negative dueTodayCount")
    public void createAdaptivePlanDto_negativeDueTodayCount_exception() {
        UUID userId = UUID.randomUUID();
        String certificationId = "cert123";
        int dueTodayCount = -5;
        double predictedScore = 80.5;
        LocalDate recommendedExamDate = LocalDate.now().plusDays(7);

        assertThatExceptionOfType(IllegalArgumentException.class)
                .isThrownBy(() -> new AdaptivePlanDto(
                        userId,
                        certificationId,
                        dueTodayCount,
                        Collections.emptyList(),
                        predictedScore,
                        recommendedExamDate
                ))
                .withMessage("dueTodayCount must be non-negative");
    }

    @Test
    @DisplayName("error case: creating an AdaptivePlanDto with negative predictedScore")
    public void createAdaptivePlanDto_negativePredictedScore_exception() {
        UUID userId = UUID.randomUUID();
        String certificationId = "cert123";
        int dueTodayCount = 5;
        double predictedScore = -80.5;
        LocalDate recommendedExamDate = LocalDate.now().plusDays(7);

        assertThatExceptionOfType(IllegalArgumentException.class)
                .isThrownBy(() -> new AdaptivePlanDto(
                        userId,
                        certificationId,
                        dueTodayCount,
                        Collections.emptyList(),
                        predictedScore,
                        recommendedExamDate
                ))
                .withMessage("predictedScore must be between 0 and 100");
    }

    @Test
    @DisplayName("error case: creating an AdaptivePlanDto with predictedScore greater than 100")
    public void createAdaptivePlanDto_predictedScoreGreaterThan100_exception() {
        UUID userId = UUID.randomUUID();
        String certificationId = "cert123";
        int dueTodayCount = 5;
        double predictedScore = 110.5;
        LocalDate recommendedExamDate = LocalDate.now().plusDays(7);

        assertThatExceptionOfType(IllegalArgumentException.class)
                .isThrownBy(() -> new AdaptivePlanDto(
                        userId,
                        certificationId,
                        dueTodayCount,
                        Collections.emptyList(),
                        predictedScore,
                        recommendedExamDate
                ))
                .withMessage("predictedScore must be between 0 and 100");
    }
}
