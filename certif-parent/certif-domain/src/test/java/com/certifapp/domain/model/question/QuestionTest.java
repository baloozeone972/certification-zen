package com.certifapp.domain.model.question;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.OffsetDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class QuestionTest {

    @Mock
    private List<QuestionOption> options;

    @InjectMocks
    private Question question;

    @BeforeEach
    public void setUp() {
        UUID id = UUID.randomUUID();
        String legacyId = "OCP21-VT-001";
        String certificationId = "ocp21";
        UUID themeId = UUID.randomUUID();
        String statement = "What is the capital of France?";
        DifficultyLevel difficulty = DifficultyLevel.EASY;
        QuestionType type = QuestionType.SINGLE_CHOICE;
        List<QuestionOption> optionsList = Arrays.asList(
                new QuestionOption(UUID.randomUUID(), false, "Paris"),
                new QuestionOption(UUID.randomUUID(), true, "London")
        );
        String explanationOriginal = "The capital of France is Paris.";
        ExplanationStatus explanationStatus = ExplanationStatus.HUMAN_VALIDATED;
        OffsetDateTime lastReviewedAt = OffsetDateTime.now();

        question = new Question(
                id,
                legacyId,
                certificationId,
                themeId,
                statement,
                difficulty,
                type,
                optionsList,
                explanationOriginal,
                null,
                explanationStatus,
                null,
                null,
                1.0,
                true,
                lastReviewedAt
        );
    }

    @Test
    @DisplayName("nominal case - correctOption should return the correct option")
    public void correctOption_nominal() {
        Optional<QuestionOption> result = question.correctOption();
        assertThat(result).isPresent().hasValueSatisfying(option ->
                assertThat(option.id()).isEqualTo(question.options.get(1).id())
        );
    }

    @Test
    @DisplayName("nominal case - correctOptions should return a list of all correct options")
    public void correctOptions_nominal() {
        List<QuestionOption> result = question.correctOptions();
        assertThat(result).hasSize(1)
                .containsExactly(question.options.get(1));
    }

    @Test
    @DisplayName("nominal case - findOption should return the matching option")
    public void findOption_nominal() {
        UUID optionId = question.options().get(0).id();
        Optional<QuestionOption> result = question.findOption(optionId);
        assertThat(result).isPresent().hasValueSatisfying(option ->
                assertThat(option.id()).isEqualTo(optionId)
        );
    }

    @Test
    @DisplayName("nominal case - bestExplanation should return the enriched explanation if available and validated")
    public void bestExplanation_enrichedValidated() {
        String enrichedExplanation = "Enriched: The capital of France is Paris.";
        when(question.explanationEnriched()).thenReturn(enrichedExplanation);
        ExplanationStatus status = ExplanationStatus.HUMAN_VALIDATED;
        when(question.explanationStatus()).thenReturn(status);

        String result = question.bestExplanation();
        assertThat(result).isEqualTo(enrichedExplanation);
    }

    @Test
    @DisplayName("nominal case - bestExplanation should return the original explanation if enriched is null or blank")
    public void bestExplanation_original() {
        when(question.explanationEnriched()).thenReturn(null);
        String result = question.bestExplanation();
        assertThat(result).isEqualTo(question.explanationOriginal());
    }

    @Test
    @DisplayName("edge case - correctOption should return empty if no option is marked correct")
    public void correctOption_edgeNoCorrect() {
        // Create real options with isCorrect = false
        List<QuestionOption> options = List.of(
                QuestionOption.of('A', "First option", false, 0),
                QuestionOption.of('B', "Second option", false, 1),
                QuestionOption.of('C', "Third option", false, 2)
        );

        // Assuming Question has a constructor or setter for options
        Question question = new Question( options);

        Optional<QuestionOption> result = question.correctOption();
        assertThat(result).isEmpty();
    }

    @Test
    @DisplayName("edge case - correctOptions should return an empty list if no options are marked correct")
    public void correctOptions_edgeNoCorrect() {
        List<QuestionOption> options = List.of(
                new QuestionOption("A", false),
                new QuestionOption("B", false)
        );
        Question question = new Question(/* ... */, options);

        List<QuestionOption> result = question.correctOptions();
        assertThat(result).isEmpty();
    }

    @Test
    @DisplayName("edge case - findOption should return empty if no option matches the ID")
    public void findOption_edgeNoMatch() {
        UUID nonExistentId = UUID.randomUUID();
        Optional<QuestionOption> result = question.findOption(nonExistentId);
        assertThat(result).isEmpty();
    }

    @Test
    @DisplayName("error case - constructor should throw IllegalArgumentException for blank certificationId")
    public void constructor_errorBlankCertificationId() {
        assertThrows(IllegalArgumentException.class, () ->
                new Question(
                        UUID.randomUUID(),
                        "OCP21-VT-001",
                        "",
                        UUID.randomUUID(),
                        "What is the capital of France?",
                        DifficultyLevel.EASY,
                        QuestionType.SINGLE_CHOICE,
                        List.of(),
                        "The capital of France is Paris.",
                        null,
                        ExplanationStatus.HUMAN_VALIDATED,
                        null,
                        null,
                        1.0,
                        true,
                        OffsetDateTime.now()
                )
        );
    }

    @Test
    @DisplayName("error case - constructor should throw IllegalArgumentException for blank statement")
    public void constructor_errorBlankStatement() {
        assertThrows(IllegalArgumentException.class, () ->
                new Question(
                        UUID.randomUUID(),
                        "OCP21-VT-001",
                        "ocp21",
                        UUID.randomUUID(),
                        "",
                        DifficultyLevel.EASY,
                        QuestionType.SINGLE_CHOICE,
                        List.of(),
                        "The capital of France is Paris.",
                        null,
                        ExplanationStatus.HUMAN_VALIDATED,
                        null,
                        null,
                        1.0,
                        true,
                        OffsetDateTime.now()
                )
        );
    }

    @Test
    @DisplayName("error case - constructor should throw IllegalArgumentException for options size less than 2")
    public void constructor_errorOptionsSizeLessThan2() {
        assertThrows(IllegalArgumentException.class, () ->
                new Question(
                        UUID.randomUUID(),
                        "OCP21-VT-001",
                        "ocp21",
                        UUID.randomUUID(),
                        "What is the capital of France?",
                        DifficultyLevel.EASY,
                        QuestionType.SINGLE_CHOICE,
                        List.of(new QuestionOption(UUID.randomUUID(), false, "Paris")),
                        "The capital of France is Paris.",
                        null,
                        ExplanationStatus.HUMAN_VALIDATED,
                        null,
                        null,
                        1.0,
                        true,
                        OffsetDateTime.now()
                )
        );
    }

    @Test
    @DisplayName("error case - constructor should throw IllegalArgumentException for null difficulty")
    public void constructor_errorNullDifficulty() {
        assertThrows(IllegalArgumentException.class, () ->
                new Question(
                        UUID.randomUUID(),
                        "OCP21-VT-001",
                        "ocp21",
                        UUID.randomUUID(),
                        "What is the capital of France?",
                        null,
                        QuestionType.SINGLE_CHOICE,
                        List.of(new QuestionOption(UUID.randomUUID(), false, "Paris")),
                        "The capital of France is Paris.",
                        null,
                        ExplanationStatus.HUMAN_VALIDATED,
                        null,
                        null,
                        1.0,
                        true,
                        OffsetDateTime.now()
                )
        );
    }

    @Test
    @DisplayName("error case - constructor should throw IllegalArgumentException for null type")
    public void constructor_errorNullType() {
        assertThrows(IllegalArgumentException.class, () ->
                new Question(
                        UUID.randomUUID(),
                        "OCP21-VT-001",
                        "ocp21",
                        UUID.randomUUID(),
                        "What is the capital of France?",
                        DifficultyLevel.EASY,
                        null,
                        List.of(new QuestionOption(UUID.randomUUID(), false, "Paris")),
                        "The capital of France is Paris.",
                        null,
                        ExplanationStatus.HUMAN_VALIDATED,
                        null,
                        null,
                        1.0,
                        true,
                        OffsetDateTime.now()
                )
        );
    }

    @Test
    @DisplayName("error case - constructor should throw IllegalArgumentException for null explanationStatus")
    public void constructor_errorNullExplanationStatus() {
        assertThrows(IllegalArgumentException.class, () ->
                new Question(
                        UUID.randomUUID(),
                        "OCP21-VT-001",
                        "ocp21",
                        UUID.randomUUID(),
                        "What is the capital of France?",
                        DifficultyLevel.EASY,
                        QuestionType.SINGLE_CHOICE,
                        List.of(QuestionOption.of(UUID.randomUUID(), false, "Paris",1)),
                        "The capital of France is Paris.",
                        null,
                        null,
                        null,
                        1.0,
                        true,
                        OffsetDateTime.now()
                )
        );
    }

    @Test
    @DisplayName("error case - constructor should throw IllegalArgumentException for aiConfidenceScore less than 0.0")
    public void constructor_errorAiConfidenceScoreLessThan0_0() {
        assertThrows(IllegalArgumentException.class, () ->
                new Question(
                        UUID.randomUUID(),
                        "OCP21-VT-001",
                        "ocp21",
                        UUID.randomUUID(),
                        "What is the capital of France?",
                        DifficultyLevel.EASY,
                        QuestionType.SINGLE_CHOICE,
                        List.of(new QuestionOption(UUID.randomUUID(), false, "Paris")),
                        "The capital of France is Paris.",
                        null,
                        ExplanationStatus.HUMAN_VALIDATED,
                        null,
                        -1.0,
                        true,
                        OffsetDateTime.now()
                )
        );
    }

    @Test
    @DisplayName("error case - constructor should throw IllegalArgumentException for aiConfidenceScore greater than 1.0")
    public void constructor_errorAiConfidenceScoreGreaterThan1_0() {
        assertThrows(IllegalArgumentException.class, () ->
                new Question(
                        UUID.randomUUID(),
                        "OCP21-VT-001",
                        "ocp21",
                        UUID.randomUUID(),
                        "What is the capital of France?",
                        DifficultyLevel.EASY,
                        QuestionType.SINGLE_CHOICE,
                        List.of(new QuestionOption(UUID.randomUUID(), false, "Paris")),
                        "The capital of France is Paris.",
                        null,
                        ExplanationStatus.HUMAN_VALIDATED,
                        null,
                        1.5,
                        true,
                        OffsetDateTime.now()
                )
        );
    }
}

