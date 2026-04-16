// certif-domain/src/main/java/com/certifapp/domain/model/session/ExamMode.java
package com.certifapp.domain.model.session;

/**
 * Operational mode of an {@link ExamSession}.
 *
 * <p>Each mode differs in question selection, correction display,
 * timer behaviour and persistence rules — see the mapping table below.</p>
 *
 * <table border="1">
 *   <caption>Mode comparison</caption>
 *   <tr><th>Criterion</th><th>EXAM</th><th>FREE</th><th>REVISION</th></tr>
 *   <tr><td>Question count</td><td>Fixed (examQuestionCount)</td>
 *       <td>User-defined slider</td><td>User-defined slider</td></tr>
 *   <tr><td>Theme selection</td><td>All themes (random)</td>
 *       <td>User-selected checkboxes</td><td>Single theme or all</td></tr>
 *   <tr><td>Timer</td><td>Mandatory (examDurationMin)</td>
 *       <td>Optional (0 = unlimited)</td><td>None</td></tr>
 *   <tr><td>Immediate correction</td><td>No — after submit</td>
 *       <td>No — after submit</td><td>Yes — per question</td></tr>
 *   <tr><td>Session persisted</td><td>Yes</td><td>Yes</td><td>Yes</td></tr>
 * </table>
 *
 * <p>Maps to the {@code mode VARCHAR(20)} column in PostgreSQL.</p>
 */
public enum ExamMode {

    /**
     * Official exam simulation.
     * Uses the certification's official question count and duration.
     * Timer auto-submits when it reaches zero.
     * Pause is disabled in production.
     */
    EXAM,

    /**
     * Custom practice session.
     * User selects themes, question count and optional timer.
     * Proportional distribution across selected themes.
     */
    FREE,

    /**
     * Flashcard-style revision.
     * Immediate answer display after each question.
     * No timer. Navigation includes a random-jump button.
     */
    REVISION;

    /**
     * Returns {@code true} if this mode enforces a countdown timer.
     * Used by {@code FreemiumGuardService} and the exam engine.
     *
     * @return {@code true} for {@code EXAM} (always) and {@code FREE} (when duration &gt; 0)
     */
    public boolean supportsTimer() {
        return this == EXAM || this == FREE;
    }

    /**
     * Returns {@code true} if correct answers are shown immediately after each question.
     *
     * @return {@code true} only for {@code REVISION}
     */
    public boolean showsImmediateCorrection() {
        return this == REVISION;
    }
}
