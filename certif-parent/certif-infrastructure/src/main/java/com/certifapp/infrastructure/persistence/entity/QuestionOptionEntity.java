// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/entity/QuestionOptionEntity.java
package com.certifapp.infrastructure.persistence.entity;

import jakarta.persistence.*;
import java.util.UUID;

/**
 * JPA entity mapping the {@code question_options} table.
 */
@Entity
@Table(name = "question_options",
    uniqueConstraints = @UniqueConstraint(columnNames = {"question_id", "label"}))
public class QuestionOptionEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "question_id", nullable = false)
    private QuestionEntity question;

    @Column(name = "label", length = 1, nullable = false)
    private char label;

    @Column(name = "text", columnDefinition = "TEXT", nullable = false)
    private String text;

    @Column(name = "is_correct", nullable = false)
    private boolean isCorrect;

    @Column(name = "display_order", nullable = false)
    private int displayOrder;

    public UUID getId()                        { return id; }
    public void setId(UUID id)                 { this.id = id; }
    public QuestionEntity getQuestion()        { return question; }
    public void setQuestion(QuestionEntity q)  { this.question = q; }
    public char getLabel()                     { return label; }
    public void setLabel(char label)           { this.label = label; }
    public String getText()                    { return text; }
    public void setText(String text)           { this.text = text; }
    public boolean isCorrect()                 { return isCorrect; }
    public void setCorrect(boolean c)          { this.isCorrect = c; }
    public int getDisplayOrder()               { return displayOrder; }
    public void setDisplayOrder(int o)         { this.displayOrder = o; }
}
