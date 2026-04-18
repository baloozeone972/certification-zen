// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/learning/CourseSummaryDto.java
package com.certifapp.application.dto.learning;

import java.util.UUID;

/**
 * Course summary for the course list view.
 *
 * @param id        course UUID
 * @param themeCode theme code
 * @param title     course title
 * @param aiStatus  DRAFT | AI_GENERATED | HUMAN_REVIEWED | PUBLISHED
 */
public record CourseSummaryDto(UUID id, String themeCode, String title, String aiStatus) {
}
