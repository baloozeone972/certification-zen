// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/mapper/ExamSessionMapper.java
package com.certifapp.infrastructure.persistence.mapper;

import com.certifapp.domain.model.session.*;
import com.certifapp.infrastructure.persistence.entity.ExamSessionEntity;
import com.certifapp.infrastructure.persistence.entity.UserAnswerEntity;
import org.mapstruct.*;

import java.util.List;

/**
 * MapStruct mapper for ExamSession and UserAnswer.
 */
@Mapper(componentModel = "spring")
public interface ExamSessionMapper {

    @Mapping(target = "mode",    expression = "java(com.certifapp.domain.model.session.ExamMode.valueOf(entity.getMode()))")
    @Mapping(target = "status",  expression = "java(com.certifapp.domain.model.session.SessionStatus.valueOf(entity.getStatus()))")
    @Mapping(target = "answers", ignore = true)
    ExamSession toDomain(ExamSessionEntity entity);

    @Mapping(target = "mode",   expression = "java(domain.mode().name())")
    @Mapping(target = "status", expression = "java(domain.status().name())")
    ExamSessionEntity toEntity(ExamSession domain);

    @Mapping(target = "selectedOptionId", source = "selectedOption")
    UserAnswer toDomain(UserAnswerEntity entity);

    @Mapping(target = "selectedOption", source = "selectedOptionId")
    UserAnswerEntity toEntity(UserAnswer domain);

    List<UserAnswer> toDomainAnswerList(List<UserAnswerEntity> entities);
}
