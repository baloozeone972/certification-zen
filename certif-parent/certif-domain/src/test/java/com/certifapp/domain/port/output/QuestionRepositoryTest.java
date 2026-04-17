package com.certifapp.domain.port.output;

import com.certifapp.domain.model.question.Question;
import com.certifapp.domain.model.question.QuestionFilter;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.*;

import static org.assertj.core.api.Assertions.assertThat;

public class QuestionRepositoryTest {

    private UUID testQuestionId;
    private String testLegacyId;
    private QuestionFilter testQuestionFilter;
    private List<Question> testQuestions;
    private Map<String, Integer> testCountMap;

    @BeforeEach
    public void setUp() {
        testQuestionId = UUID.randomUUID();
        testLegacyId = "legacy123";
        testQuestionFilter = new QuestionFilter();
        testQuestions = Collections.singletonList(new Question());
        testCountMap = Collections.singletonMap("theme", 1);
    }

    @Test
    @DisplayName("findById_nominalCase_questionFound")
    public void findById_nominalCase_questionFound() {
        // Arrange
        when(questionRepository.findById(testQuestionId)).thenReturn(Optional.of(new Question()));

        // Act
        Optional<Question> result = questionRepository.findById(testQuestionId);

        // Assert
        assertThat(result).isPresent();
        verify(questionRepository, times(1)).findById(testQuestionId);
    }

    @Test
    @DisplayName("findById_nominalCase_questionNotFound")
    public void findById_nominalCase_questionNotFound() {
        // Arrange
        when(questionRepository.findById(testQuestionId)).thenReturn(Optional.empty());

        // Act
        Optional<Question> result = questionRepository.findById(testQuestionId);

        // Assert
        assertThat(result).isNotPresent();
        verify(questionRepository, times(1)).findById(testQuestionId);
    }

    @Test
    @DisplayName("findByLegacyId_nominalCase_questionFound")
    public void findByLegacyId_nominalCase_questionFound() {
        // Arrange
        when(questionRepository.findByLegacyId(testLegacyId)).thenReturn(Optional.of(new Question()));

        // Act
        Optional<Question> result = questionRepository.findByLegacyId(testLegacyId);

        // Assert
        assertThat(result).isPresent();
        verify(questionRepository, times(1)).findByLegacyId(testLegacyId);
    }

    @Test
    @DisplayName("findByLegacyId_nominalCase_questionNotFound")
    public void findByLegacyId_nominalCase_questionNotFound() {
        // Arrange
        when(questionRepository.findByLegacyId(testLegacyId)).thenReturn(Optional.empty());

        // Act
        Optional<Question> result = questionRepository.findByLegacyId(testLegacyId);

        // Assert
        assertThat(result).isNotPresent();
        verify(questionRepository, times(1)).findByLegacyId(testLegacyId);
    }

    @Test
    @DisplayName("findByFilter_nominalCase_questionsFound")
    public void findByFilter_nominalCase_questionsFound() {
        // Arrange
        when(questionRepository.findByFilter(testQuestionFilter)).thenReturn(testQuestions);

        // Act
        List<Question> result = questionRepository.findByFilter(testQuestionFilter);

        // Assert
        assertThat(result).isEqualTo(testQuestions);
        verify(questionRepository, times(1)).findByFilter(testQuestionFilter);
    }

    @Test
    @DisplayName("countByTheme_nominalCase_countMapReturned")
    public void countByTheme_nominalCase_countMapReturned() {
        // Arrange
        when(questionRepository.countByTheme(any(String.class))).thenReturn(testCountMap);

        // Act
        Map<String, Integer> result = questionRepository.countByTheme("testCertificationId");

        // Assert
        assertThat(result).isEqualTo(testCountMap);
        verify(questionRepository, times(1)).countByTheme(any(String.class));
    }

    @Test
    @DisplayName("save_nominalCase_questionSaved")
    public void save_nominalCase_questionSaved() {
        // Arrange
        Question savedQuestion = new Question();
        when(questionRepository.save(any(Question.class))).thenReturn(savedQuestion);

        // Act
        Question result = questionRepository.save(new Question());

        // Assert
        assertThat(result).isEqualTo(savedQuestion);
        verify(questionRepository, times(1)).save(any(Question.class));
    }

    @Test
    @DisplayName("saveAll_nominalCase_questionsSaved")
    public void saveAll_nominalCase_questionsSaved() {
        // Arrange
        when(questionRepository.saveAll(any(List.class))).thenReturn(testQuestions);

        // Act
        List<Question> result = questionRepository.saveAll(testQuestions);

        // Assert
        assertThat(result).isEqualTo(testQuestions);
        verify(questionRepository, times(1)).saveAll(any(List.class));
    }
}