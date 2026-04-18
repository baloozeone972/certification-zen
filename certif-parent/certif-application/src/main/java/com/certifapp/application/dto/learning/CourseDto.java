// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/learning/CourseDto.java
package com.certifapp.application.dto.learning;

import java.util.UUID;

/**
 * Full course content returned for the course detail view.
 *
 * @param id              course UUID
 * @param certificationId parent certification
 * @param themeCode       theme code
 * @param title           course title
 * @param contentMarkdown editable Markdown source
 * @param contentHtml     pre-rendered HTML
 * @param aiStatus        content lifecycle status
 */
public record CourseDto(
        UUID id,
        String certificationId,
        String themeCode,
        String title,
        String contentMarkdown,
        String contentHtml,
        String aiStatus
) {
}
