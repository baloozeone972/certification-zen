package com.certifapp.infrastructure.persistence.entity;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;

import java.time.OffsetDateTime;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;

@DataJpaTest
@ContextConfiguration(initializers = SpringJUnitConfig.Initializer.class)
@SpringBootTestContextInitializer
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)
public class UserPreferencesEntityTest {

    @Autowired
    private UserRepository userRepository;

    @BeforeEach
    public void setUp() {
        // Nettoyage BDD entre tests
        userRepository.deleteAll();
    }

    @Test
    @DisplayName("UserPreferencesEntity_getUserId_nominalCase_expectedBehavior")
    public void testGetUserId_nominalCase_expectedBehavior() {
        UUID userId = UUID.randomUUID();
        UserPreferencesEntity userPreferencesEntity = new UserPreferencesEntity(userId);
        userRepository.save(userPreferencesEntity);

        var savedUserPreferencesEntity = userRepository.findById(userId).orElse(null);
        assertThat(savedUserPreferencesEntity.getUserId()).isEqualTo(userId);
    }

    @Test
    @DisplayName("UserPreferencesEntity_setUserId_edgeCase_nullExpectedError")
    public void testSetUserId_edgeCase_nullExpectedError() {
        UUID userId = UUID.randomUUID();
        UserPreferencesEntity userPreferencesEntity = new UserPreferencesEntity(userId);
        userRepository.save(userPreferencesEntity);

        var savedUserPreferencesEntity = userRepository.findById(userId).orElse(null);
        userPreferencesEntity.setUserId(null);
        userRepository.save(userPreferencesEntity);

        var updatedUserPreferencesEntity = userRepository.findById(userId).orElse(null);
        assertThat(updatedUserPreferencesEntity.getUserId()).isNull();
    }

    @Test
    @DisplayName("UserPreferencesEntity_getTheme_nominalCase_expectedBehavior")
    public void testGetTheme_nominalCase_expectedBehavior() {
        String theme = "dark";
        UserPreferencesEntity userPreferencesEntity = new UserPreferencesEntity(null, theme);
        userRepository.save(userPreferencesEntity);

        var savedUserPreferencesEntity = userRepository.findById(userPreferencesEntity.getUserId()).orElse(null);
        assertThat(savedUserPreferencesEntity.getTheme()).isEqualTo(theme);
    }

    @Test
    @DisplayName("UserPreferencesEntity_setTheme_edgeCase_nullExpectedError")
    public void testSetTheme_edgeCase_nullExpectedError() {
        String theme = "dark";
        UserPreferencesEntity userPreferencesEntity = new UserPreferencesEntity(null, theme);
        userRepository.save(userPreferencesEntity);

        var savedUserPreferencesEntity = userRepository.findById(userPreferencesEntity.getUserId()).orElse(null);
        userPreferencesEntity.setTheme(null);
        userRepository.save(userPreferencesEntity);

        var updatedUserPreferencesEntity = userRepository.findById(userPreferencesEntity.getUserId()).orElse(null);
        assertThat(updatedUserPreferencesEntity.getTheme()).isNull();
    }

    @Test
    @DisplayName("UserPreferencesEntity_getLanguage_nominalCase_expectedBehavior")
    public void testGetLanguage_nominalCase_expectedBehavior() {
        String language = "en";
        UserPreferencesEntity userPreferencesEntity = new UserPreferencesEntity(null, null, language);
        userRepository.save(userPreferencesEntity);

        var savedUserPreferencesEntity = userRepository.findById(userPreferencesEntity.getUserId()).orElse(null);
        assertThat(savedUserPreferencesEntity.getLanguage()).isEqualTo(language);
    }

    @Test
    @DisplayName("UserPreferencesEntity_setLanguage_edgeCase_nullExpectedError")
    public void testSetLanguage_edgeCase_nullExpectedError() {
        String language = "en";
        UserPreferencesEntity userPreferencesEntity = new UserPreferencesEntity(null, null, language);
        userRepository.save(userPreferencesEntity);

        var savedUserPreferencesEntity = userRepository.findById(userPreferencesEntity.getUserId()).orElse(null);
        userPreferencesEntity.setLanguage(null);
        userRepository.save(userPreferencesEntity);

        var updatedUserPreferencesEntity = userRepository.findById(userPreferencesEntity.getUserId()).orElse(null);
        assertThat(updatedUserPreferencesEntity.getLanguage()).isNull();
    }

