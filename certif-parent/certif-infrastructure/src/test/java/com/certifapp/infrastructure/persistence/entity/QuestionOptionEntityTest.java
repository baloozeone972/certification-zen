package com.certifapp.infrastructure.persistence.entity;

import java.util.UUID;
import org.junit.jupiter.api.extension.ExtendWith;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class QuestionOptionEntityTest {

    @Mock
    private QuestionEntity question;

    @InjectMocks
    private QuestionOptionEntity questionOption;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    @DisplayName("should set and get id")
    public void setIdAndGetId() {
        UUID id = UUID.randomUUID();
        questionOption.setId(id);
        assertThat(questionOption.getId()).isEqualTo(id);
    }

    @Test
    @DisplayName("should set and get question")
    public void setQuestionAndGetQuestion() {
        when(question.getId()).thenReturn(UUID.randomUUID());
        questionOption.setQuestion(question);
        assertThat(questionOption.getQuestion()).isEqualTo(question);
    }

    @Test
    @DisplayName("should set and get label")
    public void setLabelAndGetLabel() {
        char label = 'A';
        questionOption.setLabel(label);
        assertThat(questionOption.getLabel()).isEqualTo(label);
    }

    @Test
    @DisplayName("should set and get text")
    public void setTextAndGetText() {
        String text = "Option A";
        questionOption.setText(text);
        assertThat(questionOption.getText()).isEqualTo(text);
    }

    @Test
    @DisplayName("should set and get isCorrect")
    public void setIsCorrectAndGetIsCorrect() {
        boolean isCorrect = true;
        questionOption.setCorrect(isCorrect);
        assertThat(questionOption.isCorrect()).isEqualTo(isCorrect);
    }

    @Test
    @DisplayName("should set and get displayOrder")
    public void setDisplayOrderAndGetDisplayOrder() {
        int order = 1;
        questionOption.setDisplayOrder(order);
        assertThat(questionOption.getDisplayOrder()).isEqualTo(order);
    }
}
