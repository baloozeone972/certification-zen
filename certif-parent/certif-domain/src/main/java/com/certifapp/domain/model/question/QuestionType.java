// certif-domain/src/main/java/com/certifapp/domain/model/question/QuestionType.java
package com.certifapp.domain.model.question;

/**
 * Type of answer selection for a {@link Question}.
 *
 * <p>The current corpus only uses {@code SINGLE_CHOICE} (one correct option).
 * {@code MULTIPLE_CHOICE} is modelled for future corpus evolution — the "A et B"
 * pattern currently encoded as a single text option will eventually be replaced
 * by proper multi-select questions.</p>
 *
 * <p>Maps to the {@code question_type VARCHAR(20)} column in PostgreSQL.</p>
 */
public enum QuestionType {

    /**
     * Exactly one correct option among A/B/C/D.
     * Default type for the entire migrated corpus.
     */
    SINGLE_CHOICE,

    /**
     * One or more correct options among A/B/C/D/E.
     * Reserved for future corpus enrichment.
     */
    MULTIPLE_CHOICE,

    /**
     * True or False question with exactly two options.
     */
    TRUE_FALSE;

    /**
     * Returns {@code true} if this type allows multiple simultaneous correct answers.
     *
     * @return {@code true} only for {@code MULTIPLE_CHOICE}
     */
    public boolean allowsMultipleCorrectAnswers() {
        return this == MULTIPLE_CHOICE;
    }
}
