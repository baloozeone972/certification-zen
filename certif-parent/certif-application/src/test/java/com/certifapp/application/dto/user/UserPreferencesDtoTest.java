package com.certifapp.application.dto.user;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;

import static org.assertj.core.api.Assertions.assertThat;

@ExtendWith(MockitoExtension.class)
public class UserPreferencesDtoTest {

    @InjectMocks
    private UserPreferencesDto userPreferencesDto;

    @BeforeEach
    public void setUp() {
        userPreferencesDto = new UserPreferencesDto(
                "light",
                "en-US",
                "EXAM",
                true,
                "cert123",
                50,
                60
        );
    }

    @Test
    @DisplayName("should return the correct theme")
    public void getTheme_stateUnderTest_expectedBehavior() {
        assertThat(userPreferencesDto.theme()).isEqualTo("light");
    }

    @Test
    @DisplayName("should return the correct language")
    public void getLanguage_stateUnderTest_expectedBehavior() {
        assertThat(userPreferencesDto.language()).isEqualTo("en-US");
    }

    @Test
    @DisplayName("should return the correct default mode")
    public void getDefaultMode_stateUnderTest_expectedBehavior() {
        assertThat(userPreferencesDto.defaultMode()).isEqualTo("EXAM");
    }

    @Test
    @DisplayName("should return whether notifications are enabled")
    public void isNotificationsEnabled_stateUnderTest_expectedBehavior() {
        assertThat(userPreferencesDto.notificationsEnabled()).isTrue();
    }

    @Test
    @DisplayName("should return the last certification ID")
    public void getLastCertificationId_stateUnderTest_expectedBehavior() {
        assertThat(userPreferencesDto.lastCertificationId()).isEqualTo("cert123");
    }

    @Test
    @DisplayName("should return the default question count for free mode")
    public void getFreeModeQuestionCount_stateUnderTest_expectedBehavior() {
        assertThat(userPreferencesDto.freeModeQuestionCount()).isEqualTo(50);
    }

    @Test
    @DisplayName("should return the default duration in minutes for free mode")
    public void getFreeModeDurationMin_stateUnderTest_expectedBehavior() {
        assertThat(userPreferencesDto.freeModeDurationMin()).isEqualTo(60);
    }
}