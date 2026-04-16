```java
package com.certifapp.application.dto.exam;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import org.assertj.core.api.Assertions;

@ExtendWith(MockitoExtension.class)
public class QuestionResultDtoTest {

    @BeforeEach
    public void setUp() {
        // Setup code if needed
    }

    @DisplayName("nominal case: create a new QuestionResultDto with all fields populated")
    @Test
    public void createQuestionResultDto_allFields_populated() {
        UUID id = UUID.randomUUID();
        String statement = "What is the capital of France?";
        List<QuestionOptionDto> options = List.of(
                new QuestionOptionDto(UUID.randomUUID(), "Paris", true),
                new QuestionOptionDto(UUID.randomUUID(), "London", false)
        );
        UUID correctOptionId = options.get(0).getId();
        UUID selectedOptionId = options.get(1).getId();
        boolean isCorrect = false;
        boolean isSkipped = false;
        String explanationOriginal = "The capital of France is Paris.";
        String explanationEnriched = null;
        String officialDocUrl = "http://example.com/french-capital";
        String themeCode = "France";
        String difficulty = "Easy";

        QuestionResultDto questionResultDto = new QuestionResultDto(
                id, statement, options, correctOptionId, selectedOptionId,
                isCorrect, isSkipped, explanationOriginal, explanationEnriched,
                officialDocUrl, themeCode, difficulty
        );

        Assertions.assertThat(questionResultDto.id()).isEqualTo(id);
        Assertions.assertThat(questionResultDto.statement()).isEqualTo(statement);
        Assertions.assertThat(questionResultDto.options()).isEqualTo(options);
        Assertions.assertThat(questionResultDto.correctOptionId()).isEqualTo(correctOptionId);
        Assertions.assertThat(questionResultDto.selectedOptionId()).isEqualTo(selectedOptionId);
        Assertions.assertThat(questionResultDto.isCorrect()).isEqualTo(isCorrect);
        Assertions.assertThat(questionResultDto.isSkipped()).isEqualTo(isSkipped);
        Assertions.assertThat(questionResultDto.explanationOriginal()).isEqualTo(explanationOriginal);
        Assertions.assertThat(questionResultDto.explanationEnriched()).isEqualTo(explanationEnriched);
        Assertions.assertThat(questionResultDto.officialDocUrl()).isEqualTo(officialDocUrl);
        Assertions.assertThat(questionResultDto.themeCode()).isEqualTo(themeCode);
        Assertions.assertThat(questionResultDto.difficulty()).isEqualTo(difficulty);
    }

    @DisplayName("edge case: create a new QuestionResultDto with null officialDocUrl")
    @Test
    public void createQuestionResultDto_nullOfficialDocUrl() {
        UUID id = UUID.randomUUID();
        String statement = "What is the capital of France?";
        List<QuestionOptionDto> options = List.of(
                new QuestionOptionDto(UUID.randomUUID(), "Paris", true),
                new QuestionOptionDto(UUID.randomUUID(), "London", false)
        );
        UUID correctOptionId = options.get(0).getId();
        UUID selectedOptionId = null;
        boolean isCorrect = true;
        boolean isSkipped = true;
        String explanationOriginal = "The capital of France is Paris.";
        String explanationEnriched = null;
        String officialDocUrl = null;
        String themeCode = "France";
        String difficulty = "Easy";

        QuestionResultDto questionResultDto = new QuestionResultDto(
                id, statement, options, correctOptionId, selectedOptionId,
                isCorrect, isSkipped, explanationOriginal, explanationEnriched,
                officialDocUrl, themeCode, difficulty
        );

        Assertions.assertThat(questionResultDto.id()).isEqualTo(id);
        Assertions.assertThat(questionResultDto.statement()).isEqualTo(statement);
        Assertions.assertThat(questionResultDto.options()).isEqualTo(options);
        Assertions.assertThat(questionResultDto.correctOptionId()).isEqualTo(correctOptionId);
        Assertions.assertThat(questionResultDto.selectedOptionId()).isEqualTo(selectedOptionId);
        Assertions.assertThat(questionResultDto.isCorrect()).isEqualTo(isCorrect);
        Assertions.assertThat(questionResultDto.isSkipped()).isEqualTo(isSkipped);
        Assertions.assertThat(questionResultDto.explanationOriginal()).isEqualTo(explanationOriginal);
        Assertions.assertThat(questionResultDto.explanationEnriched()).isEqualTo(explanationEnriched);
        Assertions.assertThat(questionResultDto.officialDocUrl()).isEqualTo(officialDocUrl);
        Assertions.assertThat(questionResultDto.themeCode()).isEqualTo(themeCode);
        Assertions.assertThat(questionResultDto.difficulty()).isEqualTo(difficulty);
    }

    @DisplayName("error case: create a new QuestionResultDto with an invalid option ID")
    @Test
    public void createQuestionResultDto_invalidOptionId() {
        UUID id = UUID.randomUUID();
        String statement = "What is the capital of France?";
        List<QuestionOptionDto> options = List.of(
                new QuestionOptionDto(UUID.randomUUID(), "Paris", true),
                new QuestionOptionDto(UUID.randomUUID(), "London", false)
        );
        UUID correctOptionId = UUID.randomUUID(); // Invalid option ID
        UUID selectedOptionId = null;
        boolean isCorrect = true;
        boolean isSkipped = true;
        String explanationOriginal = "The capital of France is Paris.";
        String explanationEnriched = null;
        String officialDocUrl = null;
        String themeCode = "France";
        String difficulty = "Easy";

        Assertions.assertThatThrownBy(() -> {
            new QuestionResultDto(
                    id, statement, options, correctOptionId, selectedOptionId,
                    isCorrect, isSkipped, explanationOriginal, explanationEnriched,
                    officialDocUrl, themeCode, difficulty
            );
        }).isInstanceOf(IllegalArgumentException.class).hasMessage("Invalid option ID: " + correctOptionId);
    }
}
```
