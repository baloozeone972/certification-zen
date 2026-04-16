// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/entity/UserPreferencesEntity.java
package com.certifapp.infrastructure.persistence.entity;

import jakarta.persistence.*;
import java.time.OffsetDateTime;
import java.util.UUID;

/**
 * JPA entity mapping the {@code user_preferences} table (1-to-1 with users).
 */
@Entity
@Table(name = "user_preferences")
public class UserPreferencesEntity {

    @Id
    @Column(name = "user_id", nullable = false)
    private UUID userId;

    @Column(name = "theme", nullable = false, length = 10)
    private String theme;

    @Column(name = "language", nullable = false, length = 10)
    private String language;

    @Column(name = "default_mode", nullable = false, length = 20)
    private String defaultMode;

    @Column(name = "notifications_enabled", nullable = false)
    private boolean notificationsEnabled = true;

    @Column(name = "last_certification_id", length = 50)
    private String lastCertificationId;

    @Column(name = "free_mode_question_count", nullable = false)
    private int freeModeQuestionCount = 30;

    @Column(name = "free_mode_duration_min", nullable = false)
    private int freeModeDurationMin = 60;

    @Column(name = "updated_at", nullable = false)
    private OffsetDateTime updatedAt;

    @PrePersist
    @PreUpdate
    protected void onUpdate() { updatedAt = OffsetDateTime.now(); }

    public UUID getUserId()                           { return userId; }
    public void setUserId(UUID userId)                { this.userId = userId; }
    public String getTheme()                          { return theme; }
    public void setTheme(String theme)                { this.theme = theme; }
    public String getLanguage()                       { return language; }
    public void setLanguage(String language)          { this.language = language; }
    public String getDefaultMode()                    { return defaultMode; }
    public void setDefaultMode(String defaultMode)    { this.defaultMode = defaultMode; }
    public boolean isNotificationsEnabled()           { return notificationsEnabled; }
    public void setNotificationsEnabled(boolean n)    { this.notificationsEnabled = n; }
    public String getLastCertificationId()            { return lastCertificationId; }
    public void setLastCertificationId(String id)     { this.lastCertificationId = id; }
    public int getFreeModeQuestionCount()             { return freeModeQuestionCount; }
    public void setFreeModeQuestionCount(int c)       { this.freeModeQuestionCount = c; }
    public int getFreeModeDurationMin()               { return freeModeDurationMin; }
    public void setFreeModeDurationMin(int d)         { this.freeModeDurationMin = d; }
    public OffsetDateTime getUpdatedAt()              { return updatedAt; }
    public void setUpdatedAt(OffsetDateTime t)        { this.updatedAt = t; }
}
