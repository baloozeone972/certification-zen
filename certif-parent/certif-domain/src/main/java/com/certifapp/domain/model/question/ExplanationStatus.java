// certif-domain/src/main/java/com/certifapp/domain/model/question/ExplanationStatus.java
package com.certifapp.domain.model.question;

/**
 * Lifecycle status of a question's explanation text.
 *
 * <p>All questions imported from the JavaFX corpus start as {@code ORIGINAL}.
 * The enrichment pipeline (certif-ai module) moves them to {@code AI_DRAFT},
 * then an admin reviewer approves them to {@code HUMAN_VALIDATED}.</p>
 *
 * <p>Maps to the {@code explanation_status VARCHAR(20)} column in PostgreSQL.</p>
 *
 * <p>The API never returns {@code ORIGINAL} explanations to end-users without
 * a freemium warning; {@code AI_DRAFT} is visible to PRO users;
 * only {@code HUMAN_VALIDATED} is displayed without any badge.</p>
 */
public enum ExplanationStatus {

    /**
     * Raw explanation imported from the CertiPrep Engine JSON corpus.
     * No AI enrichment applied. May be terse or incomplete.
     */
    ORIGINAL,

    /**
     * Explanation rewritten by the AI pipeline (LangChain4j).
     * Awaiting human review before full publication.
     */
    AI_DRAFT,

    /**
     * Explanation reviewed and approved by a human admin.
     * This is the target state for all questions before public release.
     */
    HUMAN_VALIDATED;

    /**
     * Returns {@code true} if this explanation has been reviewed by a human.
     *
     * @return {@code true} only for {@code HUMAN_VALIDATED}
     */
    public boolean isValidated() {
        return this == HUMAN_VALIDATED;
    }

    /**
     * Returns {@code true} if this explanation was generated or enriched by AI.
     *
     * @return {@code true} for {@code AI_DRAFT}
     */
    public boolean isAiGenerated() {
        return this == AI_DRAFT;
    }
}
