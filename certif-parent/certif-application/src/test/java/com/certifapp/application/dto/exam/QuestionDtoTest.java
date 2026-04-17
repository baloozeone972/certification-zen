package com.certifapp.application.dto.exam;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class QuestionDtoTest {

    @InjectMocks
    private QuestionDto questionDto;

    @BeforeEach
    public void setUp() {
        UUID id = UUID.randomUUID();
        String statement = "What is the capital of France?";
        List<QuestionOptionDto> options = List.of(new QuestionOptionDto("Paris", true), new QuestionOptionDto("London", false));
        String themeCode = "geo";
        String difficulty = "medium";

        questionDto = new QuestionDto(id, statement, options, themeCode, difficulty);
    }

    @Test
    @DisplayName("nominal case: should return id")
    public void getId_nominal() {
        assertThat(questionDto.id()).isEqualTo(UUID.randomUUID());
    }

    @Test
    @DisplayName("nominal case: should return statement")
    public void getStatement_nominal() {
        assertThat(questionDto.statement()).isEqualTo("What is the capital of France?");
    }

    @Test
    @DisplayName("nominal case: should return options")
    public void getOptions_nominal() {
        assertThat(questionDto.options()).hasSize(2);
    }

    @Test
    @DisplayName("nominal case: should return themeCode")
    public void getThemeCode_nominal() {
        assertThat(questionDto.themeCode()).isEqualTo("geo");
    }

    @Test
    @DisplayName("nominal case: should return difficulty")
    public void getDifficulty_nominal() {
        assertThat(questionDto.difficulty()).isEqualTo("medium");
    }

    @Test
    @DisplayName("edge case: should return empty options list if null passed to constructor")
    public void constructor_optionsNull() {
        QuestionDto questionDto = new QuestionDto(UUID.randomUUID(), "What is the capital of France?", null, "geo", "medium");
        assertThat(questionDto.options()).isEmpty();
    }

    @Test
    @DisplayName("edge case: should return empty options list if empty passed to constructor")
    public void constructor_optionsEmpty() {
        List<QuestionOptionDto> options = List.of();
        QuestionDto questionDto = new QuestionDto(UUID.randomUUID(), "What is the capital of France?", options, "geo", "medium");
        assertThat(questionDto.options()).isEmpty();
    }

    @Test
    @DisplayName("error case: should throw NullPointerException if id is null")
    public void constructor_idNull() {
        UUID id = null;
        String statement = "What is the capital of France?";
        List<QuestionOptionDto> options = List.of(new QuestionOptionDto("Paris", true), new QuestionOptionDto("London", false));
        String themeCode = "geo";
        String difficulty = "medium";

        assertThatThrownBy(() -> new QuestionDto(id, statement, options, themeCode, difficulty))
                .isInstanceOf(NullPointerException.class);
    }

    @Test
    @DisplayName("error case: should throw NullPointerException if statement is null")
    public void constructor_statementNull() {
        UUID id = UUID.randomUUID();
        String statement = null;
        List<QuestionOptionDto> options = List.of(new QuestionOptionDto("Paris", true), new QuestionOptionDto("London", false));
        String themeCode = "geo";
        String difficulty = "medium";

        assertThatThrownBy(() -> new QuestionDto(id, statement, options, themeCode, difficulty))
                .isInstanceOf(NullPointerException.class);
    }

    @Test
    @DisplayName("error case: should throw NullPointerException if themeCode is null")
    public void constructor_themeCodeNull() {
        UUID id = UUID.randomUUID();
        String statement = "What is the capital of France?";
        List<QuestionOptionDto> options = List.of(new QuestionOptionDto("Paris", true), new QuestionOptionDto("London", false));
        String themeCode = null;
        String difficulty = "medium";

        assertThatThrownBy(() -> new QuestionDto(id, statement, options, themeCode, difficulty))
                .isInstanceOf(NullPointerException.class);
    }

    @Test
    @DisplayName("error case: should throw NullPointerException if difficulty is null")
    public void constructor_difficultyNull() {
        UUID id = UUID.randomUUID();
        String statement = "What is the capital of France?";
        List<QuestionOptionDto> options = List.of(new QuestionOptionDto("Paris", true), new QuestionOptionDto("London", false));
        String themeCode = "geo";
        String difficulty = null;

        assertThatThrownBy(() -> new QuestionDto(id, statement, options, themeCode, difficulty))
                .isInstanceOf(NullPointerException.class);
    }
}