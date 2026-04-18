// certif-parent/certif-application/src/test/java/com/certifapp/application/usecase/exam/SubmitAnswerUseCaseImplTest.java
package com.certifapp.application.usecase.exam;

import com.certifapp.domain.exception.ExamSessionNotFoundException;
import com.certifapp.domain.model.question.*;
import com.certifapp.domain.model.session.*;
import com.certifapp.domain.port.input.exam.SubmitAnswerUseCase.SubmitAnswerCommand;
import com.certifapp.domain.port.output.*;
import com.certifapp.domain.service.ScoringService;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.OffsetDateTime;
import java.util.*;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("SubmitAnswerUseCaseImpl")
class SubmitAnswerUseCaseImplTest {

    @Mock ExamSessionRepository sessionRepository;
    @Mock QuestionRepository    questionRepository;
    @Mock UserAnswerRepository  answerRepository;
    @Mock ScoringService        scoringService;
    @InjectMocks SubmitAnswerUseCaseImpl useCase;

    private static final UUID SESSION_ID  = UUID.randomUUID();
    private static final UUID QUESTION_ID = UUID.randomUUID();
    private static final UUID USER_ID     = UUID.randomUUID();
    private static final UUID OPTION_ID   = UUID.randomUUID();

    private ExamSession buildSession() {
        return new ExamSession(SESSION_ID, USER_ID, "ocp21", ExamMode.EXAM,
                SessionStatus.IN_PROGRESS, OffsetDateTime.now(), null, null,
                10, 0, 0.0, false, List.of());
    }

    private Question buildQuestion() {
        return new Question(QUESTION_ID, "ocp21", "oop",
                "What is a Record?", List.of(), "Explanation",
                DifficultyLevel.EASY, QuestionType.SINGLE_CHOICE,
                List.of(), null, null);
    }

    @Test @DisplayName("execute — session not found → ExamSessionNotFoundException")
    void execute_sessionNotFound_throws() {
        when(sessionRepository.findById(SESSION_ID)).thenReturn(Optional.empty());
        var cmd = new SubmitAnswerCommand(SESSION_ID, QUESTION_ID, List.of(OPTION_ID), 5000L);
        assertThatThrownBy(() -> useCase.execute(cmd))
            .isInstanceOf(ExamSessionNotFoundException.class);
    }

    @Test @DisplayName("execute — answer saved and returned")
    void execute_valid_savesAndReturnsAnswer() {
        when(sessionRepository.findById(SESSION_ID)).thenReturn(Optional.of(buildSession()));
        when(questionRepository.findById(QUESTION_ID)).thenReturn(Optional.of(buildQuestion()));
        when(scoringService.evaluateAnswer(any(), any())).thenReturn(true);
        when(answerRepository.save(any())).thenAnswer(i -> i.getArgument(0));

        var cmd = new SubmitAnswerCommand(SESSION_ID, QUESTION_ID, List.of(OPTION_ID), 5000L);
        UserAnswer result = useCase.execute(cmd);

        assertThat(result).isNotNull();
        verify(answerRepository).save(any(UserAnswer.class));
    }
}
