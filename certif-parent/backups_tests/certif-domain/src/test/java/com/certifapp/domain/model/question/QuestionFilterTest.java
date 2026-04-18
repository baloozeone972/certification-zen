package com.certifapp.domain.model.question;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Set;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.when;

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
        assertThat(filter.themeCodes()).hasSize(2).containsExactlyInAnyOrder("THEME1", "THEME2");
    }

    @Test
    @DisplayName("should copy difficulties to a non-mutable list")
    public void shouldCopyDifficultiesToNonMutableList() {
        List<DifficultyLevel> originalDifficulties = List.of(DifficultyLevel.EASY, DifficultyLevel.MEDIUM, DifficultyLevel.HARD);
        QuestionFilter filter = new QuestionFilter("certificationId", themeCodes, originalDifficulties, excludeIds, true, 0);

        assertThat(filter.difficulties())
                .hasSize(3)
                .containsExactlyInAnyOrder();
    }
    @Test
    @DisplayName("should copy excludeIds to a non-mutable set")
    public void shouldCopyExcludeIdsToNonMutableSet() {
        Set<UUID> originalExcludeIds = Set.of(UUID.randomUUID(), UUID.randomUUID());
        QuestionFilter filter = new QuestionFilter("certificationId", themeCodes, difficulties, originalExcludeIds, true, 0);

        assertThat(filter.excludeIds())
                .hasSize(2)
                .containsExactlyInAnyOrder();  // ✅ Pass Set directly
    }

    @Test
    @DisplayName("should create a filter for an EXAM session with default settings")
    public void shouldCreateExamFilter() {
        QuestionFilter examFilter = QuestionFilter.forExam("certificationId", 10);
        assertThat(examFilter.certificationId()).isEqualTo("certificationId");
        assertThat(examFilter.themeCodes()).isEmpty();
        assertThat(examFilter.difficulties()).isEmpty();
        assertThat(examFilter.excludeIds()).isEmpty();
        assertThat(examFilter.activeOnly()).isTrue();
        assertThat(examFilter.limit()).isEqualTo(10);
    }

    @Test
    @DisplayName("should create a filter for a FREE mode session with specific themes")
    public void shouldCreateFreeModeFilter() {
        List<String> freeThemes = List.of("THEMEA", "THEMEB");
        QuestionFilter freeFilter = QuestionFilter.forFreeMode("certificationId", freeThemes, 15);
        assertThat(freeFilter.certificationId()).isEqualTo("certificationId");
        assertThat(freeFilter.themeCodes()).containsExactlyInAnyOrder("THEMEA", "THEMEB");
        assertThat(freeFilter.difficulties()).isEmpty();
        assertThat(freeFilter.excludeIds()).isEmpty();
        assertThat(freeFilter.activeOnly()).isTrue();
        assertThat(freeFilter.limit()).isEqualTo(15);
    }

    @Test
    @DisplayName("should set themeCodes to an empty list when null is passed")
    public void shouldSetThemeCodesToEmptyListWhenNull() {
        QuestionFilter filter = new QuestionFilter("certificationId", null, difficulties, excludeIds, true, 0);
        assertThat(filter.themeCodes()).isEmpty();
    }

    @Test
    @DisplayName("should set difficulties to an empty list when null is passed")
    public void shouldSetDifficultiesToEmptyListWhenNull() {
        QuestionFilter filter = new QuestionFilter("certificationId", themeCodes, null, excludeIds, true, 0);
        assertThat(filter.difficulties()).isEmpty();
    }

    @Test
    @DisplayName("should set excludeIds to an empty set when null is passed")
    public void shouldSetExcludeIdsToEmptySetWhenNull() {
        QuestionFilter filter = new QuestionFilter("certificationId", themeCodes, difficulties, null, true, 0);
        assertThat(filter.excludeIds()).isEmpty();
    }
}

