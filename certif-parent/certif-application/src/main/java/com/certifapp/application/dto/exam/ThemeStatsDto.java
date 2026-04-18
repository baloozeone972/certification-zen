// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/exam/ThemeStatsDto.java
package com.certifapp.application.dto.exam;

/**
 * Per-theme score breakdown in exam results.
 *
 * @param themeCode  URL-safe theme code
 * @param themeLabel display name
 * @param correct    correctly answered count
 * @param wrong      incorrectly answered count
 * @param skipped    skipped count
 * @param total      total questions in this theme
 * @param percentage percentage of correct answers
 */
public record ThemeStatsDto(
        String themeCode,
        String themeLabel,
        int correct,
        int wrong,
        int skipped,
        int total,
        double percentage
) {
}
