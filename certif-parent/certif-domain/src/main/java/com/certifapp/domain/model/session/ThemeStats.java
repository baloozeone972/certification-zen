// certif-domain/src/main/java/com/certifapp/domain/model/session/ThemeStats.java
package com.certifapp.domain.model.session;

/**
 * Immutable statistics for one theme within a completed {@link ExamSession}.
 *
 * <p>Produced by {@code ScoringService#calculateThemeStats} after session submission.
 * Used to populate the results breakdown table in the UI and the PDF export.</p>
 *
 * @param themeCode  URL-safe theme code (e.g. {@code "virtual_threads"})
 * @param themeLabel display name (e.g. {@code "Virtual Threads"})
 * @param correct    number of correctly answered questions in this theme
 * @param wrong      number of incorrectly answered questions (selected but wrong)
 * @param skipped    number of unanswered (skipped) questions in this theme
 */
public record ThemeStats(
        String themeCode,
        String themeLabel,
        int    correct,
        int    wrong,
        int    skipped
) {

    /**
     * Compact constructor — validates non-negative counts.
     */
    public ThemeStats {
        if (correct < 0) throw new IllegalArgumentException("correct must be >= 0");
        if (wrong   < 0) throw new IllegalArgumentException("wrong must be >= 0");
        if (skipped < 0) throw new IllegalArgumentException("skipped must be >= 0");
    }

    /**
     * Total number of questions in this theme for the session.
     *
     * @return {@code correct + wrong + skipped}
     */
    public int total() {
        return correct + wrong + skipped;
    }

    /**
     * Percentage of correctly answered questions in this theme.
     *
     * @return value between 0.0 and 100.0, or 0.0 if total is zero
     */
    public double percentage() {
        return total() == 0 ? 0.0 : (correct * 100.0) / total();
    }
}
