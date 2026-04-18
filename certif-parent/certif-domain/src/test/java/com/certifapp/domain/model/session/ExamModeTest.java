package com.certifapp.domain.model.session;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class ExamModeTest {

    @InjectMocks
    private ExamMode examMode;

    @BeforeEach
    public void setUp() {
        // No setup required for this enum, but it's good practice to have one for consistency
    }

    @Test
    @DisplayName("Exam mode supports timer")
    public void exam_mode_supports_timer() {
        assertThat(ExamMode.EXAM.supportsTimer()).isTrue();
        assertThat(ExamMode.FREE.supportsTimer()).isTrue();
        assertThat(ExamMode.REVISION.supportsTimer()).isFalse();
    }

    @Test
    @DisplayName("Free mode supports timer")
    public void free_mode_supports_timer() {
        assertThat(ExamMode.EXAM.supportsTimer()).isTrue();
        assertThat(ExamMode.FREE.supportsTimer()).isTrue();
        assertThat(ExamMode.REVISION.supportsTimer()).isFalse();
    }

    @Test
    @DisplayName("Revision mode does not support timer")
    public void revision_mode_does_not_support_timer() {
        assertThat(ExamMode.EXAM.supportsTimer()).isTrue();
        assertThat(ExamMode.FREE.supportsTimer()).isTrue();
        assertThat(ExamMode.REVISION.supportsTimer()).isFalse();
    }

    @Test
    @DisplayName("Exam mode shows immediate correction")
    public void exam_mode_does_not_show_immediate_correction() {
        assertThat(ExamMode.EXAM.showsImmediateCorrection()).isFalse();
        assertThat(ExamMode.FREE.showsImmediateCorrection()).isFalse();
        assertThat(ExamMode.REVISION.showsImmediateCorrection()).isTrue();
    }

    @Test
    @DisplayName("Free mode does not show immediate correction")
    public void free_mode_does_not_show_immediate_correction() {
        assertThat(ExamMode.EXAM.showsImmediateCorrection()).isFalse();
        assertThat(ExamMode.FREE.showsImmediateCorrection()).isFalse();
        assertThat(ExamMode.REVISION.showsImmediateCorrection()).isTrue();
    }

    @Test
    @DisplayName("Revision mode shows immediate correction")
    public void revision_mode_shows_immediate_correction() {
        assertThat(ExamMode.EXAM.showsImmediateCorrection()).isFalse();
        assertThat(ExamMode.FREE.showsImmediateCorrection()).isFalse();
        assertThat(ExamMode.REVISION.showsImmediateCorrection()).isTrue();
    }
}
