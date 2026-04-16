// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/entity/CertificationEntity.java
package com.certifapp.infrastructure.persistence.entity;

import jakarta.persistence.*;
import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * JPA entity mapping the {@code certifications} table.
 */
@Entity
@Table(name = "certifications")
public class CertificationEntity {

    @Id
    @Column(name = "id", length = 50, nullable = false)
    private String id;

    @Column(name = "code", length = 30, nullable = false, unique = true)
    private String code;

    @Column(name = "name", length = 200, nullable = false)
    private String name;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "total_questions", nullable = false)
    private int totalQuestions;

    @Column(name = "exam_question_count", nullable = false)
    private int examQuestionCount;

    @Column(name = "exam_duration_min", nullable = false)
    private int examDurationMin;

    @Column(name = "passing_score", nullable = false)
    private int passingScore;

    @Column(name = "exam_type", length = 20, nullable = false)
    private String examType;

    @Column(name = "is_active", nullable = false)
    private boolean isActive = true;

    @Column(name = "created_at", nullable = false, updatable = false)
    private OffsetDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    private OffsetDateTime updatedAt;

    @OneToMany(mappedBy = "certification", cascade = CascadeType.ALL,
               fetch = FetchType.LAZY, orphanRemoval = true)
    @OrderBy("displayOrder ASC")
    private List<CertificationThemeEntity> themes = new ArrayList<>();

    @PrePersist
    protected void onCreate() {
        OffsetDateTime now = OffsetDateTime.now();
        if (createdAt == null) createdAt = now;
        updatedAt = now;
    }

    @PreUpdate
    protected void onUpdate() { updatedAt = OffsetDateTime.now(); }

    public String getId()                            { return id; }
    public void setId(String id)                     { this.id = id; }
    public String getCode()                          { return code; }
    public void setCode(String code)                 { this.code = code; }
    public String getName()                          { return name; }
    public void setName(String name)                 { this.name = name; }
    public String getDescription()                   { return description; }
    public void setDescription(String d)             { this.description = d; }
    public int getTotalQuestions()                   { return totalQuestions; }
    public void setTotalQuestions(int n)             { this.totalQuestions = n; }
    public int getExamQuestionCount()                { return examQuestionCount; }
    public void setExamQuestionCount(int n)          { this.examQuestionCount = n; }
    public int getExamDurationMin()                  { return examDurationMin; }
    public void setExamDurationMin(int n)            { this.examDurationMin = n; }
    public int getPassingScore()                     { return passingScore; }
    public void setPassingScore(int n)               { this.passingScore = n; }
    public String getExamType()                      { return examType; }
    public void setExamType(String t)                { this.examType = t; }
    public boolean isActive()                        { return isActive; }
    public void setActive(boolean active)            { this.isActive = active; }
    public OffsetDateTime getCreatedAt()             { return createdAt; }
    public void setCreatedAt(OffsetDateTime t)       { this.createdAt = t; }
    public OffsetDateTime getUpdatedAt()             { return updatedAt; }
    public void setUpdatedAt(OffsetDateTime t)       { this.updatedAt = t; }
    public List<CertificationThemeEntity> getThemes() { return themes; }
    public void setThemes(List<CertificationThemeEntity> t) { this.themes = t; }
}
