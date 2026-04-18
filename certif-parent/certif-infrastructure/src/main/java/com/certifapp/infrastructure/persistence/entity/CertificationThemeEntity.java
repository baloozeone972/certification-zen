// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/entity/CertificationThemeEntity.java
package com.certifapp.infrastructure.persistence.entity;

import jakarta.persistence.*;

import java.time.OffsetDateTime;
import java.util.UUID;

/**
 * JPA entity mapping the {@code certification_themes} table.
 */
@Entity
@Table(name = "certification_themes",
        uniqueConstraints = @UniqueConstraint(columnNames = {"certification_id", "code"}))
public class CertificationThemeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "certification_id", nullable = false)
    private CertificationEntity certification;

    @Column(name = "code", length = 100, nullable = false)
    private String code;

    @Column(name = "label", length = 200, nullable = false)
    private String label;

    @Column(name = "question_count", nullable = false)
    private int questionCount;

    @Column(name = "weight_percent", precision = 5, scale = 2)
    private Double weightPercent;

    @Column(name = "display_order", nullable = false)
    private int displayOrder;

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

    public CertificationEntity getCertification() {
        return certification;
    }

    public void setCertification(CertificationEntity c) {
        this.certification = c;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public int getQuestionCount() {
        return questionCount;
    }

    public void setQuestionCount(int n) {
        this.questionCount = n;
    }

    public Double getWeightPercent() {
        return weightPercent;
    }

    public void setWeightPercent(Double w) {
        this.weightPercent = w;
    }

    public int getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(int o) {
        this.displayOrder = o;
    }

    public OffsetDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(OffsetDateTime t) {
        this.createdAt = t;
    }
}
