package com.certifapp.infrastructure.persistence.entity;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import org.mockito.MockitoAnnotations;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class UserPreferencesEntityTest {

    @InjectMocks
    private UserPreferencesEntity userPreferencesEntity;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    @DisplayName("UserPreferencesEntity_getUserId_nominalCase_expectedBehavior")
    public void testGetUserId_nominalCase_expectedBehavior() {
        UUID userId = UUID.randomUUID();
        userPreferencesEntity.setUserId(userId);
        assertThat(userPreferencesEntity.getUserId()).isEqualTo(userId);
    }

    @Test
    @DisplayName("UserPreferencesEntity_setUserId_edgeCase_nullExpectedError")
    public void testSetUserId_edgeCase_nullExpectedError() {
        userPreferencesEntity.setUserId(null);
        assertThat(userPreferencesEntity.getUserId()).isNull();
    }

    @Test
    @DisplayName("UserPreferencesEntity_getTheme_nominalCase_expectedBehavior")
    public void testGetTheme_nominalCase_expectedBehavior() {
        String theme = "dark";
        userPreferencesEntity.setTheme(theme);
        assertThat(userPreferencesEntity.getTheme()).isEqualTo(theme);
    }

    @Test
    @DisplayName("UserPreferencesEntity_setTheme_edgeCase_nullExpectedError")
    public void testSetTheme_edgeCase_nullExpectedError() {
        userPreferencesEntity.setTheme(null);
        assertThat(userPreferencesEntity.getTheme()).isNull();
    }

    @Test
    @DisplayName("UserPreferencesEntity_getLanguage_nominalCase_expectedBehavior")
    public void testGetLanguage_nominalCase_expectedBehavior() {
        String language = "en";
        userPreferencesEntity.setLanguage(language);
        assertThat(userPreferencesEntity.getLanguage()).isEqualTo(language);
    }

    @Test
    @DisplayName("UserPreferencesEntity_setLanguage_edgeCase_nullExpectedError")
    public void testSetLanguage_edgeCase_nullExpectedError() {
        userPreferencesEntity.setLanguage(null);
        assertThat(userPreferencesEntity.getLanguage()).isNull();
    }

    @Test
    @DisplayName("UserPreferencesEntity_getDefaultMode_nominalCase_expectedBehavior")
    public void testGetDefaultMode_nominalCase_expectedBehavior() {
        String defaultMode = "study";
        userPreferencesEntity.setDefaultMode(defaultMode);
        assertThat(userPreferencesEntity.getDefaultMode()).isEqualTo(defaultMode);
    }

    @Test
    @DisplayName("UserPreferencesEntity_setDefaultMode_edgeCase_nullExpectedError")
    public void testSetDefaultMode_edgeCase_nullExpectedError() {
        userPreferencesEntity.setDefaultMode(null);
        assertThat(userPreferencesEntity.getDefaultMode()).isNull();
    }

    @Test
    @DisplayName("UserPreferencesEntity_isNotificationsEnabled_nominalCase_expectedBehavior")
    public void testIsNotificationsEnabled_nominalCase_expectedBehavior() {
        boolean notificationsEnabled = false;
        userPreferencesEntity.setNotificationsEnabled(notificationsEnabled);
        assertThat(userPreferencesEntity.isNotificationsEnabled()).isEqualTo(notificationsEnabled);
    }

    @Test
    @DisplayName("UserPreferencesEntity_setNotificationsEnabled_edgeCase_nullExpectedError")
    public void testSetNotificationsEnabled_edgeCase_nullExpectedError() {
        userPreferencesEntity.setNotificationsEnabled(null);
        assertThat(userPreferencesEntity.isNotificationsEnabled()).isTrue();
    }

    @Test
    @DisplayName("UserPreferencesEntity_getLastCertificationId_nominalCase_expectedBehavior")
    public void testGetLastCertificationId_nominalCase_expectedBehavior() {
        String lastCertificationId = "cert123";
        userPreferencesEntity.setLastCertificationId(lastCertificationId);
        assertThat(userPreferencesEntity.getLastCertificationId()).isEqualTo(lastCertificationId);
    }

    @Test
    @DisplayName("UserPreferencesEntity_setLastCertificationId_edgeCase_nullExpectedError")
    public void testSetLastCertificationId_edgeCase_nullExpectedError() {
        userPreferencesEntity.setLastCertificationId(null);
        assertThat(userPreferencesEntity.getLastCertificationId()).isNull();
    }

    @Test
    @DisplayName("UserPreferencesEntity_getFreeModeQuestionCount_nominalCase_expectedBehavior")
    public void testGetFreeModeQuestionCount_nominalCase_expectedBehavior() {
        int freeModeQuestionCount = 50;
        userPreferencesEntity.setFreeModeQuestionCount(freeModeQuestionCount);
        assertThat(userPreferencesEntity.getFreeModeQuestionCount()).isEqualTo(freeModeQuestionCount);
    }

    @Test
    @DisplayName("UserPreferencesEntity_setFreeModeQuestionCount_edgeCase_negativeExpectedError")
    public void testSetFreeModeQuestionCount_edgeCase_negativeExpectedError() {
        userPreferencesEntity.setFreeModeQuestionCount(-5);
        assertThat(userPreferencesEntity.getFreeModeQuestionCount()).isEqualTo(30);
    }

    @Test
    @DisplayName("UserPreferencesEntity_getFreeModeDurationMin_nominalCase_expectedBehavior")
    public void testGetFreeModeDurationMin_nominalCase_expectedBehavior() {
        int freeModeDurationMin = 90;
        userPreferencesEntity.setFreeModeDurationMin(freeModeDurationMin);
        assertThat(userPreferencesEntity.getFreeModeDurationMin()).isEqualTo(freeModeDurationMin);
    }

    @Test
    @DisplayName("UserPreferencesEntity_setFreeModeDurationMin_edgeCase_negativeExpectedError")
    public void testSetFreeModeDurationMin_edgeCase_negativeExpectedError() {
        userPreferencesEntity.setFreeModeDurationMin(-10);
        assertThat(userPreferencesEntity.getFreeModeDurationMin()).isEqualTo(60);
    }

    @Test
    @DisplayName("UserPreferencesEntity_getUpdatedAt_nominalCase_expectedBehavior")
    public void testGetUpdatedAt_nominalCase_expectedBehavior() {
        OffsetDateTime updatedAt = OffsetDateTime.now();
        userPreferencesEntity.setUpdatedAt(updatedAt);
        assertThat(userPreferencesEntity.getUpdatedAt()).isEqualTo(updatedAt);
    }
}
