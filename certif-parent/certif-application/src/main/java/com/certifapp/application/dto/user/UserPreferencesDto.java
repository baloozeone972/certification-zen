// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/user/UserPreferencesDto.java
package com.certifapp.application.dto.user;

/**
 * User preferences returned by the API.
 *
 * @param theme                 light | dark | system
 * @param language              BCP-47 language tag
 * @param defaultMode           EXAM | FREE | REVISION
 * @param notificationsEnabled  whether push and email notifications are enabled
 * @param lastCertificationId   last selected certification (null if none)
 * @param freeModeQuestionCount default question count for FREE mode
 * @param freeModeDurationMin   default timer for FREE mode (0 = unlimited)
 */
public record UserPreferencesDto(
        String theme,
        String language,
        String defaultMode,
        boolean notificationsEnabled,
        String lastCertificationId,
        int freeModeQuestionCount,
        int freeModeDurationMin
) {
}
