package com.certifapp.domain.model.learning;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

public class FlashcardTest {

    @DisplayName("should throw IllegalArgumentException when both questionId and courseId are null")
    @Test
    public void fromQuestion_questionIdAndCourseIdNull_throwsIllegalArgumentException() {
        UUID questionId = null;
        UUID courseId = null;
        String frontText = "front";
        String backText = "back";
        boolean aiGenerated = true;

        assertThatThrownBy(() -> Flashcard.fromQuestion(questionId, frontText, backText, "", aiGenerated))
                .isInstanceOf(IllegalArgumentException.class)
                .withMessage("A flashcard must have either a questionId or a courseId");
    }

    @DisplayName("should throw IllegalArgumentException when frontText is blank")
    @Test
    public void fromQuestion_frontTextBlank_throwsIllegalArgumentException() {
        UUID questionId = UUID.randomUUID();
        String frontText = "";
        String backText = "back";
        boolean aiGenerated = true;

        assertThatThrownBy(() -> Flashcard.fromQuestion(questionId, frontText, backText, "", aiGenerated))
                .isInstanceOf(IllegalArgumentException.class)
                .withMessage("frontText must not be blank");
    }

    @DisplayName("should throw IllegalArgumentException when backText is blank")
    @Test
    public void fromQuestion_backTextBlank_throwsIllegalArgumentException() {
        UUID questionId = UUID.randomUUID();
        String frontText = "front";
        String backText = "";
        boolean aiGenerated = true;

        assertThatThrownBy(() -> Flashcard.fromQuestion(questionId, frontText, backText, "", aiGenerated))
                .isInstanceOf(IllegalArgumentException.class)
                .withMessage("backText must not be blank");
    }

    @DisplayName("should create a flashcard sourced from a question")
    @Test
    public void fromQuestion_validParameters_createsFlashcard() {
        UUID questionId = UUID.randomUUID();
        String frontText = "front";
        String backText = "back";
        boolean aiGenerated = true;

        Flashcard result = Flashcard.fromQuestion(questionId, frontText, backText, "", aiGenerated);

        assertThat(result.questionId()).isEqualTo(questionId);
        assertThat(result.courseId()).isNull();
        assertThat(result.frontText()).isEqualTo(frontText);
        assertThat(result.backText()).isEqualTo(backText);
        assertThat(result.aiGenerated()).isEqualTo(aiGenerated);
        assertThat(result.createdAt()).isNotNull();
    }

    @DisplayName("should throw IllegalArgumentException when both courseId and questionId are null")
    @Test
    public void fromCourse_courseIdAndQuestionIdNull_throwsIllegalArgumentException() {
        UUID courseId = null;
        String frontText = "front";
        String backText = "back";
        boolean aiGenerated = true;

        assertThatThrownBy(() -> Flashcard.fromCourse(courseId, frontText, backText, "", aiGenerated))
                .isInstanceOf(IllegalArgumentException.class)
                .withMessage("A flashcard must have either a questionId or a courseId");
    }

    @DisplayName("should throw IllegalArgumentException when frontText is blank")
    @Test
    public void fromCourse_frontTextBlank_throwsIllegalArgumentException() {
        UUID courseId = UUID.randomUUID();
        String frontText = "";
        String backText = "back";
        boolean aiGenerated = true;

        assertThatThrownBy(() -> Flashcard.fromCourse(courseId, frontText, backText, "", aiGenerated))
                .isInstanceOf(IllegalArgumentException.class)
                .withMessage("frontText must not be blank");
    }

    @DisplayName("should throw IllegalArgumentException when backText is blank")
    @Test
    public void fromCourse_backTextBlank_throwsIllegalArgumentException() {
        UUID courseId = UUID.randomUUID();
        String frontText = "front";
        String backText = "";
        boolean aiGenerated = true;

        assertThatThrownBy(() -> Flashcard.fromCourse(courseId, frontText, backText, "", aiGenerated))
                .isInstanceOf(IllegalArgumentException.class)
                .withMessage("backText must not be blank");
    }

    @DisplayName("should create a flashcard sourced from a course")
    @Test
    public void fromCourse_validParameters_createsFlashcard() {
        UUID courseId = UUID.randomUUID();
        String frontText = "front";
        String backText = "back";
        boolean aiGenerated = true;

        Flashcard result = Flashcard.fromCourse(courseId, frontText, backText, "", aiGenerated);

        assertThat(result.courseId()).isEqualTo(courseId);
        assertThat(result.questionId()).isNull();
        assertThat(result.frontText()).isEqualTo(frontText);
        assertThat(result.backText()).isEqualTo(backText);
        assertThat(result.aiGenerated()).isEqualTo(aiGenerated);
        assertThat(result.createdAt()).isNotNull();
    }
}