    @Test
    @DisplayName("UserPreferencesEntity_getDefaultMode_nominalCase_expectedBehavior")
    public void testGetDefaultMode_nominalCase_expectedBehavior() {
        String defaultMode = "study";
        UserPreferencesEntity userPreferencesEntity = new UserPreferencesEntity(null, null, null, defaultMode);
        userRepository.save(userPreferencesEntity);

        var savedUserPreferencesEntity = userRepository.findById(userPreferencesEntity.getUserId()).orElse(null);
        assertThat(savedUserPreferencesEntity.getDefaultMode()).isEqualTo(defaultMode);
    }

    @Test
    @DisplayName("UserPreferencesEntity_setDefaultMode_edgeCase_nullExpectedError")
    public void testSetDefaultMode_edgeCase_nullExpectedError() {
        String defaultMode = "study";
        UserPreferencesEntity userPreferencesEntity = new UserPreferencesEntity(null, null, null, defaultMode);
        userRepository.save(userPreferencesEntity);

        var savedUserPreferencesEntity = userRepository.findById(userPreferencesEntity.getUserId()).orElse(null);
        userPreferencesEntity.setDefaultMode(null);
        userRepository.save(userPreferencesEntity);

        var updatedUserPreferencesEntity = userRepository.findById(userPreferencesEntity.getUserId()).orElse(null);
        assertThat(updatedUserPreferencesEntity.getDefaultMode()).isNull();
    }

    @Test
    @DisplayName("UserPreferencesEntity_isNotificationsEnabled_nominalCase_expectedBehavior")
    public void testIsNotificationsEnabled_nominalCase_expectedBehavior() {
        boolean notificationsEnabled = false;
        UserPreferencesEntity userPreferencesEntity = new UserPreferencesEntity(null, null, null, null, notificationsEnabled);
        userRepository.save(userPreferencesEntity);

        var savedUserPreferencesEntity = userRepository.findById(userPreferencesEntity.getUserId()).orElse(null);
        assertThat(savedUserPreferencesEntity.isNotificationsEnabled()).isEqualTo(notificationsEnabled);
    }

    @Test
    @DisplayName("UserPreferencesEntity_setNotificationsEnabled_edgeCase_nullExpectedError")
    public void testSetNotificationsEnabled_edgeCase_nullExpectedError() {
        boolean notificationsEnabled = false;
        UserPreferencesEntity userPreferencesEntity = new UserPreferencesEntity(null, null, null, null, notificationsEnabled);
        userRepository.save(userPreferencesEntity);

        var savedUserPreferencesEntity = userRepository.findById(userPreferencesEntity.getUserId()).orElse(null);
        userPreferencesEntity.setNotificationsEnabled(null);
        userRepository.save(userPreferencesEntity);

        var updatedUserPreferencesEntity = userRepository.findById(userPreferencesEntity.getUserId()).orElse(null);
        assertThat(updatedUserPreferencesEntity.isNotificationsEnabled()).isTrue();
    }

    @Test
    @DisplayName("UserPreferencesEntity_getLastCertificationId_nominalCase_expectedBehavior")
    public void testGetLastCertificationId_nominalCase_expectedBehavior() {
        String lastCertificationId = "cert123";
        UserPreferencesEntity userPreferencesEntity = new UserPreferencesEntity(null, null, null, null, false, lastCertificationId);
        userRepository.save(userPreferencesEntity);

        var savedUserPreferencesEntity = userRepository.findById(userPreferencesEntity.getUserId()).orElse(null);
        assertThat(savedUserPreferencesEntity.getLastCertificationId()).isEqualTo(lastCertificationId);
    }

    @Test
    @DisplayName("UserPreferencesEntity_setLastCertificationId_edgeCase_nullExpectedError")
    public void testSetLastCertificationId_edgeCase_nullExpectedError() {
        String lastCertificationId = "cert123";
        UserPreferencesEntity userPreferencesEntity = new UserPreferencesEntity(null, null, null, null, false, lastCertificationId);
        userRepository.save(userPreferencesEntity);

        var savedUserPreferencesEntity = userRepository.findById(userPreferencesEntity.getUserId()).orElse(null);
        userPreferencesEntity.setLastCertificationId(null);
        userRepository.save(userPreferencesEntity);

        var updatedUserPreferencesEntity = userRepository.findById(userPreferencesEntity.getUserId()).orElse(null);
        assertThat(updatedUserPreferencesEntity.getLastCertificationId()).isNull();
    }

