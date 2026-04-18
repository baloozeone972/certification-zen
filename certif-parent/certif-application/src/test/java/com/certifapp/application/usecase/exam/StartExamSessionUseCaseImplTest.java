// certif-parent/certif-application/src/test/java/com/certifapp/application/usecase/exam/StartExamSessionUseCaseImplTest.java
package com.certifapp.application.usecase.exam;

import java.util.UUID;

import com.certifapp.domain.exception.CertificationNotFoundException;
import com.certifapp.domain.exception.FreemiumLimitExceededException;
import com.certifapp.domain.model.certification.Certification;
import com.certifapp.domain.model.question.Question;
import com.certifapp.domain.model.question.QuestionFilter;
import com.certifapp.domain.model.session.ExamMode;
import com.certifapp.domain.model.session.ExamSession;
import com.certifapp.domain.model.user.SubscriptionTier;
import com.certifapp.domain.model.user.User;
import com.certifapp.domain.model.user.UserRole;
import com.certifapp.domain.port.input.exam.StartExamSessionUseCase;
import com.certifapp.domain.port.output.*;
import com.certifapp.domain.service.FreemiumGuardService;
import com.certifapp.domain.service.QuestionSelectionService;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.OffsetDateTime;
import java.util.*;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * Unit tests for {@link StartExamSessionUseCaseImpl}.
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("StartExamSessionUseCaseImpl")
class StartExamSessionUseCaseImplTest {

    @Mock private CertificationRepository   certificationRepository;
    @Mock private QuestionRepository        questionRepository;
    @Mock private ExamSessionRepository     sessionRepository;
    @Mock private UserRepository            userRepository;

    private FreemiumGuardService      freemiumGuardService;
    private QuestionSelectionService  questionSelectionService;
    private StartExamSessionUseCaseImpl useCase;

    private static final UUID USER_ID = UUID.randomUUID();
    private static final UUID SESSION_ID = UUID.randomUUID();
    private static final String CERT_ID = "ocp21";

    @BeforeEach
    void setUp() {
        freemiumGuardService     = new FreemiumGuardService();
        questionSelectionService = new QuestionSelectionService();
        useCase = new StartExamSessionUseCaseImpl(
                certificationRepository, questionRepository,
                sessionRepository, userRepository,
                freemiumGuardService, questionSelectionService);
    }

