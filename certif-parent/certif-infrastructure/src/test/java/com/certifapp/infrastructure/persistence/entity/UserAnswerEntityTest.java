package com.certifapp.infrastructure.persistence.entity;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.verifyNoMoreInteractions;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class UserAnswerEntityTest {

    @Mock
    private UUID mockId;

    @Mock
    private UUID mockSessionId;

    @Mock
    private UUID mockQuestionId;

    @Mock
    private UUID mockSelectedOption;

    @InjectMocks
    private UserAnswerEntity userAnswerEntity;

    @BeforeEach
    public void setUp() {
        when(mockId).thenReturn(UUID.randomUUID());
        when(mockSessionId).thenReturn(UUID.randomUUID());
        when(mockQuestionId).thenReturn(UUID.randomUUID());
        when(mockSelectedOption).thenReturn(UUID.randomUUID());

        userAnswerEntity.setId(mockId);
        userAnswerEntity.setSessionId(mockSessionId);
        userAnswerEntity.setQuestionId(mockQuestionId);
        userAnswerEntity.setSelectedOption(mockSelectedOption);
    }

    @AfterEach
    public void tearDown() {
        verifyNoMoreInteractions(mockId, mockSessionId, mockQuestionId, mockSelectedOption);
    }

    @Test
    @DisplayName("Test UserAnswerEntity creation with correct values")
    public void testUserAnswerEntityCreationCorrectValues() {
        assertThat(userAnswerEntity.getId()).isNotNull();
        assertThat(userAnswerEntity.getSessionId()).isEqualTo(mockSessionId);
        assertThat(userAnswerEntity.getQuestionId()).isEqualTo(mockQuestionId);
        assertThat(userAnswerEntity.getSelectedOption()).isEqualTo(mockSelectedOption);
        assertThat(userAnswerEntity.isCorrect()).isFalse();
        assertThat(userAnswerEntity.isSkipped()).isFalse();
        assertThat(userAnswerEntity.getResponseTimeMs()).isNull();
        assertThat(userAnswerEntity.getAnsweredAt()).isNotNull();
    }

    @Test
    @DisplayName("Test UserAnswerEntity creation with null values")
    public void testUserAnswerEntityCreationNullValues() {
        when(mockId).thenReturn(null);
        when(mockSessionId).thenReturn(null);
        when(mockQuestionId).thenReturn(null);
        when(mockSelectedOption).thenReturn(null);

        userAnswerEntity.setId(mockId);
        userAnswerEntity.setSessionId(mockSessionId);
        userAnswerEntity.setQuestionId(mockQuestionId);
        userAnswerEntity.setSelectedOption(mockSelectedOption);

        assertThat(userAnswerEntity.getId()).isNull();
        assertThat(userAnswerEntity.getSessionId()).isNull();
        assertThat(userAnswerEntity.getQuestionId()).isNull();
        assertThat(userAnswerEntity.getSelectedOption()).isNull();
    }

    @Test
    @DisplayName("Test UserAnswerEntity creation with isCorrect set to true")
    public void testUserAnswerEntityCreationIsCorrectTrue() {
        userAnswerEntity.setCorrect(true);
        assertThat(userAnswerEntity.isCorrect()).isTrue();
    }

    @Test
    @DisplayName("Test UserAnswerEntity creation with isSkipped set to true")
    public void testUserAnswerEntityCreationIsSkippedTrue() {
        userAnswerEntity.setSkipped(true);
        assertThat(userAnswerEntity.isSkipped()).isTrue();
    }

    @Test
    @DisplayName("Test UserAnswerEntity creation with responseTimeMs set to a value")
    public void testUserAnswerEntityCreationResponseTimeMsValue() {
        when(mockId).thenReturn(UUID.randomUUID());
        when(mockSessionId).thenReturn(UUID.randomUUID());
        when(mockQuestionId).thenReturn(UUID.randomUUID());
        when(mockSelectedOption).thenReturn(UUID.randomUUID());

        userAnswerEntity.setId(mockId);
        userAnswerEntity.setSessionId(mockSessionId);
        userAnswerEntity.setQuestionId(mockQuestionId);
        userAnswerEntity.setSelectedOption(mockSelectedOption);
        userAnswerEntity.setResponseTimeMs(100L);

        assertThat(userAnswerEntity.getResponseTimeMs()).isEqualTo(100L);
    }

}
