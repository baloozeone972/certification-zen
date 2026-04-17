// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/entity/QuestionEntity.java
package com.certifapp.infrastructure.persistence.entity;

import jakarta.persistence.*;

import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * JPA entity mapping the {@code questions} table.
 */
@Entity
@Table(name = "questions", indexes = {
        @Index(name = "idx_questions_certification", columnList = "certification_id"),
        @Index(name = "idx_questions_theme", columnList = "theme_id"),
        @Index(name = "idx_questions_difficulty", columnList = "difficulty"),
        @Index(name = "idx_questions_legacy", columnList = "legacy_id")
})
public class QuestionEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @Column(name = "legacy_id", length = 50, unique = true)
    private String legacyId;

    @Column(name = "certification_id", length = 50, nullable = false)
    private String certificationId;

    @Column(name = "theme_id", nullable = false)
    private UUID themeId;

    @Column(name = "statement", columnDefinition = "TEXT", nullable = false)
    private String statement;

    @Column(name = "difficulty", length = 10, nullable = false)
    private String difficulty;

    @Column(name = "question_type", length = 20, nullable = false)
    private String questionType;

    @Column(name = "explanation_original", columnDefinition = "TEXT")
    private String explanationOriginal;

    @Column(name = "explanation_enriched", columnDefinition = "TEXT")
    private String explanationEnriched;

    @Column(name = "explanation_status", length = 20, nullable = false)
    private String explanationStatus;

    @Column(name = "explanation_version", nullable = false)
    private int explanationVersion = 1;

    @Column(name = "official_doc_url", length = 500)
    private String officialDocUrl;

    @Column(name = "code_example", columnDefinition = "TEXT")
    private String codeExample;

    @Column(name = "ai_confidence_score", precision = 3, scale = 2)
    private Double aiConfidenceScore;

    @Column(name = "last_reviewed_by")
    private UUID lastReviewedBy;

    @Column(name = "last_reviewed_at")
    private OffsetDateTime lastReviewedAt;

    @Column(name = "is_active", nullable = false)
    private boolean isActive = true;

    @Column(name = "created_at", nullable = false, updatable = false)
    private OffsetDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    private OffsetDateTime updatedAt;

    @OneToMany(mappedBy = "question", cascade = CascadeType.ALL,
            fetch = FetchType.EAGER, orphanRemoval = true)
    @OrderBy("displayOrder ASC")
    private List<QuestionOptionEntity> options = new ArrayList<>();

    @PrePersist
    protected void onCreate() {
        OffsetDateTime now = OffsetDateTime.now();
        if (createdAt == null) createdAt = now;
        updatedAt = now;
        if (explanationStatus == null) explanationStatus = "ORIGINAL";
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = OffsetDateTime.now();
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getLegacyId() {
        return legacyId;
    }

    public void setLegacyId(String l) {
        this.legacyId = l;
    }

    public String getCertificationId() {
        return certificationId;
    }

    public void setCertificationId(String c) {
        this.certificationId = c;
    }

    public UUID getThemeId() {
        return themeId;
    }

    public void setThemeId(UUID t) {
        this.themeId = t;
    }

    public String getStatement() {
        return statement;
    }

    public void setStatement(String s) {
        this.statement = s;
    }

    public String getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(String d) {
        this.difficulty = d;
    }

    public String getQuestionType() {
        return questionType;
    }

    public void setQuestionType(String t) {
        this.questionType = t;
    }

    public String getExplanationOriginal() {
        return explanationOriginal;
    }

    public void setExplanationOriginal(String e) {
        this.explanationOriginal = e;
    }

    public String getExplanationEnriched() {
        return explanationEnriched;
    }

    public void setExplanationEnriched(String e) {
        this.explanationEnriched = e;
    }

    public String getExplanationStatus() {
        return explanationStatus;
    }

    public void setExplanationStatus(String s) {
        this.explanationStatus = s;
    }

    public int getExplanationVersion() {
        return explanationVersion;
    }

    public void setExplanationVersion(int v) {
        this.explanationVersion = v;
    }

    public String getOfficialDocUrl() {
        return officialDocUrl;
    }

    public void setOfficialDocUrl(String u) {
        this.officialDocUrl = u;
    }

    public String getCodeExample() {
        return codeExample;
    }

    public void setCodeExample(String c) {
        this.codeExample = c;
    }

    public Double getAiConfidenceScore() {
        return aiConfidenceScore;
    }

    public void setAiConfidenceScore(Double s) {
        this.aiConfidenceScore = s;
    }

    public UUID getLastReviewedBy() {
        return lastReviewedBy;
    }

    public void setLastReviewedBy(UUID u) {
        this.lastReviewedBy = u;
    }

    public OffsetDateTime getLastReviewedAt() {
        return lastReviewedAt;
    }

    public void setLastReviewedAt(OffsetDateTime t) {
        this.lastReviewedAt = t;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean a) {
        this.isActive = a;
    }

    public OffsetDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(OffsetDateTime t) {
        this.createdAt = t;
    }

    public OffsetDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(OffsetDateTime t) {
        this.updatedAt = t;
    }

    public List<QuestionOptionEntity> getOptions() {
        return options;
    }

    public void setOptions(List<QuestionOptionEntity> o) {
        this.options = o;
    }
}
