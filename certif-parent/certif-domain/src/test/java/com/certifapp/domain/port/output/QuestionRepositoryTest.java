package com.certifapp.domain.port.output;

import com.certifapp.domain.model.question.Question;
import com.certifapp.domain.model.question.QuestionFilter;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.*;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class QuestionRepositoryTest {

    @Mock
    private QuestionRepository questionRepository;

    @InjectMocks
    private QuestionRepository questionRepositoryImpl; // Assuming an implementation exists

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
        when(questionRepository.findById(testQuestionId)).thenReturn(Optional.of(new Question()));

        Optional<Question> result = questionRepository.findById(testQuestionId);

        assertThat(result).isPresent();
        verify(questionRepository, times(1)).findById(testQuestionId);
    }

    @Test
    @DisplayName("findById_nominalCase_questionNotFound")
    public void findById_nominalCase_questionNotFound() {
        when(questionRepository.findById(testQuestionId)).thenReturn(Optional.empty());

        Optional<Question> result = questionRepository.findById(testQuestionId);

        assertThat(result).isNotPresent();
        verify(questionRepository, times(1)).findById(testQuestionId);
    }

    @Test
    @DisplayName("findByLegacyId_nominalCase_questionFound")
    public void findByLegacyId_nominalCase_questionFound() {
        when(questionRepository.findByLegacyId(testLegacyId)).thenReturn(Optional.of(new Question()));

        Optional<Question> result = questionRepository.findByLegacyId(testLegacyId);

        assertThat(result).isPresent();
        verify(questionRepository, times(1)).findByLegacyId(testLegacyId);
    }

    @Test
    @DisplayName("findByLegacyId_nominalCase_questionNotFound")
    public void findByLegacyId_nominalCase_questionNotFound() {
        when(questionRepository.findByLegacyId(testLegacyId)).thenReturn(Optional.empty());

        Optional<Question> result = questionRepository.findByLegacyId(testLegacyId);

        assertThat(result).isNotPresent();
        verify(questionRepository, times(1)).findByLegacyId(testLegacyId);
    }

    @Test
    @DisplayName("findByFilter_nominalCase_questionsFound")
    public void findByFilter_nominalCase_questionsFound() {
        when(questionRepository.findByFilter(testQuestionFilter)).thenReturn(testQuestions);

        List<Question> result = questionRepository.findByFilter(testQuestionFilter);

        assertThat(result).isEqualTo(testQuestions);
        verify(questionRepository, times(1)).findByFilter(testQuestionFilter);
    }

    @Test
    @DisplayName("countByTheme_nominalCase_countMapReturned")
    public void countByTheme_nominalCase_countMapReturned() {
        when(questionRepository.countByTheme(any(String.class))).thenReturn(testCountMap);

        Map<String, Integer> result = questionRepository.countByTheme("testCertificationId");

        assertThat(result).isEqualTo(testCountMap);
        verify(questionRepository, times(1)).countByTheme(any(String.class));
    }

    @Test
    @DisplayName("save_nominalCase_questionSaved")
    public void save_nominalCase_questionSaved() {
        Question savedQuestion = new Question();
        when(questionRepository.save(any(Question.class))).thenReturn(savedQuestion);

        Question result = questionRepository.save(new Question());

        assertThat(result).isEqualTo(savedQuestion);
        verify(questionRepository, times(1)).save(any(Question.class));
    }

    @Test
    @DisplayName("saveAll_nominalCase_questionsSaved")
    public void saveAll_nominalCase_questionsSaved() {
        when(questionRepository.saveAll(any(List.class))).thenReturn(testQuestions);

        List<Question> result = questionRepository.saveAll(testQuestions);

        assertThat(result).isEqualTo(testQuestions);
        verify(questionRepository, times(1)).saveAll(any(List.class));
    }
}

