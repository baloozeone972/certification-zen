// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/entity/UserAnswerEntity.java
package com.certifapp.infrastructure.persistence.entity;

import jakarta.persistence.*;
import java.time.OffsetDateTime;
import java.util.UUID;

/**
 * JPA entity mapping the {@code user_answers} table.
 */
@Entity
@Table(name = "user_answers",
    uniqueConstraints = @UniqueConstraint(columnNames = {"session_id", "question_id"}),
    indexes = { @Index(name = "idx_answers_session", columnList = "session_id") })
public class UserAnswerEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @Column(name = "session_id", nullable = false)
    private UUID sessionId;

    @Column(name = "question_id", nullable = false)
    private UUID questionId;

    @Column(name = "selected_option")
    private UUID selectedOption;

    @Column(name = "is_correct", nullable = false)
    private boolean isCorrect;

    @Column(name = "is_skipped", nullable = false)
    private boolean isSkipped;

    @Column(name = "response_time_ms")
    private Long responseTimeMs;

    @Column(name = "answered_at", nullable = false)
    private OffsetDateTime answeredAt;

    @PrePersist
    protected void onCreate() { if (answeredAt == null) answeredAt = OffsetDateTime.now(); }

    public UUID getId()                          { return id; }
    public void setId(UUID id)                   { this.id = id; }
    public UUID getSessionId()                   { return sessionId; }
    public void setSessionId(UUID s)             { this.sessionId = s; }
    public UUID getQuestionId()                  { return questionId; }
    public void setQuestionId(UUID q)            { this.questionId = q; }
    public UUID getSelectedOption()              { return selectedOption; }
    public void setSelectedOption(UUID o)        { this.selectedOption = o; }
    public boolean isCorrect()                   { return isCorrect; }
    public void setCorrect(boolean c)            { this.isCorrect = c; }
    public boolean isSkipped()                   { return isSkipped; }
    public void setSkipped(boolean s)            { this.isSkipped = s; }
    public Long getResponseTimeMs()              { return responseTimeMs; }
    public void setResponseTimeMs(Long r)        { this.responseTimeMs = r; }
    public OffsetDateTime getAnsweredAt()        { return answeredAt; }
    public void setAnsweredAt(OffsetDateTime t)  { this.answeredAt = t; }
}
