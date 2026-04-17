// certif-domain/src/main/java/com/certifapp/domain/model/question/QuestionFilter.java
package com.certifapp.domain.model.question;

import java.util.List;
import java.util.Set;
import java.util.UUID;

/**
 * Value object encapsulating question selection criteria.
 *
 * <p>Used by {@code QuestionSelectionService} and {@code QuestionRepository}
 * to build filtered, randomised question sets for exam sessions.</p>
 *
 * @param certificationId mandatory — certification to draw questions from
 * @param themeCodes      optional — restrict to specific theme codes;
 *                        empty list means all themes
 * @param difficulties    optional — restrict to specific difficulty levels;
 *                        empty list means all difficulties
 * @param excludeIds      UUIDs of questions to exclude (already seen in this session)
 * @param activeOnly      if {@code true}, only return questions with {@code is_active = true}
 * @param limit           maximum number of questions to return (0 = no limit)
 */
public record QuestionFilter(
        String certificationId,
        List<String> themeCodes,
        List<DifficultyLevel> difficulties,
        Set<UUID> excludeIds,
        boolean activeOnly,
        int limit
) {

    /**
     * Compact constructor — copies mutable collections.
     */
    public QuestionFilter {
        if (certificationId == null || certificationId.isBlank()) {
            throw new IllegalArgumentException("certificationId must not be blank");
        }
        themeCodes = themeCodes == null ? List.of() : List.copyOf(themeCodes);
        difficulties = difficulties == null ? List.of() : List.copyOf(difficulties);
        excludeIds = excludeIds == null ? Set.of() : Set.copyOf(excludeIds);
    }

    /**
     * Creates a filter for a standard EXAM session — all active questions, no theme restriction.
     *
     * @param certificationId target certification
     * @param limit           number of questions to draw
     * @return exam filter
     */
    public static QuestionFilter forExam(String certificationId, int limit) {
        return new QuestionFilter(certificationId, List.of(), List.of(), Set.of(), true, limit);
    }

    /**
     * Creates a filter for a FREE session — specific themes, proportional selection.
     *
     * @param certificationId target certification
     * @param themeCodes      selected theme codes
     * @param limit           number of questions to draw
     * @return free mode filter
     */
    public static QuestionFilter forFreeMode(
            String certificationId, List<String> themeCodes, int limit) {
        return new QuestionFilter(certificationId, themeCodes, List.of(), Set.of(), true, limit);
    }
}
