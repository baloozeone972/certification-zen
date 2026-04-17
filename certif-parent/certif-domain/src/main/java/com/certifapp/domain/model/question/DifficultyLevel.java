// certif-domain/src/main/java/com/certifapp/domain/model/question/DifficultyLevel.java
package com.certifapp.domain.model.question;

/**
 * Difficulty level of a certification question.
 *
 * <p>Maps directly to the {@code difficulty} field in the JSON corpus
 * (values: {@code "easy"}, {@code "medium"}, {@code "hard"})
 * and to the {@code difficulty VARCHAR(10)} column in PostgreSQL.</p>
 *
 * <p>Used by {@code QuestionSelectionService} to build difficulty-aware
 * statistics and by the SM-2 adaptive algorithm to weight review intervals.</p>
 */
public enum DifficultyLevel {

    /**
     * Introductory question — fundamental concepts, definitions.
     */
    EASY,

    /**
     * Standard exam-level question — applied knowledge.
     */
    MEDIUM,

    /**
     * Advanced question — edge cases, architecture, deep internals.
     */
    HARD;

    /**
     * Parses a lowercase JSON string value into a {@code DifficultyLevel}.
     *
     * @param value the raw JSON string ({@code "easy"}, {@code "medium"}, {@code "hard"})
     * @return the matching {@code DifficultyLevel}
     * @throws IllegalArgumentException if {@code value} does not match any level
     */
    public static DifficultyLevel fromJson(String value) {
        return switch (value.toLowerCase().trim()) {
            case "easy" -> EASY;
            case "medium" -> MEDIUM;
            case "hard" -> HARD;
            default -> throw new IllegalArgumentException(
                    "Unknown difficulty level: '%s'. Expected easy | medium | hard".formatted(value));
        };
    }

    /**
     * Returns the lowercase string representation used in JSON files and API responses.
     *
     * @return {@code "easy"}, {@code "medium"}, or {@code "hard"}
     */
    public String toJson() {
        return name().toLowerCase();
    }
}
