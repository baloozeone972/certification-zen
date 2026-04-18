// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/entity/SM2ScheduleEntity.java
package com.certifapp.infrastructure.persistence.entity;

import jakarta.persistence.*;

import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.UUID;

/**
 * JPA entity mapping the {@code user_sm2_schedule} table.
 */
@Entity
@Table(name = "user_sm2_schedule",
        uniqueConstraints = @UniqueConstraint(columnNames = {"user_id", "question_id"}),
        indexes = {@Index(name = "idx_sm2_user_due", columnList = "user_id, due_date")})
public class SM2ScheduleEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @Column(name = "user_id", nullable = false)
    private UUID userId;

    @Column(name = "question_id", nullable = false)
    private UUID questionId;

    @Column(name = "ease_factor", nullable = false, precision = 4, scale = 2)
    private double easeFactor = 2.5;

    @Column(name = "interval_days", nullable = false)
    private int intervalDays;

    @Column(name = "repetitions", nullable = false)
    private int repetitions;

    @Column(name = "due_date", nullable = false)
    private LocalDate dueDate;

    @Column(name = "last_reviewed_at")
    private OffsetDateTime lastReviewedAt;

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

    public UUID getQuestionId() {
        return questionId;
    }

    public void setQuestionId(UUID q) {
        this.questionId = q;
    }

    public double getEaseFactor() {
        return easeFactor;
    }

    public void setEaseFactor(double e) {
        this.easeFactor = e;
    }

    public int getIntervalDays() {
        return intervalDays;
    }

    public void setIntervalDays(int i) {
        this.intervalDays = i;
    }

    public int getRepetitions() {
        return repetitions;
    }

    public void setRepetitions(int r) {
        this.repetitions = r;
    }

    public LocalDate getDueDate() {
        return dueDate;
    }

    public void setDueDate(LocalDate d) {
        this.dueDate = d;
    }

    public OffsetDateTime getLastReviewedAt() {
        return lastReviewedAt;
    }

    public void setLastReviewedAt(OffsetDateTime t) {
        this.lastReviewedAt = t;
    }
}
