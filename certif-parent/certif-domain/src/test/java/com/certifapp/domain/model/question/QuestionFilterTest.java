package com.certifapp.domain.model.question;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import org.assertj.core.api.Assertions;

import java.util.List;
import java.util.Set;
import java.util.UUID;

import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class QuestionFilterTest {

    @InjectMocks
    private QuestionFilter questionFilter;

    @Mock
    private List<String> themeCodes;

    @Mock
    private List<DifficultyLevel> difficulties;

    @Mock
    private Set<UUID> excludeIds;

    @BeforeEach
    public void setUp() {
        when(themeCodes.size()).thenReturn(2);
        when(difficulties.size()).thenReturn(3);
        when(excludeIds.size()).thenReturn(1);
    }

    @Test
    @DisplayName("should throw IllegalArgumentException for blank certificationId")
    public void shouldThrowIllegalArgumentExceptionForBlankCertificationId() {
        Assertions.assertThatThrownBy(() -> new QuestionFilter("", List.of(), List.of(), Set.of(), true, 0))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("certificationId must not be blank");
    }

    @Test
    @DisplayName("should copy themeCodes to a non-mutable list")
    public void shouldCopyThemeCodesToNonMutableList() {
        List<String> originalThemeCodes = List.of("THEME1", "THEME2");
        QuestionFilter filter = new QuestionFilter("certificationId", originalThemeCodes, difficulties, excludeIds, true, 0);
        Assertions.assertThat(filter.themeCodes()).hasSize(2).containsExactlyInAnyOrder("THEME1", "THEME2");
    }

    @Test
    @DisplayName("should copy difficulties to a non-mutable list")
    public void shouldCopyDifficultiesToNonMutableList() {
        List<DifficultyLevel> originalDifficulties = List.of(DifficultyLevel.EASY, DifficultyLevel.MEDIUM, DifficultyLevel.HARD);
        QuestionFilter filter = new QuestionFilter("certificationId", themeCodes, originalDifficulties, excludeIds, true, 0);
        Assertions.assertThat(filter.difficulties()).hasSize(3).containsExactlyInAnyOrder(originalDifficulties.toArray());
    }

    @Test
    @DisplayName("should copy excludeIds to a non-mutable set")
    public void shouldCopyExcludeIdsToNonMutableSet() {
        Set<UUID> originalExcludeIds = Set.of(UUID.randomUUID(), UUID.randomUUID());
        QuestionFilter filter = new QuestionFilter("certificationId", themeCodes, difficulties, originalExcludeIds, true, 0);
        Assertions.assertThat(filter.excludeIds()).hasSize(2).containsExactlyInAnyOrder(originalExcludeIds.toArray());
    }

    @Test
    @DisplayName("should create a filter for an EXAM session with default settings")
    public void shouldCreateExamFilter() {
        QuestionFilter examFilter = QuestionFilter.forExam("certificationId", 10);
        Assertions.assertThat(examFilter.certificationId()).isEqualTo("certificationId");
        Assertions.assertThat(examFilter.themeCodes()).isEmpty();
        Assertions.assertThat(examFilter.difficulties()).isEmpty();
        Assertions.assertThat(examFilter.excludeIds()).isEmpty();
        Assertions.assertThat(examFilter.activeOnly()).isTrue();
        Assertions.assertThat(examFilter.limit()).isEqualTo(10);
    }

    @Test
    @DisplayName("should create a filter for a FREE mode session with specific themes")
    public void shouldCreateFreeModeFilter() {
        List<String> freeThemes = List.of("THEMEA", "THEMEB");
        QuestionFilter freeFilter = QuestionFilter.forFreeMode("certificationId", freeThemes, 15);
        Assertions.assertThat(freeFilter.certificationId()).isEqualTo("certificationId");
        Assertions.assertThat(freeFilter.themeCodes()).containsExactlyInAnyOrder("THEMEA", "THEMEB");
        Assertions.assertThat(freeFilter.difficulties()).isEmpty();
        Assertions.assertThat(freeFilter.excludeIds()).isEmpty();
        Assertions.assertThat(freeFilter.activeOnly()).isTrue();
        Assertions.assertThat(freeFilter.limit()).isEqualTo(15);
    }

    @Test
    @DisplayName("should set themeCodes to an empty list when null is passed")
    public void shouldSetThemeCodesToEmptyListWhenNull() {
        QuestionFilter filter = new QuestionFilter("certificationId", null, difficulties, excludeIds, true, 0);
        Assertions.assertThat(filter.themeCodes()).isEmpty();
    }

    @Test
    @DisplayName("should set difficulties to an empty list when null is passed")
    public void shouldSetDifficultiesToEmptyListWhenNull() {
        QuestionFilter filter = new QuestionFilter("certificationId", themeCodes, null, excludeIds, true, 0);
        Assertions.assertThat(filter.difficulties()).isEmpty();
    }

    @Test
    @DisplayName("should set excludeIds to an empty set when null is passed")
    public void shouldSetExcludeIdsToEmptySetWhenNull() {
        QuestionFilter filter = new QuestionFilter("certificationId", themeCodes, difficulties, null, true, 0);
        Assertions.assertThat(filter.excludeIds()).isEmpty();
    }
}
