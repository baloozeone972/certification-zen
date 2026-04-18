// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/mapper/UserMapper.java
package com.certifapp.infrastructure.persistence.mapper;

import com.certifapp.domain.model.user.User;
import com.certifapp.domain.model.user.UserPreferences;
import com.certifapp.infrastructure.persistence.entity.UserEntity;
import com.certifapp.infrastructure.persistence.entity.UserPreferencesEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

/**
 * MapStruct mapper between JPA entities and domain Records.
 *
 * <p>Uses {@code componentModel = "spring"} to be managed as a Spring bean
 * and injected into adapter classes.</p>
 */
@Mapper(componentModel = "spring")
public interface UserMapper {

    // ── User ────────────────────────────────────────────────────────────────

    @Mapping(target = "role", expression = "java(com.certifapp.domain.model.user.UserRole.valueOf(entity.getRole()))")
    @Mapping(target = "subscriptionTier", expression = "java(com.certifapp.domain.model.user.SubscriptionTier.valueOf(entity.getSubscriptionTier()))")
    User toDomain(UserEntity entity);

    @Mapping(target = "role", expression = "java(domain.role().name())")
    @Mapping(target = "subscriptionTier", expression = "java(domain.subscriptionTier().name())")
    @Mapping(target = "active", source = "isActive")
    UserEntity toEntity(User domain);

    // ── UserPreferences ──────────────────────────────────────────────────────

    @Mapping(target = "theme", expression = "java(com.certifapp.domain.model.user.UiTheme.valueOf(entity.getTheme().toUpperCase()))")
    @Mapping(target = "defaultMode", expression = "java(com.certifapp.domain.model.session.ExamMode.valueOf(entity.getDefaultMode()))")
    UserPreferences toDomain(UserPreferencesEntity entity);

    @Mapping(target = "theme", expression = "java(domain.theme().name().toLowerCase())")
    @Mapping(target = "defaultMode", expression = "java(domain.defaultMode().name())")
    UserPreferencesEntity toEntity(UserPreferences domain);
}
