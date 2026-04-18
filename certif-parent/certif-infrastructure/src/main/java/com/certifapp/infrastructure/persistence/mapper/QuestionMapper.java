// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/persistence/mapper/QuestionMapper.java
package com.certifapp.infrastructure.persistence.mapper;

import com.certifapp.domain.model.question.Question;
import com.certifapp.domain.model.question.QuestionOption;
import com.certifapp.infrastructure.persistence.entity.QuestionEntity;
import com.certifapp.infrastructure.persistence.entity.QuestionOptionEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

/**
 * MapStruct mapper for Question and QuestionOption.
 */
@Mapper(componentModel = "spring")
public interface QuestionMapper {

    @Mapping(target = "difficulty", expression = "java(com.certifapp.domain.model.question.DifficultyLevel.fromJson(entity.getDifficulty()))")
    @Mapping(target = "type", expression = "java(com.certifapp.domain.model.question.QuestionType.valueOf(entity.getQuestionType()))")
    @Mapping(target = "explanationStatus", expression = "java(com.certifapp.domain.model.question.ExplanationStatus.valueOf(entity.getExplanationStatus()))")
    @Mapping(target = "options", source = "options")
    Question toDomain(QuestionEntity entity);

    List<Question> toDomainList(List<QuestionEntity> entities);

    @Mapping(target = "question", ignore = true)
    @Mapping(target = "label", expression = "java(entity.getLabel())")
    QuestionOption toDomain(QuestionOptionEntity entity);

    @Mapping(target = "difficulty", expression = "java(domain.difficulty().toJson())")
    @Mapping(target = "questionType", expression = "java(domain.type().name())")
    @Mapping(target = "explanationStatus", expression = "java(domain.explanationStatus().name())")
    @Mapping(target = "options", ignore = true)
    QuestionEntity toEntity(Question domain);
}
