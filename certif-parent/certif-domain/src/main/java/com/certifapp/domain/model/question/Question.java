// certif-domain/src/main/java/com/certifapp/domain/model/question/Question.java
package com.certifapp.domain.model.question;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * Core domain entity representing a single certification exam question.
 *
 * <p>Migrated from the CertiPrep Engine JSON corpus. Every question has:
 * <ul>
 *   <li>A {@code legacyId} preserving the original JSON identifier for traceability
 *       (e.g. {@code "OCP21-VT-001"}, {@code "AWS-SAA-175"}).</li>
 *   <li>One or more {@link QuestionOption}s, exactly one of which has
 *       {@code isCorrect = true} for {@code SINGLE_CHOICE} questions.</li>
 *   <li>A two-tier explanation: {@code explanationOriginal} (raw import) and
 *       {@code explanationEnriched} (AI + human review).</li>
 * </ul>
 *
 * <p>Maps to the {@code questions} table in PostgreSQL.</p>
 *
 * @param id                   surrogate UUID (PostgreSQL uuid_generate_v4)
 * @param legacyId             original JSON id — unique, used for seed idempotency
 * @param certificationId      parent certification slug (e.g. {@code "ocp21"})
 * @param themeId              parent theme UUID
 * @param statement            question text (may contain Markdown code blocks)
 * @param difficulty           {@link DifficultyLevel}
 * @param type                 {@link QuestionType}
 * @param options              ordered list of answer choices (2-5 options)
 * @param explanationOriginal  raw explanation from source JSON (never modified)
 * @param explanationEnriched  AI-enriched or human-edited explanation (may be null)
 * @param explanationStatus    current lifecycle status of the explanation
 * @param officialDocUrl       optional link to vendor documentation
 * @param codeExample          optional illustrative code snippet
 * @param aiConfidenceScore    AI certainty score 0.0-1.0 (null if not processed)
 * @param isActive             whether this question is served to users
 * @param lastReviewedAt       timestamp of last human review (null if never reviewed)
 */
public record Question(
        UUID              id,
        String            legacyId,
        String            certificationId,
        UUID              themeId,
        String            statement,
        DifficultyLevel   difficulty,
        QuestionType      type,
        List<QuestionOption> options,
        String            explanationOriginal,
        String            explanationEnriched,
        ExplanationStatus explanationStatus,
        String            officialDocUrl,
        String            codeExample,
        Double            aiConfidenceScore,
        boolean           isActive,
        OffsetDateTime    lastReviewedAt
) {

    /**
     * Compact constructor — enforces domain invariants.
     */
    public Question {
        if (certificationId == null || certificationId.isBlank()) {
            throw new IllegalArgumentException("certificationId must not be blank");
        }
        if (statement == null || statement.isBlank()) {
            throw new IllegalArgumentException("statement must not be blank");
        }
        if (options == null || options.size() < 2) {
            throw new IllegalArgumentException(
                "A question must have at least 2 options, got: "
                + (options == null ? "null" : options.size()));
        }
        if (difficulty == null) {
            throw new IllegalArgumentException("difficulty must not be null");
        }
        if (type == null) {
            throw new IllegalArgumentException("type must not be null");
        }
        if (explanationStatus == null) {
            throw new IllegalArgumentException("explanationStatus must not be null");
        }
        if (aiConfidenceScore != null && (aiConfidenceScore < 0.0 || aiConfidenceScore > 1.0)) {
            throw new IllegalArgumentException(
                "aiConfidenceScore must be between 0.0 and 1.0, got: " + aiConfidenceScore);
        }
        options = List.copyOf(options);
    }

    /**
     * Returns the correct {@link QuestionOption} for a {@code SINGLE_CHOICE} question.
     *
     * @return an {@code Optional} containing the correct option,
     *         or empty if none is marked correct
     */
    public Optional<QuestionOption> correctOption() {
        return options.stream().filter(QuestionOption::isCorrect).findFirst();
    }

    /**
     * Returns all correct options (relevant for {@code MULTIPLE_CHOICE} questions).
     *
     * @return immutable list of correct options (may contain 1 or more elements)
     */
    public List<QuestionOption> correctOptions() {
        return options.stream().filter(QuestionOption::isCorrect).toList();
    }

    /**
     * Finds an option by its UUID.
     *
     * @param optionId the option UUID to search
     * @return an {@code Optional} containing the matching option, or empty
     */
    public Optional<QuestionOption> findOption(UUID optionId) {
        return options.stream().filter(o -> optionId.equals(o.id())).findFirst();
    }

    /**
     * Returns the best available explanation: enriched if present and validated,
     * otherwise the original.
     *
     * @return non-null explanation text
     */
    public String bestExplanation() {
        if (explanationEnriched != null && !explanationEnriched.isBlank()
                && explanationStatus.isValidated()) {
            return explanationEnriched;
        }
        return explanationOriginal != null ? explanationOriginal : "";
    }
}
