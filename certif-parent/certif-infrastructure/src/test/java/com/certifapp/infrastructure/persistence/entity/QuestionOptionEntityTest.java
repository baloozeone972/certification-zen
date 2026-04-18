package com.certifapp.infrastructure.persistence.entity;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.transaction.annotation.Transactional;

import static org.assertj.core.api.Assertions.assertThat;

@DataJpaTest
@ContextConfiguration(initializers = SpringBootTestContextInitializer.class)
@Transactional
public class QuestionOptionEntityTest {

    @Autowired
    private QuestionOptionRepository questionOptionRepository;

    @BeforeEach
    public void setUp() {
        // Nettoyage BDD entre tests
    }

    @Test
    @DisplayName("should set and get id")
    public void setIdAndGetId() {
        UUID id = UUID.randomUUID();
        QuestionOptionEntity questionOption = new QuestionOptionEntity();
        questionOption.setId(id);
        assertThat(questionOption.getId()).isEqualTo(id);
    }

    @Test
    @DisplayName("should set and get question")
    public void setQuestionAndGetQuestion() {
        QuestionEntity question = new QuestionEntity();
        UUID questionId = UUID.randomUUID();
        question.setId(questionId);
        QuestionOptionEntity questionOption = new QuestionOptionEntity();
        questionOption.setQuestion(question);
        assertThat(questionOption.getQuestion()).isEqualTo(question);
    }

    @Test
    @DisplayName("should set and get label")
    public void setLabelAndGetLabel() {
        char label = 'A';
        QuestionOptionEntity questionOption = new QuestionOptionEntity();
        questionOption.setLabel(label);
        assertThat(questionOption.getLabel()).isEqualTo(label);
    }

    @Test
    @DisplayName("should set and get text")
    public void setTextAndGetText() {
        String text = "Option A";
        QuestionOptionEntity questionOption = new QuestionOptionEntity();
        questionOption.setText(text);
        assertThat(questionOption.getText()).isEqualTo(text);
    }

    @Test
    @DisplayName("should set and get isCorrect")
    public void setIsCorrectAndGetIsCorrect() {
        boolean isCorrect = true;
        QuestionOptionEntity questionOption = new QuestionOptionEntity();
        questionOption.setCorrect(isCorrect);
        assertThat(questionOption.isCorrect()).isEqualTo(isCorrect);
    }

    @Test
    @DisplayName("should set and get displayOrder")
    public void setDisplayOrderAndGetDisplayOrder() {
        int order = 1;
        QuestionOptionEntity questionOption = new QuestionOptionEntity();
        questionOption.setDisplayOrder(order);
        assertThat(questionOption.getDisplayOrder()).isEqualTo(order);
    }
}