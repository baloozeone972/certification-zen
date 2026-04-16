```java
package com.certifapp.application.usecase.exam;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

import java.util.Map;
import java.util.UUID;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class SubmitAnswerUseCaseImplTest {

    @Mock
    private ExamSessionRepository sessionRepository;

    @Mock
    private QuestionRepository questionRepository;

    @Mock
    private UserAnswerRepository answerRepository;

    @Mock
    private ScoringService scoringService;

    @InjectMocks
    private SubmitAnswerUseCaseImpl submitAnswerUseCase;

    private SubmitAnswerCommand command;
    private ExamSession session;
    private Question question;
    private UserAnswer answer;

    @BeforeEach
    public void setUp() {
        command = new SubmitAnswerCommand(UUID.randomUUID(), UUID.randomUUID(), "optionId", 100L);
        session = new ExamSession(UUID.randomUUID(), UUID.randomUUID(), "userId", false);
        question = new Question(UUID.randomUUID(), "questionText");
        answer = UserAnswer.answered(command.sessionId(), command.questionId(), command.selectedOptionId(), command.responseTimeMs());
    }

    @Test
    @DisplayName("should submit correct answer and evaluate correctness")
    public void submitAnswerCorrect_answerShouldBeEvaluated() {
        when(sessionRepository.findById(command.sessionId())).thenReturn(java.util.Optional.of(session));
        when(questionRepository.findById(command.questionId())).thenReturn(java.util.Optional.of(question));

        UserAnswer result = submitAnswerUseCase.execute(command);

        verify(scoringService).evaluateAnswer(answer, Map.of(question.id(), question));
        assertThat(result).isEqualTo(answer);
    }

    @Test
    @DisplayName("should throw ExamSessionNotFoundException when session does not exist")
    public void submitAnswerSessionNotFound_exceptionShouldBeThrown() {
        when(sessionRepository.findById(command.sessionId())).thenReturn(java.util.Optional.empty());

        assertThrows(ExamSessionNotFoundException.class, () -> submitAnswerUseCase.execute(command));
    }

    @Test
    @DisplayName("should throw ExamAlreadyCompletedException when session is already completed")
    public void submitAnswerSessionCompleted_exceptionShouldBeThrown() {
        session.setStatus(true);
        when(sessionRepository.findById(command.sessionId())).thenReturn(java.util.Optional.of(session));

        assertThrows(ExamAlreadyCompletedException.class, () -> submitAnswerUseCase.execute(command));
    }

    @Test
    @DisplayName("should handle null selectedOptionId and create skipped answer")
    public void submitAnswerSkipped_answerShouldBeSaved() {
        command.setSelectedOptionId(null);
        when(sessionRepository.findById(command.sessionId())).thenReturn(java.util.Optional.of(session));

        UserAnswer result = submitAnswerUseCase.execute(command);

        verify(answerRepository).save(UserAnswer.skipped(command.sessionId(), command.questionId()));
        assertThat(result).isEqualTo(UserAnswer.skipped(command.sessionId(), command.questionId()));
    }

    @Test
    @DisplayName("should handle null question and not evaluate answer")
    public void submitAnswerQuestionNull_answerShouldBeSavedWithoutEvaluation() {
        when(sessionRepository.findById(command.sessionId())).thenReturn(java.util.Optional.of(session));
        when(questionRepository.findById(command.questionId())).thenReturn(java.util.Optional.empty());

        UserAnswer result = submitAnswerUseCase.execute(command);

        verify(scoringService, never()).evaluateAnswer(any(), any());
        assertThat(result).isEqualTo(answer);
    }
}
```
