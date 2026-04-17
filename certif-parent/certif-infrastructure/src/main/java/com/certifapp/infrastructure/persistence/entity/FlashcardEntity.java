// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/entity/FlashcardEntity.java
package com.certifapp.infrastructure.persistence.entity;

import jakarta.persistence.*;

import java.time.OffsetDateTime;
import java.util.UUID;

/**
 * JPA entity mapping the {@code flashcards} table.
 */
@Entity
@Table(name = "flashcards")
public class FlashcardEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @Column(name = "question_id")
    private UUID questionId;

    @Column(name = "course_id")
    private UUID courseId;

    @Column(name = "front_text", columnDefinition = "TEXT", nullable = false)
    private String frontText;

    @Column(name = "back_text", columnDefinition = "TEXT", nullable = false)
    private String backText;

    @Column(name = "code_example", columnDefinition = "TEXT")
    private String codeExample;

    @Column(name = "ai_generated", nullable = false)
    private boolean aiGenerated;

    @Column(name = "created_at", nullable = false, updatable = false)
    private OffsetDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        if (createdAt == null) createdAt = OffsetDateTime.now();
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public UUID getQuestionId() {
        return questionId;
    }

    public void setQuestionId(UUID q) {
        this.questionId = q;
    }

    public UUID getCourseId() {
        return courseId;
    }

    public void setCourseId(UUID c) {
        this.courseId = c;
    }

    public String getFrontText() {
        return frontText;
    }

    public void setFrontText(String f) {
        this.frontText = f;
    }

    public String getBackText() {
        return backText;
    }

    public void setBackText(String b) {
        this.backText = b;
    }

    public String getCodeExample() {
        return codeExample;
    }

    public void setCodeExample(String c) {
        this.codeExample = c;
    }

    public boolean isAiGenerated() {
        return aiGenerated;
    }

    public void setAiGenerated(boolean a) {
        this.aiGenerated = a;
    }

    public OffsetDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(OffsetDateTime t) {
        this.createdAt = t;
    }
}
