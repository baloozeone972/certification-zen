// certif-parent/certif-application/src/main/java/com/certifapp/application/usecase/exam/StartExamSessionUseCaseImpl.java
package com.certifapp.application.usecase.exam;

import com.certifapp.domain.exception.CertificationNotFoundException;
import com.certifapp.domain.model.certification.Certification;
import com.certifapp.domain.model.question.Question;
import com.certifapp.domain.model.question.QuestionFilter;
import com.certifapp.domain.model.session.ExamMode;
import com.certifapp.domain.model.session.ExamSession;
import com.certifapp.domain.model.user.SubscriptionTier;
import com.certifapp.domain.port.input.exam.StartExamSessionUseCase;
import com.certifapp.domain.port.output.CertificationRepository;
import com.certifapp.domain.port.output.ExamSessionRepository;
import com.certifapp.domain.port.output.QuestionRepository;
import com.certifapp.domain.port.output.UserRepository;
import com.certifapp.domain.service.FreemiumGuardService;
import com.certifapp.domain.service.QuestionSelectionService;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Implementation of {@link StartExamSessionUseCase}.
 *
 * <p>Orchestration flow:
 * <ol>
 *   <li>Check freemium limits for FREE-tier users</li>
 *   <li>Load and validate the certification</li>
 *   <li>Determine effective question count and duration</li>
 *   <li>Select questions (proportional for FREE, random for EXAM)</li>
 *   <li>Create and persist the session</li>
 * </ol>
 */
public class StartExamSessionUseCaseImpl implements StartExamSessionUseCase {

    private final CertificationRepository certificationRepository;
    private final QuestionRepository questionRepository;
    private final ExamSessionRepository sessionRepository;
    private final UserRepository userRepository;
    private final FreemiumGuardService freemiumGuardService;
    private final QuestionSelectionService questionSelectionService;

    public StartExamSessionUseCaseImpl(
            CertificationRepository certificationRepository,
            QuestionRepository questionRepository,
            ExamSessionRepository sessionRepository,
            UserRepository userRepository,
            FreemiumGuardService freemiumGuardService,
            QuestionSelectionService questionSelectionService) {
        this.certificationRepository = certificationRepository;
        this.questionRepository = questionRepository;
        this.sessionRepository = sessionRepository;
        this.userRepository = userRepository;
        this.freemiumGuardService = freemiumGuardService;
        this.questionSelectionService = questionSelectionService;
    }

    @Override
    public ExamSession execute(StartExamCommand command) {
        // 1. Load user subscription tier for freemium checks
        SubscriptionTier tier = userRepository.findById(command.userId())
                .map(u -> u.subscriptionTier())
                .orElse(SubscriptionTier.FREE);

        // 2. Load certification
        Certification certification = certificationRepository.findById(command.certificationId())
                .orElseThrow(() -> new CertificationNotFoundException(command.certificationId()));

        // 3. Check daily exam limit for FREE users (EXAM mode only)
        if (command.mode() == ExamMode.EXAM) {
            int todayCount = sessionRepository.countTodayByUserAndCertification(
                    command.userId(), command.certificationId(), ExamMode.EXAM);
            freemiumGuardService.checkDailyExamLimit(tier, todayCount);
        }

        // 4. Determine effective question count
        int requested = (command.questionCount() > 0)
                ? command.questionCount()
                : certification.examQuestionCount();
        int effectiveCount = freemiumGuardService.effectiveQuestionCount(tier, requested);

        // 5. Select questions based on mode
        List<Question> selectedQuestions = selectQuestions(command, certification, effectiveCount);

        // 6. Create and persist session
        ExamSession session = ExamSession.start(
                command.userId(), command.certificationId(),
                command.mode(), selectedQuestions.size());

        return sessionRepository.save(session);
    }

    private List<Question> selectQuestions(StartExamCommand command,
                                           Certification certification,
                                           int count) {
        if (command.mode() == ExamMode.EXAM || command.selectedThemes().isEmpty()) {
            // EXAM mode: random selection from all questions
            QuestionFilter filter = QuestionFilter.forExam(command.certificationId(), count);
            return new ArrayList<>(questionRepository.findByFilter(filter));
        }

        // FREE mode: proportional selection per selected theme
        Map<String, List<Question>> byTheme = command.selectedThemes().stream()
                .collect(Collectors.toMap(
                        theme -> theme,
                        theme -> questionRepository.findByFilter(
                                QuestionFilter.forFreeMode(command.certificationId(),
                                        List.of(theme), Integer.MAX_VALUE))
                ));
        return new ArrayList<>(questionSelectionService.selectProportional(byTheme, count));
    }
}
