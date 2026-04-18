// certif-domain/src/main/java/com/certifapp/domain/model/certification/Certification.java
package com.certifapp.domain.model.certification;

import java.util.List;

/**
 * Aggregate root representing a professional certification (e.g. OCP Java 21, AWS SAA-C03).
 *
 * <p>Imported from the source {@code config.json} files and seeded via Flyway V2.
 * This record is the canonical reference for all exam rules: question count,
 * duration and passing threshold.</p>
 *
 * <p><strong>Scoring rule</strong> (canonical — never change without an architectural ticket):
 * {@code passed = (correctCount * 100.0 / totalQuestions) >= passingScore}</p>
 *
 * @param id                internal slug used in URLs and JSON files (e.g. {@code "ocp21"})
 * @param code              official vendor exam code (e.g. {@code "1Z0-830"})
 * @param name              full display name (e.g. {@code "Oracle Certified Professional Java SE 21"})
 * @param description       long description shown on the catalogue page
 * @param totalQuestions    total questions available in the corpus for this certification
 * @param examQuestionCount number of questions drawn for a single EXAM session
 * @param examDurationMin   official exam duration in minutes
 * @param passingScore      minimum percentage required to pass (e.g. {@code 68})
 * @param examType          {@code MCQ}, {@code PRACTICAL} or {@code MIXED}
 * @param themes            ordered list of thematic categories
 * @param isActive          whether this certification is visible in the catalogue
 */
public record Certification(
        String id,
        String code,
        String name,
        String description,
        int totalQuestions,
        int examQuestionCount,
        int examDurationMin,
        int passingScore,
        String examType,
        List<CertificationTheme> themes,
        boolean isActive
) {

    /**
     * Maximum number of FREE-tier exams allowed per day per certification.
     */
    public static final int FREE_DAILY_EXAM_LIMIT = 2;

    /**
     * Maximum number of questions per FREE-tier session.
     */
    public static final int FREE_QUESTION_LIMIT = 20;

    /**
     * Compact constructor — validates business invariants.
     */
    public Certification {
        if (id == null || id.isBlank()) {
            throw new IllegalArgumentException("id must not be blank");
        }
        if (code == null || code.isBlank()) {
            throw new IllegalArgumentException("code must not be blank");
        }
        if (examQuestionCount <= 0) {
            throw new IllegalArgumentException(
                    "examQuestionCount must be > 0, got: " + examQuestionCount);
        }
        if (examDurationMin <= 0) {
            throw new IllegalArgumentException(
                    "examDurationMin must be > 0, got: " + examDurationMin);
        }
        if (passingScore < 1 || passingScore > 100) {
            throw new IllegalArgumentException(
                    "passingScore must be between 1 and 100, got: " + passingScore);
        }
        themes = themes == null ? List.of() : List.copyOf(themes);
    }

    /**
     * Calculates the minimum number of correct answers needed to pass.
     *
     * <p>Uses {@code Math.ceil} to ensure the threshold is never rounded down.
     * Example: OCP21 — 80 questions × 68% = 54.4 → ceil = 55 correct answers required.</p>
     *
     * @return minimum correct answers to pass this certification
     */
    public int passingQuestionsCount() {
        return (int) Math.ceil(examQuestionCount * passingScore / 100.0);
    }

    /**
     * Calculates the exam duration in seconds (used for server-side timer validation).
     *
     * @return exam duration in seconds
     */
    public int examDurationSeconds() {
        return examDurationMin * 60;
    }

    /**
     * Returns the theme matching the given code, or {@code null} if not found.
     *
     * @param themeCode URL-safe theme code (e.g. {@code "virtual_threads"})
     * @return matching theme or {@code null}
     */
    public CertificationTheme findTheme(String themeCode) {
        return themes.stream()
                .filter(t -> t.code().equals(themeCode))
                .findFirst()
                .orElse(null);
    }
}
