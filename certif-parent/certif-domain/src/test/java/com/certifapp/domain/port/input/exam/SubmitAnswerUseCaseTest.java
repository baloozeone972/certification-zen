```java
package com.certifapp.domain.port.input.exam;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

import com.certifapp.domain.exception.ExamAlreadyCompletedException;
import com.certifapp.domain.exception.ExamSessionNotFoundException;
import com.certifapp.domain.model.session.UserAnswer;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.UUID;

@ExtendWith(MockitoExtension.class)
public class SubmitAnswerUseCaseTest {

    @Mock
    private ExamSessionRepository examSessionRepository;

    @InjectMocks
    private SubmitAnswerUseCase submitAnswerUseCase;

    private UUID sessionId = UUID.randomUUID();
    private UUID userId = UUID.randomUUID();
    private UUID questionId = UUID.randomUUID();
    private UUID selectedOptionId = UUID.randomUUID();
    private long responseTimeMs = 1000L;
    private UserAnswer userAnswer;

    @BeforeEach
    public void setUp() {
        userAnswer = new UserAnswer(sessionId, userId, questionId, selectedOptionId, responseTimeMs);
    }

    @Test
    @DisplayName("SubmitAnswerUseCase_execute_nominal_case")
    public void testExecute_NominalCase() throws ExamSessionNotFoundException, ExamAlreadyCompletedException {
        when(examSessionRepository.findById(sessionId)).thenReturn(Optional.of(new ExamSession(userId)));
        when(examSessionRepository.save(any(UserAnswer.class))).thenReturn(userAnswer);

        UserAnswer result = submitAnswerUseCase.execute(new SubmitAnswerCommand(sessionId, userId, questionId, selectedOptionId, responseTimeMs));

        assertThat(result).isEqualTo(userAnswer);
        verify(examSessionRepository).findById(sessionId);
        verify(examSessionRepository).save(any(UserAnswer.class));
    }

    @Test
    @DisplayName("SubmitAnswerUseCase_execute_examSessionNotFoundException")
    public void testExecute_ExamSessionNotFoundException() {
        when(examSessionRepository.findById(sessionId)).thenReturn(Optional.empty());

        assertThatExceptionOfType(ExamSessionNotFoundException.class)
                .isThrownBy(() -> submitAnswerUseCase.execute(new SubmitAnswerCommand(sessionId, userId, questionId, selectedOptionId, responseTimeMs)))
                .withMessage("Exam session not found for ID: " + sessionId);
    }

    @Test
    @DisplayName("SubmitAnswerUseCase_execute_examAlreadyCompletedException")
    public void testExecute_ExamAlreadyCompletedException() throws ExamSessionNotFoundException {
        when(examSessionRepository.findById(sessionId)).thenReturn(Optional.of(new ExamSession(userId, true)));

        assertThatExceptionOfType(ExamAlreadyCompletedException.class)
                .isThrownBy(() -> submitAnswerUseCase.execute(new SubmitAnswerCommand(sessionId, userId, questionId, selectedOptionId, responseTimeMs)))
                .withMessage("Exam session is already completed for ID: " + sessionId);
    }

    @Test
    @DisplayName("SubmitAnswerUseCase_execute_selectedOptionId_null")
    public void testExecute_SelectedOptionId_Null() throws ExamSessionNotFoundException, ExamAlreadyCompletedException {
        when(examSessionRepository.findById(sessionId)).thenReturn(Optional.of(new ExamSession(userId)));
        when(examSessionRepository.save(any(UserAnswer.class))).thenReturn(userAnswer);

        UserAnswer result = submitAnswerUseCase.execute(new SubmitAnswerCommand(sessionId, userId, questionId, null, responseTimeMs));

        assertThat(result).isEqualTo(userAnswer);
        verify(examSessionRepository).findById(sessionId);
        verify(examSessionRepository).save(any(UserAnswer.class));
    }
}
```