    @Test
    @DisplayName("UserPreferencesEntity_getFreeModeQuestionCount_nominalCase_expectedBehavior")
    public void testGetFreeModeQuestionCount_nominalCase_expectedBehavior() {
        int freeModeQuestionCount = 50;
        UserPreferencesEntity userPreferencesEntity = new UserPreferencesEntity(null, null, null, null, false, null, freeModeQuestionCount);
        userRepository.save(userPreferencesEntity);

        var savedUserPreferencesEntity = userRepository.findById(userPreferencesEntity.getUserId()).orElse(null);
        assertThat(savedUserPreferencesEntity.getFreeModeQuestionCount()).isEqualTo(freeModeQuestionCount);
    }

    @Test
    @DisplayName("UserPreferencesEntity_setFreeModeQuestionCount_edgeCase_negativeExpectedError")
    public void testSetFreeModeQuestionCount_edgeCase_negativeExpectedError() {
        int freeModeQuestionCount = 50;
        UserPreferencesEntity userPreferencesEntity = new UserPreferencesEntity(null, null, null, null, false, null, freeModeQuestionCount);
        userRepository.save(userPreferencesEntity);

        var savedUserPreferencesEntity = userRepository.findById(userPreferencesEntity.getUserId()).orElse(null);
        userPreferencesEntity.setFreeModeQuestionCount(-5);
        userRepository.save(userPreferencesEntity);

        var updatedUserPreferencesEntity = userRepository.findById(userPreferencesEntity.getUserId()).orElse(null);
        assertThat(updatedUserPreferencesEntity.getFreeModeQuestionCount()).isEqualTo(30);
    }

    @Test
    @DisplayName("UserPreferencesEntity_getFreeModeDurationMin_nominalCase_expectedBehavior")
    public void testGetFreeModeDurationMin_nominalCase_expectedBehavior() {
        int freeModeDurationMin = 90;
        UserPreferencesEntity userPreferencesEntity = new UserPreferencesEntity(null, null, null, null, false, null, 50, freeModeDurationMin);
        userRepository.save(userPreferencesEntity);

        var savedUserPreferencesEntity = userRepository.findById(userPreferencesEntity.getUserId()).orElse(null);
        assertThat(savedUserPreferencesEntity.getFreeModeDurationMin()).isEqualTo(freeModeDurationMin);
    }

    @Test
    @DisplayName("UserPreferencesEntity_setFreeModeDurationMin_edgeCase_negativeExpectedError")
    public void testSetFreeModeDurationMin_edgeCase_negativeExpectedError() {
        int freeModeDurationMin = 90;
        UserPreferencesEntity userPreferencesEntity = new UserPreferencesEntity(null, null, null, null, false, null, 50, freeModeDurationMin);
        userRepository.save(userPreferencesEntity);

        var savedUserPreferencesEntity = userRepository.findById(userPreferencesEntity.getUserId()).orElse(null);
        userPreferencesEntity.setFreeModeDurationMin(-10);
        userRepository.save(userPreferencesEntity);

        var updatedUserPreferencesEntity = userRepository.findById(userPreferencesEntity.getUserId()).orElse(null);
        assertThat(updatedUserPreferencesEntity.getFreeModeDurationMin()).isEqualTo(60);
    }

    @Test
    @DisplayName("UserPreferencesEntity_getUpdatedAt_nominalCase_expectedBehavior")
    public void testGetUpdatedAt_nominalCase_expectedBehavior() {
        OffsetDateTime updatedAt = OffsetDateTime.now();
        UserPreferencesEntity userPreferencesEntity = new UserPreferencesEntity(null, null, null, null, false, null, 50, 90, updatedAt);
        userRepository.save(userPreferencesEntity);

        var savedUserPreferencesEntity = userRepository.findById(userPreferencesEntity.getUserId()).orElse(null);
        assertThat(savedUserPreferencesEntity.getUpdatedAt()).isEqualTo(updatedAt);
    }
}