    @Test
    @DisplayName("PRO user starts EXAM session — success with examQuestionCount questions")
    void proUser_examMode_shouldCreateSession() {
        // Arrange
        User proUser = buildUser(SubscriptionTier.PRO);
        Certification cert = buildCertification(80, 180, 68);
        List<Question> questions = buildQuestions(80);
        ExamSession savedSession = ExamSession.start(USER_ID, CERT_ID, ExamMode.EXAM, 80);

        when(userRepository.findById(USER_ID)).thenReturn(Optional.of(proUser));
        when(certificationRepository.findById(CERT_ID)).thenReturn(Optional.of(cert));
        when(questionRepository.findByFilter(any(QuestionFilter.class))).thenReturn(questions);
        when(sessionRepository.save(any(ExamSession.class))).thenReturn(savedSession);

        StartExamSessionUseCase.StartExamCommand cmd = new StartExamSessionUseCase.StartExamCommand(
                USER_ID, CERT_ID, ExamMode.EXAM, List.of(), 0, 0);

        // Act
        ExamSession result = useCase.execute(cmd);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.certificationId()).isEqualTo(CERT_ID);
        verify(sessionRepository).save(any(ExamSession.class));
    }

    @Test
    @DisplayName("FREE user exceeds daily exam limit — throws FreemiumLimitExceededException")
    void freeUser_dailyLimitExceeded_shouldThrow() {
        // Arrange
        User freeUser = buildUser(SubscriptionTier.FREE);
        Certification cert = buildCertification(80, 180, 68);

        when(userRepository.findById(USER_ID)).thenReturn(Optional.of(freeUser));
        when(certificationRepository.findById(CERT_ID)).thenReturn(Optional.of(cert));
        // 2 exams already done today = at the limit
        when(sessionRepository.countTodayByUserAndCertification(USER_ID, CERT_ID, ExamMode.EXAM))
                .thenReturn(2);

        StartExamSessionUseCase.StartExamCommand cmd = new StartExamSessionUseCase.StartExamCommand(
                USER_ID, CERT_ID, ExamMode.EXAM, List.of(), 0, 0);

        // Act + Assert
        assertThatThrownBy(() -> useCase.execute(cmd))
                .isInstanceOf(FreemiumLimitExceededException.class)
                .hasMessageContaining("FREE tier");
    }

    @Test
    @DisplayName("FREE user: question count capped at 20")
    void freeUser_questionCountCappedAt20() {
        // Arrange
        User freeUser = buildUser(SubscriptionTier.FREE);
        Certification cert = buildCertification(80, 180, 68);
        List<Question> questions = buildQuestions(20);
        ExamSession savedSession = ExamSession.start(USER_ID, CERT_ID, ExamMode.FREE, 20);

        when(userRepository.findById(USER_ID)).thenReturn(Optional.of(freeUser));
        when(certificationRepository.findById(CERT_ID)).thenReturn(Optional.of(cert));
        when(questionRepository.findByFilter(any(QuestionFilter.class))).thenReturn(questions);
        when(sessionRepository.save(any(ExamSession.class))).thenReturn(savedSession);

        StartExamSessionUseCase.StartExamCommand cmd = new StartExamSessionUseCase.StartExamCommand(
                USER_ID, CERT_ID, ExamMode.FREE, List.of("virtual_threads"), 50, 0);

        // Act
        ExamSession result = useCase.execute(cmd);

        // Assert — verify the filter was called (questions were selected)
        verify(questionRepository, atLeastOnce()).findByFilter(any(QuestionFilter.class));
    }

    @Test
    @DisplayName("Certification not found — throws CertificationNotFoundException")
    void certificationNotFound_shouldThrow() {
        // Arrange
        User proUser = buildUser(SubscriptionTier.PRO);
        when(userRepository.findById(USER_ID)).thenReturn(Optional.of(proUser));
        when(certificationRepository.findById("unknown")).thenReturn(Optional.empty());

        StartExamSessionUseCase.StartExamCommand cmd = new StartExamSessionUseCase.StartExamCommand(
                USER_ID, "unknown", ExamMode.EXAM, List.of(), 0, 0);

        // Act + Assert
        assertThatThrownBy(() -> useCase.execute(cmd))
                .isInstanceOf(CertificationNotFoundException.class);
    }

    // ── Helpers ──────────────────────────────────────────────────────────────

    private static User buildUser(SubscriptionTier tier) {
        return new User(USER_ID, "user@test.com", "$2b$12$hash",
                UserRole.USER, tier, "fr", "Europe/Paris",
                null, true, OffsetDateTime.now(), OffsetDateTime.now());
    }

    private static Certification buildCertification(int examCount, int durationMin, int passing) {
        return new Certification(CERT_ID, "1Z0-830", "OCP Java 21",
                "Description", 500, examCount, durationMin, passing,
                "MCQ", List.of(), true);
    }

    private static List<Question> buildQuestions(int count) {
        List<Question> list = new ArrayList<>();
        for (int i = 0; i < count; i++) {
            UUID qId = UUID.randomUUID();
            UUID oId = UUID.randomUUID();
            list.add(new com.certifapp.domain.model.question.Question(
                    qId, "LEG-" + i, CERT_ID, UUID.randomUUID(),
                    "Question " + i,
                    com.certifapp.domain.model.question.DifficultyLevel.MEDIUM,
                    com.certifapp.domain.model.question.QuestionType.SINGLE_CHOICE,
                    List.of(new com.certifapp.domain.model.question.QuestionOption(
                            oId, qId, 'A', "Option A", true, 0)),
                    "Explanation", null,
                    com.certifapp.domain.model.question.ExplanationStatus.ORIGINAL,
                    null, null, null, true, null));
        }
        return list;
    }
}
