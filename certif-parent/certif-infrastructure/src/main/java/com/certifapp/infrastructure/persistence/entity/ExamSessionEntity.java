// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/entity/ExamSessionEntity.java
package com.certifapp.infrastructure.persistence.entity;

import jakarta.persistence.*;

import java.time.OffsetDateTime;
import java.util.UUID;

/**
 * JPA entity mapping the {@code exam_sessions} table.
 */
@Entity
@Table(name = "exam_sessions", indexes = {
        @Index(name = "idx_sessions_user", columnList = "user_id"),
        @Index(name = "idx_sessions_cert", columnList = "certification_id"),
        @Index(name = "idx_sessions_started", columnList = "started_at"),
        @Index(name = "idx_sessions_user_cert", columnList = "user_id, certification_id")
})
public class ExamSessionEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @Column(name = "user_id", nullable = false)
    private UUID userId;

    @Column(name = "certification_id", length = 50, nullable = false)
    private String certificationId;

    @Column(name = "mode", length = 20, nullable = false)
    private String mode;

    @Column(name = "status", length = 20, nullable = false)
    private String status;

    @Column(name = "started_at", nullable = false)
    private OffsetDateTime startedAt;

    @Column(name = "ended_at")
    private OffsetDateTime endedAt;

    @Column(name = "duration_seconds")
    private Integer durationSeconds;

    @Column(name = "total_questions", nullable = false)
    private int totalQuestions;

    @Column(name = "correct_count", nullable = false)
    private int correctCount;

    @Column(name = "percentage", nullable = false, precision = 5, scale = 2)
    private double percentage;

    @Column(name = "passed", nullable = false)
    private boolean passed;

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

    public UUID getUserId() {
        return userId;
    }

    public void setUserId(UUID u) {
        this.userId = u;
    }

    public String getCertificationId() {
        return certificationId;
    }

    public void setCertificationId(String c) {
        this.certificationId = c;
    }

    public String getMode() {
        return mode;
    }

    public void setMode(String mode) {
        this.mode = mode;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public OffsetDateTime getStartedAt() {
        return startedAt;
    }

    public void setStartedAt(OffsetDateTime t) {
        this.startedAt = t;
    }

    public OffsetDateTime getEndedAt() {
        return endedAt;
    }

    public void setEndedAt(OffsetDateTime t) {
        this.endedAt = t;
    }

    public Integer getDurationSeconds() {
        return durationSeconds;
    }

    public void setDurationSeconds(Integer d) {
        this.durationSeconds = d;
    }

    public int getTotalQuestions() {
        return totalQuestions;
    }

    public void setTotalQuestions(int n) {
        this.totalQuestions = n;
    }

    public int getCorrectCount() {
        return correctCount;
    }

    public void setCorrectCount(int n) {
        this.correctCount = n;
    }

    public double getPercentage() {
        return percentage;
    }

    public void setPercentage(double p) {
        this.percentage = p;
    }

    public boolean isPassed() {
        return passed;
    }

    public void setPassed(boolean p) {
        this.passed = p;
    }

    public OffsetDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(OffsetDateTime t) {
        this.createdAt = t;
    }
}
