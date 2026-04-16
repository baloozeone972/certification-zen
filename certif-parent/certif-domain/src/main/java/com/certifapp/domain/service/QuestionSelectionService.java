// certif-parent/certif-domain/src/main/java/com/certifapp/domain/service/QuestionSelectionService.java
package com.certifapp.domain.service;

import com.certifapp.domain.model.question.Question;

import java.util.*;

/**
 * Pure domain service implementing question selection strategies.
 *
 * <p>Migrated from {@code QuestionLoader} in the JavaFX source, cleaned up
 * and made stateless. All randomisation uses {@link Collections#shuffle} with
 * a system-seeded {@link Random} — no reproducible seed (intentional for exam fairness).</p>
 */
public class QuestionSelectionService {

    /**
     * Selects {@code count} questions randomly from the full pool.
     * Used for EXAM mode.
     *
     * @param allQuestions full question pool for the certification
     * @param count        number of questions to draw
     * @return shuffled sublist of {@code count} questions
     */
    public List<Question> selectRandom(List<Question> allQuestions, int count) {
        if (allQuestions == null || allQuestions.isEmpty()) return List.of();
        int effective = Math.min(count, allQuestions.size());
        List<Question> shuffled = new ArrayList<>(allQuestions);
        Collections.shuffle(shuffled);
        return Collections.unmodifiableList(shuffled.subList(0, effective));
    }

    /**
     * Selects questions proportionally distributed across themes.
     * Used for FREE mode.
     *
     * <p>Each theme receives {@code round(available_theme / total_available * requested)} questions.
     * Rounding remainder is distributed to themes in iteration order.</p>
     *
     * @param questionsByTheme map of theme code to available questions for that theme
     * @param totalRequested   total number of questions requested
     * @return shuffled combined list with proportional theme representation
     */
    public List<Question> selectProportional(
            Map<String, List<Question>> questionsByTheme,
            int totalRequested) {

        if (questionsByTheme == null || questionsByTheme.isEmpty()) return List.of();

        int totalAvailable = questionsByTheme.values().stream()
                .mapToInt(List::size).sum();

        if (totalAvailable == 0) return List.of();

        int effective = Math.min(totalRequested, totalAvailable);
        List<Question> selected = new ArrayList<>();

        // First pass: proportional allocation
        Map<String, Integer> allocations = new LinkedHashMap<>();
        int allocated = 0;
        for (Map.Entry<String, List<Question>> entry : questionsByTheme.entrySet()) {
            int available = entry.getValue().size();
            int alloc = (int) Math.round((double) available / totalAvailable * effective);
            alloc = Math.min(alloc, available);
            allocations.put(entry.getKey(), alloc);
            allocated += alloc;
        }

        // Second pass: distribute remainder
        int remainder = effective - allocated;
        for (Map.Entry<String, List<Question>> entry : questionsByTheme.entrySet()) {
            if (remainder <= 0) break;
            String theme = entry.getKey();
            int current = allocations.get(theme);
            int max     = entry.getValue().size();
            if (current < max) {
                allocations.put(theme, current + 1);
                remainder--;
            }
        }

        // Draw questions per theme
        for (Map.Entry<String, List<Question>> entry : questionsByTheme.entrySet()) {
            int count = allocations.getOrDefault(entry.getKey(), 0);
            if (count <= 0) continue;
            List<Question> shuffled = new ArrayList<>(entry.getValue());
            Collections.shuffle(shuffled);
            selected.addAll(shuffled.subList(0, Math.min(count, shuffled.size())));
        }

        // Final shuffle of the combined list
        Collections.shuffle(selected);
        return Collections.unmodifiableList(selected);
    }
}
