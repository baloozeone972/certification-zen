package com.certifapp.domain.service;

import com.certifapp.domain.model.question.Question;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.*;

import static org.assertj.core.api.Assertions.assertThat;

public class QuestionSelectionServiceTest {

    private List<Question> allQuestions;
    private Map<String, List<Question>> questionsByTheme;

    @BeforeEach
    public void setUp() {
        allQuestions = new ArrayList<>();
        for (int i = 0; i < 10; i++) {
            allQuestions.add(new Question("Q" + i));
        }

        questionsByTheme = new HashMap<>();
        for (int i = 0; i < 3; i++) {
            List<Question> themeQuestions = new ArrayList<>();
            for (int j = 0; j < 5; j++) {
                themeQuestions.add(new Question("Q" + (i * 10 + j)));
            }
            questionsByTheme.put("T" + i, themeQuestions);
        }
    }

    @Test
    @DisplayName("selectRandom_count_zero_shouldReturnEmptyList")
    public void selectRandom_count_zero_shouldReturnEmptyList() {
        List<Question> result = QuestionSelectionService.selectRandom(allQuestions, 0);
        assertThat(result).isEmpty();
    }

    @Test
    @DisplayName("selectRandom_allQuestions_empty_shouldReturnEmptyList")
    public void selectRandom_allQuestions_empty_shouldReturnEmptyList() {
        List<Question> result = QuestionSelectionService.selectRandom(new ArrayList<>(), 5);
        assertThat(result).isEmpty();
    }

    @Test
    @DisplayName("selectRandom_count_greaterThanAllQuestions_shouldReturnAllQuestions")
    public void selectRandom_count_greaterThanAllQuestions_shouldReturnAllQuestions() {
        List<Question> result = QuestionSelectionService.selectRandom(allQuestions, 15);
        assertThat(result).isEqualTo(allQuestions);
    }

    @Test
    @DisplayName("selectProportional_questionsByTheme_empty_shouldReturnEmptyList")
    public void selectProportional_questionsByTheme_empty_shouldReturnEmptyList() {
        List<Question> result = QuestionSelectionService.selectProportional(new HashMap<>(), 5);
        assertThat(result).isEmpty();
    }

    @Test
    @DisplayName("selectProportional_totalRequested_zero_shouldReturnEmptyList")
    public void selectProportional_totalRequested_zero_shouldReturnEmptyList() {
        List<Question> result = QuestionSelectionService.selectProportional(questionsByTheme, 0);
        assertThat(result).isEmpty();
    }

    @Test
    @DisplayName("selectProportional_totalAvailable_zero_shouldReturnEmptyList")
    public void selectProportional_totalAvailable_zero_shouldReturnEmptyList() {
        questionsByTheme.clear();
        List<Question> result = QuestionSelectionService.selectProportional(questionsByTheme, 5);
        assertThat(result).isEmpty();
    }

    @Test
    @DisplayName("selectProportional_count_greaterThanTotalAvailable_shouldReturnAllQuestions")
    public void selectProportional_count_greaterThanTotalAvailable_shouldReturnAllQuestions() {
        List<Question> result = QuestionSelectionService.selectProportional(questionsByTheme, 20);
        assertThat(result).isEqualTo(allQuestions);
    }
}