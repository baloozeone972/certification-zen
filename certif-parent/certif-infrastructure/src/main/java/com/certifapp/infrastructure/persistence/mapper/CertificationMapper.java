// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/mapper/CertificationMapper.java
package com.certifapp.infrastructure.persistence.mapper;

import com.certifapp.domain.model.certification.*;
import com.certifapp.infrastructure.persistence.entity.CertificationEntity;
import com.certifapp.infrastructure.persistence.entity.CertificationThemeEntity;
import org.mapstruct.*;

import java.util.List;

/**
 * MapStruct mapper for Certification and CertificationTheme.
 */
@Mapper(componentModel = "spring")
public interface CertificationMapper {

    @Mapping(target = "themes", source = "themes")
    Certification toDomain(CertificationEntity entity);

    List<Certification> toDomainList(List<CertificationEntity> entities);

    @Mapping(target = "certificationId", source = "certification.id")
    CertificationTheme toDomain(CertificationThemeEntity entity);

    @Mapping(target = "id",            ignore = true)
    @Mapping(target = "themes",        ignore = true)
    CertificationEntity toEntity(Certification domain);
}
