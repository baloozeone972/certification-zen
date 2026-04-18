package com.certifapp.application.dto.community;

import java.util.UUID;
import org.junit.jupiter.api.extension.ExtendWith;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class LeaderboardEntryDtoTest {

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @DisplayName("Nominal case: create a LeaderboardEntryDto with all fields")
    @Test
    public void constructor_allFields_setCorrectly() {
        int rank = 1;
        UUID userId = UUID.randomUUID();
        String displayName = "JohnDoe";
        int score = 10;
        double percentage = 90.0;
        String badgeEarned = "GOLD";
        String countryCode = "US";

        LeaderboardEntryDto dto = new LeaderboardEntryDto(rank, userId, displayName, score, percentage, badgeEarned, countryCode);

        assertThat(dto.rank()).isEqualTo(rank);
        assertThat(dto.userId()).isEqualTo(userId);
        assertThat(dto.displayName()).isEqualTo(displayName);
        assertThat(dto.score()).isEqualTo(score);
        assertThat(dto.percentage()).isEqualTo(percentage);
        assertThat(dto.badgeEarned()).isEqualTo(badgeEarned);
        assertThat(dto.countryCode()).isEqualTo(countryCode);
    }

    @DisplayName("Edge case: create a LeaderboardEntryDto with zero rank")
    @Test
    public void constructor_zeroRank_setCorrectly() {
        int rank = 0;
        UUID userId = UUID.randomUUID();
        String displayName = "JohnDoe";
        int score = 10;
        double percentage = 90.0;
        String badgeEarned = "GOLD";
        String countryCode = "US";

        LeaderboardEntryDto dto = new LeaderboardEntryDto(rank, userId, displayName, score, percentage, badgeEarned, countryCode);

        assertThat(dto.rank()).isEqualTo(1); // Rank should be at least 1
    }

    @DisplayName("Edge case: create a LeaderboardEntryDto with null display name")
    @Test
    public void constructor_nullDisplayName_setCorrectly() {
        int rank = 1;
        UUID userId = UUID.randomUUID();
        String displayName = null;
        int score = 10;
        double percentage = 90.0;
        String badgeEarned = "GOLD";
        String countryCode = "US";

        LeaderboardEntryDto dto = new LeaderboardEntryDto(rank, userId, displayName, score, percentage, badgeEarned, countryCode);

        assertThat(dto.displayName()).isEqualTo(""); // Display name should be an empty string if null
    }

    @DisplayName("Edge case: create a LeaderboardEntryDto with negative score")
    @Test
    public void constructor_negativeScore_setCorrectly() {
        int rank = 1;
        UUID userId = UUID.randomUUID();
        String displayName = "JohnDoe";
        int score = -5;
        double percentage = 90.0;
        String badgeEarned = "GOLD";
        String countryCode = "US";

        LeaderboardEntryDto dto = new LeaderboardEntryDto(rank, userId, displayName, score, percentage, badgeEarned, countryCode);

        assertThat(dto.score()).isEqualTo(0); // Score should be at least 0
    }

    @DisplayName("Edge case: create a LeaderboardEntryDto with empty country code")
    @Test
    public void constructor_emptyCountryCode_setCorrectly() {
        int rank = 1;
        UUID userId = UUID.randomUUID();
        String displayName = "JohnDoe";
        int score = 10;
        double percentage = 90.0;
        String badgeEarned = "GOLD";
        String countryCode = "";

        LeaderboardEntryDto dto = new LeaderboardEntryDto(rank, userId, displayName, score, percentage, badgeEarned, countryCode);

        assertThat(dto.countryCode()).isEqualTo("US"); // Country code should be "US" if empty
    }

    @DisplayName("Error case: create a LeaderboardEntryDto with null user ID")
    @Test
    public void constructor_nullUserId_throwException() {
        int rank = 1;
        UUID userId = null;
        String displayName = "JohnDoe";
        int score = 10;
        double percentage = 90.0;
        String badgeEarned = "GOLD";
        String countryCode = "US";

        Exception exception = assertThrows(NullPointerException.class, () -> {
            new LeaderboardEntryDto(rank, userId, displayName, score, percentage, badgeEarned, countryCode);
        });

        assertThat(exception.getMessage()).isEqualTo("userId must not be null");
    }
}
