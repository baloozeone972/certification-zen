package com.certifapp.application.dto.community;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.OffsetDateTime;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;

@ExtendWith(MockitoExtension.class)
public class WeeklyChallengeDtoTest {

    @InjectMocks
    private WeeklyChallengeDto weeklyChallengeDto;

    @BeforeEach
    public void setUp() {
        UUID id = UUID.randomUUID();
        String title = "Sample Challenge";
        String certificationId = "cert123";
        String themeCode = "tech";
        OffsetDateTime startsAt = OffsetDateTime.now().minusDays(1);
        OffsetDateTime endsAt = OffsetDateTime.now().plusDays(1);
        int totalParticipants = 50;
        int questionCount = 10;

        weeklyChallengeDto = new WeeklyChallengeDto(id, title, certificationId, themeCode, startsAt, endsAt, totalParticipants, questionCount);
    }

    @Test
    @DisplayName("Should return the correct challenge ID")
    public void getId_challengeExists_expectedId() {
        assertThat(weeklyChallengeDto.getId()).isEqualTo(weeklyChallengeDto.id());
    }

    @Test
    @DisplayName("Should return the correct challenge title")
    public void getTitle_challengeExists_expectedTitle() {
        assertThat(weeklyChallengeDto.getTitle()).isEqualTo(weeklyChallengeDto.title());
    }

    @Test
    @DisplayName("Should return the correct certification ID")
    public void getCertificationId_challengeExists_expectedCertificationId() {
        assertThat(weeklyChallengeDto.getCertificationId()).isEqualTo(weeklyChallengeDto.certificationId());
    }

    @Test
    @DisplayName("Should return the correct theme code")
    public void getThemeCode_challengeExists_expectedThemeCode() {
        assertThat(weeklyChallengeDto.getThemeCode()).isEqualTo(weeklyChallengeDto.themeCode());
    }

    @Test
    @DisplayName("Should return the correct start time")
    public void getStartsAt_challengeExists_expectedStartTime() {
        assertThat(weeklyChallengeDto.getStartsAt()).isEqualTo(weeklyChallengeDto.startsAt());
    }

    @Test
    @DisplayName("Should return the correct end time")
    public void getEndsAt_challengeExists_expectedEndTime() {
        assertThat(weeklyChallengeDto.getEndsAt()).isEqualTo(weeklyChallengeDto.endsAt());
    }

    @Test
    @DisplayName("Should return the correct total participants")
    public void getTotalParticipants_challengeExists_expectedTotalParticipants() {
        assertThat(weeklyChallengeDto.getTotalParticipants()).isEqualTo(weeklyChallengeDto.totalParticipants());
    }

    @Test
    @DisplayName("Should return the correct question count")
    public void getQuestionCount_challengeExists_expectedQuestionCount() {
        assertThat(weeklyChallengeDto.getQuestionCount()).isEqualTo(weeklyChallengeDto.questionCount());
    }
}