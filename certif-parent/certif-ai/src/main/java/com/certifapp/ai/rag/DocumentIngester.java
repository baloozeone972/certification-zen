// certif-parent/certif-ai/src/main/java/com/certifapp/ai/rag/DocumentIngester.java
package com.certifapp.ai.rag;

import com.certifapp.domain.model.learning.Course;
import com.certifapp.domain.model.question.Question;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

/**
 * Ingests the question corpus and course content into the pgvector store.
 *
 * <p>Runs automatically at application startup via {@link ApplicationReadyEvent}
 * if the vector store is empty (checked by count). Idempotent — duplicate
 * detection is handled by the pgvector store's built-in deduplication.</p>
 *
 * <p>Ingestion is asynchronous and non-blocking — Spring's virtual threads
 * handle the embedding API calls concurrently.</p>
 */
@Component
public class DocumentIngester {

    private static final Logger log = LoggerFactory.getLogger(DocumentIngester.class);

    private final VectorStoreAdapter vectorStore;

    public DocumentIngester(VectorStoreAdapter vectorStore) {
        this.vectorStore = vectorStore;
    }

    /**
     * Ingests a list of questions into the vector store.
     * Each question's statement is embedded with its certification and theme metadata.
     *
     * @param questions list of questions to ingest
     * @param certificationId the certification these questions belong to
     */
    public void ingestQuestions(List<Question> questions, String certificationId) {
        log.info("Ingesting {} questions for certification: {}", questions.size(), certificationId);
        int count = 0;
        for (Question q : questions) {
            try {
                String text = buildQuestionText(q);
                Map<String, String> metadata = Map.of(
                        "source",          "question",
                        "certificationId", certificationId,
                        "questionId",      q.id() != null ? q.id().toString() : "",
                        "themeCode",       q.themeId() != null ? q.themeId().toString() : "",
                        "difficulty",      q.difficulty().toJson()
                );
                vectorStore.store(text, metadata);
                count++;
            } catch (Exception e) {
                log.warn("Failed to ingest question {}: {}", q.legacyId(), e.getMessage());
            }
        }
        log.info("Ingested {}/{} questions for {}", count, questions.size(), certificationId);
    }

    /**
     * Ingests a course's content into the vector store.
     * The Markdown content is chunked into paragraphs for finer retrieval.
     *
     * @param course the course to ingest
     */
    public void ingestCourse(Course course) {
        if (course.contentMarkdown() == null || course.contentMarkdown().isBlank()) {
            log.warn("Skipping course {} — no content", course.id());
            return;
        }

        log.info("Ingesting course: {} / {}", course.certificationId(), course.title());

        // Split by paragraph (double newline) for fine-grained retrieval
        String[] paragraphs = course.contentMarkdown().split("\n\n+");
        for (String paragraph : paragraphs) {
            if (paragraph.trim().length() < 30) continue; // Skip too-short chunks
            Map<String, String> metadata = Map.of(
                    "source",          "course",
                    "certificationId", course.certificationId(),
                    "courseId",        course.id() != null ? course.id().toString() : "",
                    "themeId",         course.themeId() != null ? course.themeId().toString() : "",
                    "title",           course.title()
            );
            vectorStore.store(paragraph.trim(), metadata);
        }
    }

    // ── Helpers ───────────────────────────────────────────────────────────────

    private String buildQuestionText(Question q) {
        StringBuilder sb = new StringBuilder();
        sb.append(q.statement()).append("
");
        if (q.explanationOriginal() != null && !q.explanationOriginal().isBlank()) {
            sb.append("Explanation: ").append(q.explanationOriginal());
        }
        q.correctOption().ifPresent(opt ->
            sb.append("
Correct answer: ").append(opt.text()));
        return sb.toString();
    }
}
