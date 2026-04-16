// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/entity/UserEntity.java
package com.certifapp.infrastructure.persistence.entity;

import jakarta.persistence.*;
import java.time.OffsetDateTime;
import java.util.UUID;

/**
 * JPA entity mapping the {@code users} table.
 * Kept strictly separate from the domain {@code User} record.
 * Mapping between the two is handled by {@code UserMapper} (MapStruct).
 */
@Entity
@Table(name = "users", indexes = {
    @Index(name = "idx_users_email",        columnList = "email"),
    @Index(name = "idx_users_subscription", columnList = "subscription_tier")
})
public class UserEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @Column(name = "email", nullable = false, unique = true, length = 255)
    private String email;

    @Column(name = "password_hash", nullable = false, length = 255)
    private String passwordHash;

    @Column(name = "role", nullable = false, length = 20)
    private String role;

    @Column(name = "subscription_tier", nullable = false, length = 20)
    private String subscriptionTier;

    @Column(name = "locale", nullable = false, length = 10)
    private String locale;

    @Column(name = "timezone", nullable = false, length = 50)
    private String timezone;

    @Column(name = "stripe_customer_id", length = 100)
    private String stripeCustomerId;

    @Column(name = "is_active", nullable = false)
    private boolean isActive = true;

    @Column(name = "created_at", nullable = false, updatable = false)
    private OffsetDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    private OffsetDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        OffsetDateTime now = OffsetDateTime.now();
        if (createdAt == null) createdAt = now;
        updatedAt = now;
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = OffsetDateTime.now();
    }

    // ── Getters / Setters ────────────────────────────────────────────────────

    public UUID getId()                         { return id; }
    public void setId(UUID id)                  { this.id = id; }
    public String getEmail()                    { return email; }
    public void setEmail(String email)          { this.email = email; }
    public String getPasswordHash()             { return passwordHash; }
    public void setPasswordHash(String h)       { this.passwordHash = h; }
    public String getRole()                     { return role; }
    public void setRole(String role)            { this.role = role; }
    public String getSubscriptionTier()         { return subscriptionTier; }
    public void setSubscriptionTier(String t)   { this.subscriptionTier = t; }
    public String getLocale()                   { return locale; }
    public void setLocale(String locale)        { this.locale = locale; }
    public String getTimezone()                 { return timezone; }
    public void setTimezone(String tz)          { this.timezone = tz; }
    public String getStripeCustomerId()         { return stripeCustomerId; }
    public void setStripeCustomerId(String s)   { this.stripeCustomerId = s; }
    public boolean isActive()                   { return isActive; }
    public void setActive(boolean active)       { this.isActive = active; }
    public OffsetDateTime getCreatedAt()        { return createdAt; }
    public void setCreatedAt(OffsetDateTime t)  { this.createdAt = t; }
    public OffsetDateTime getUpdatedAt()        { return updatedAt; }
    public void setUpdatedAt(OffsetDateTime t)  { this.updatedAt = t; }
}
