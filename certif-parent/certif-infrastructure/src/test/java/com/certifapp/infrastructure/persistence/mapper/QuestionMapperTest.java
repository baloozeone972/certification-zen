package com.certifapp.infrastructure.persistence.mapper;

import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

import java.util.Arrays;
import java.util.List;

import com.certifapp.domain.model.question.*;
import com.certifapp.infrastructure.persistence.entity.QuestionEntity;
import com.certifapp.infrastructure.persistence.entity.QuestionOptionEntity;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;

import static org.assertj.core.api.Assertions.assertThat;

@ExtendWith(MockitoExtension.class)
public class QuestionMapperTest {

    @Mock
    private DifficultyLevel difficultyMapper;

    @Mock
    private QuestionType questionTypeMapper;

    @Mock
    private ExplanationStatus explanationStatusMapper;

    @InjectMocks
    private QuestionMapper mapper;

    @BeforeEach
    public void setUp() {
        // Initialize mocks and dependencies if necessary
    }

    @AfterEach
    public void tearDown() {
        reset(difficultyMapper, questionTypeMapper, explanationStatusMapper);
    }

    @Test
    @DisplayName("toDomain should convert a QuestionEntity to a Question")
    public void toDomain_entityToDomain_success() {
        // Arrange
        String difficultyJson = "{\"level\":\"EASY\"}";
        DifficultyLevel expectedDifficulty = DifficultyLevel.EASY;
        when(difficultyMapper.fromJson(anyString())).thenReturn(expectedDifficulty);

        QuestionOptionEntity optionEntity = new QuestionOptionEntity();
        List<QuestionOptionEntity> options = Arrays.asList(optionEntity);
        
        QuestionEntity entity = new QuestionEntity();
        entity.setDifficulty("EASY");
        entity.setQuestionType("MULTIPLE_CHOICE");
        entity.setExplanationStatus("VISIBLE");
        entity.setOptions(options);

        // Act
        Question result = mapper.toDomain(entity);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.getDifficulty()).isEqualTo(expectedDifficulty);
        assertThat(result.getType()).isEqualTo(QuestionType.MULTIPLE_CHOICE);
        assertThat(result.getExplanationStatus()).isEqualTo(ExplanationStatus.VISIBLE);
        assertThat(result.getOptions()).hasSize(1);
    }

    @Test
    @DisplayName("toDomainList should convert a List of QuestionEntity to a List of Question")
    public void toDomainList_entityListToDomainList_success() {
        // Arrange
        String difficultyJson = "{\"level\":\"EASY\"}";
        DifficultyLevel expectedDifficulty = DifficultyLevel.EASY;
        when(difficultyMapper.fromJson(anyString())).thenReturn(expectedDifficulty);

        QuestionOptionEntity optionEntity = new QuestionOptionEntity();
        List<QuestionOptionEntity> options = Arrays.asList(optionEntity);
        
        QuestionEntity entity1 = new QuestionEntity();
        entity1.setDifficulty("EASY");
        entity1.setQuestionType("MULTIPLE_CHOICE");
        entity1.setExplanationStatus("VISIBLE");
        entity1.setOptions(options);

        QuestionEntity entity2 = new QuestionEntity();
        entity2.setDifficulty("MEDIUM");
        entity2.setQuestionType("TRUE_FALSE");
        entity2.setExplanationStatus("HIDDEN");
        entity2.setOptions(options);

        List<QuestionEntity> entities = Arrays.asList(entity1, entity2);

        // Act
        List<Question> result = mapper.toDomainList(entities);

        // Assert
        assertThat(result).hasSize(2);
        assertThat(result.get(0)).isNotNull();
        assertThat(result.get(0).getDifficulty()).isEqualTo(expectedDifficulty);
        assertThat(result.get(0).getType()).isEqualTo(QuestionType.MULTIPLE_CHOICE);
        assertThat(result.get(0).getExplanationStatus()).isEqualTo(ExplanationStatus.VISIBLE);
        assertThat(result.get(0).getOptions()).hasSize(1);

        assertThat(result.get(1)).isNotNull();
        assertThat(result.get(1).getDifficulty()).isEqualTo(DifficultyLevel.MEDIUM);
        assertThat(result.get(1).getType()).isEqualTo(QuestionType.TRUE_FALSE);
        assertThat(result.get(1).getExplanationStatus()).isEqualTo(ExplanationStatus.HIDDEN);
        assertThat(result.get(1).getOptions()).hasSize(1);
    }

    @Test
    @DisplayName("toDomain should handle null options")
    public void toDomain_entityWithNullOptions_toDomain_success() {
        // Arrange
        String difficultyJson = "{\"level\":\"EASY\"}";
        DifficultyLevel expectedDifficulty = DifficultyLevel.EASY;
        when(difficultyMapper.fromJson(anyString())).thenReturn(expectedDifficulty);

        QuestionEntity entity = new QuestionEntity();
        entity.setDifficulty("EASY");
        entity.setQuestionType("MULTIPLE_CHOICE");
        entity.setExplanationStatus("VISIBLE");
        entity.setOptions(null);

        // Act
        Question result = mapper.toDomain(entity);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.getOptions()).isNull();
    }

    @Test
    @DisplayName("toEntity should convert a Question to a QuestionEntity")
    public void toEntity_domainToEntity_success() {
        // Arrange
        DifficultyLevel domainDifficulty = DifficultyLevel.EASY;
        String difficultyJson = "{\"level\":\"EASY\"}";
        when(difficultyMapper.toJson(eq(domainDifficulty))).thenReturn(difficultyJson);

        QuestionOptionEntity optionEntity = new QuestionOptionEntity();
        List<QuestionOption> options = Arrays.asList(new QuestionOption("A", true), new QuestionOption("B", false));
        
        Question domain = new Question(domainDifficulty, QuestionType.MULTIPLE_CHOICE, ExplanationStatus.VISIBLE, "What is 2 + 2?", options);

        // Act
        QuestionEntity result = mapper.toEntity(domain);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.getQuestion()).isEqualTo("What is 2 + 2?");
        assertThat(result.getLabel()).isEqualTo("What is 2 + 2?");
        assertThat(result.getDifficulty()).isEqualTo(difficultyJson);
        assertThat(result.getQuestionType()).isEqualTo(QuestionType.MULTIPLE_CHOICE.name());
        assertThat(result.getExplanationStatus()).isEqualTo(ExplanationStatus.VISIBLE.name());
        assertThat(result.getOptions()).hasSize(2);
    }

    @Test
    @DisplayName("toEntity should ignore question field in domain")
    public void toEntity_domainWithNullQuestion_toEntity_success() {
        // Arrange
        DifficultyLevel domainDifficulty = DifficultyLevel.EASY;
        String difficultyJson = "{\"level\":\"EASY\"}";
        when(difficultyMapper.toJson(eq(domainDifficulty))).thenReturn(difficultyJson);

        QuestionOptionEntity optionEntity = new QuestionOptionEntity();
        List<QuestionOption> options = Arrays.asList(new QuestionOption("A", true), new QuestionOption("B", false));
        
        Question domain = new Question(domainDifficulty, QuestionType.MULTIPLE_CHOICE, ExplanationStatus.VISIBLE, null, options);

        // Act
        QuestionEntity result = mapper.toEntity(domain);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.getQuestion()).isNull();
    }
}
