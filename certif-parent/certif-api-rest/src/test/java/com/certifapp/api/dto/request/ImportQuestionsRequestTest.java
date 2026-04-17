package com.certifapp.api.dto.request;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.assertj.core.api.Assertions.assertThat;

@ExtendWith(MockitoExtension.class)
public class ImportQuestionsRequestTest {

    @InjectMocks
    private ImportQuestionsRequest importQuestionsRequest;

    @BeforeEach
    public void setUp() {
        // Setup logic if needed
    }

    @DisplayName("should create a valid ImportQuestionsRequest with nominal data")
    @Test
    public void createValidImportQuestionsRequest_nominalData_success() {
        // Arrange
        String certificationId = "CERT-001";
        List<QuestionImportItem> questions = List.of(
                new QuestionImportItem("JAVA-001", "Java Basics", "What is the capital of France?", "easy",
                        List.of("Paris", "London", "Berlin", "Madrid"), 0, "The capital of France is Paris.")
        );

        // Act
        importQuestionsRequest = new ImportQuestionsRequest(certificationId, questions);

        // Assert
        assertThat(importQuestionsRequest.certificationId()).isEqualTo(certificationId);
        assertThat(importQuestionsRequest.questions()).isEqualTo(questions);
    }

    @DisplayName("should reject empty certificationId")
    @Test
    public void createValidImportQuestionsRequest_emptyCertificationId_failure() {
        // Arrange
        String certificationId = "";
        List<QuestionImportItem> questions = List.of(
                new QuestionImportItem("JAVA-001", "Java Basics", "What is the capital of France?", "easy",
                        List.of("Paris", "London", "Berlin", "Madrid"), 0, "The capital of France is Paris.")
        );

        // Act & Assert
        assertThatThrownBy(() -> new ImportQuestionsRequest(certificationId, questions))
                .isInstanceOf(ConstraintViolationException.class);
    }

    @DisplayName("should reject null certificationId")
    @Test
    public void createValidImportQuestionsRequest_nullCertificationId_failure() {
        // Arrange
        String certificationId = null;
        List<QuestionImportItem> questions = List.of(
                new QuestionImportItem("JAVA-001", "Java Basics", "What is the capital of France?", "easy",
                        List.of("Paris", "London", "Berlin", "Madrid"), 0, "The capital of France is Paris.")
        );

        // Act & Assert
        assertThatThrownBy(() -> new ImportQuestionsRequest(certificationId, questions))
                .isInstanceOf(ConstraintViolationException.class);
    }

    @DisplayName("should reject empty question list")
    @Test
    public void createValidImportQuestionsRequest_emptyQuestionList_failure() {
        // Arrange
        String certificationId = "CERT-001";
        List<QuestionImportItem> questions = List.of();

        // Act & Assert
        assertThatThrownBy(() -> new ImportQuestionsRequest(certificationId, questions))
                .isInstanceOf(ConstraintViolationException.class);
    }

    @DisplayName("should reject question list with more than 500 items")
    @Test
    public void createValidImportQuestionsRequest_questionListTooLong_failure() {
        // Arrange
        String certificationId = "CERT-001";
        List<QuestionImportItem> questions = List.generate(i -> new QuestionImportItem(
                        "JAVA-" + i, "Java Basics", "What is the capital of France?", "easy",
                        List.of("Paris", "London", "Berlin", "Madrid"), 0, "The capital of France is Paris.")
                , 501);

        // Act & Assert
        assertThatThrownBy(() -> new ImportQuestionsRequest(certificationId, questions))
                .isInstanceOf(ConstraintViolationException.class);
    }

    @DisplayName("should reject question with empty themeLabel")
    @Test
    public void createValidImportQuestionsRequest_emptyThemeLabel_failure() {
        // Arrange
        String certificationId = "CERT-001";
        List<QuestionImportItem> questions = List.of(
                new QuestionImportItem("JAVA-001", "", "What is the capital of France?", "easy",
                        List.of("Paris", "London", "Berlin", "Madrid"), 0, "The capital of France is Paris.")
        );

        // Act & Assert
        assertThatThrownBy(() -> new ImportQuestionsRequest(certificationId, questions))
                .isInstanceOf(ConstraintViolationException.class);
    }

    @DisplayName("should reject question with null themeLabel")
    @Test
    public void createValidImportQuestionsRequest_nullThemeLabel_failure() {
        // Arrange
        String certificationId = "CERT-001";
        List<QuestionImportItem> questions = List.of(
                new QuestionImportItem("JAVA-001", null, "What is the capital of France?", "easy",
                        List.of("Paris", "London", "Berlin", "Madrid"), 0, "The capital of France is Paris.")
        );

        // Act & Assert
        assertThatThrownBy(() -> new ImportQuestionsRequest(certificationId, questions))
                .isInstanceOf(ConstraintViolationException.class);
    }

    @DisplayName("should reject question with empty statement")
    @Test
    public void createValidImportQuestionsRequest_emptyStatement_failure() {
        // Arrange
        String certificationId = "CERT-001";
        List<QuestionImportItem> questions = List.of(
                new QuestionImportItem("JAVA-001", "Java Basics", "", "easy",
                        List.of("Paris", "London", "Berlin", "Madrid"), 0, "The capital of France is Paris.")
        );

        // Act & Assert
        assertThatThrownBy(() -> new ImportQuestionsRequest(certificationId, questions))
                .isInstanceOf(ConstraintViolationException.class);
    }

    @DisplayName("should reject question with null statement")
    @Test
    public void createValidImportQuestionsRequest_nullStatement_failure() {
        // Arrange
        String certificationId = "CERT-001";
        List<QuestionImportItem> questions = List.of(
                new QuestionImportItem("JAVA-001", "Java Basics", null, "easy",
                        List.of("Paris", "London", "Berlin", "Madrid"), 0, "The capital of France is Paris.")
        );

        // Act & Assert
        assertThatThrownBy(() -> new ImportQuestionsRequest(certificationId, questions))
                .isInstanceOf(ConstraintViolationException.class);
    }

    @DisplayName("should reject question with incorrect difficulty level")
    @Test
    public void createValidImportQuestionsRequest_incorrectDifficulty_failure() {
        // Arrange
        String certificationId = "CERT-001";
        List<QuestionImportItem> questions = List.of(
                new QuestionImportItem("JAVA-001", "Java Basics", "What is the capital of France?", "medium",
                        List.of("Paris", "London", "Berlin", "Madrid"), 0, "The capital of France is Paris.")
        );

        // Act & Assert
        assertThatThrownBy(() -> new ImportQuestionsRequest(certificationId, questions))
                .isInstanceOf(ConstraintViolationException.class);
    }

    @DisplayName("should reject question with null options list")
    @Test
    public void createValidImportQuestionsRequest_nullOptionsList_failure() {
        // Arrange
        String certificationId = "CERT-001";
        List<QuestionImportItem> questions = List.of(
                new QuestionImportItem("JAVA-001", "Java Basics", "What is the capital of France?", "easy",
                        null, 0, "The capital of France is Paris.")
        );

        // Act & Assert
        assertThatThrownBy(() -> new ImportQuestionsRequest(certificationId, questions))
                .isInstanceOf(ConstraintViolationException.class);
    }

    @DisplayName("should reject question with options list containing less than 2 items")
    @Test
    public void createValidImportQuestionsRequest_optionsListTooShort_failure() {
        // Arrange
        String certificationId = "CERT-001";
        List<QuestionImportItem> questions = List.of(
                new QuestionImportItem("JAVA-001", "Java Basics", "What is the capital of France?", "easy",
                        List.of("Paris"), 0, "The capital of France is Paris.")
        );

        // Act & Assert
        assertThatThrownBy(() -> new ImportQuestionsRequest(certificationId, questions))
                .isInstanceOf(ConstraintViolationException.class);
    }

    @DisplayName("should reject question with options list containing more than 5 items")
    @Test
    public void createValidImportQuestionsRequest_optionsListTooLong_failure() {
        // Arrange
        String certificationId = "CERT-001";
        List<QuestionImportItem> questions = List.of(
                new QuestionImportItem("JAVA-001", "Java Basics", "What is the capital of France?", "easy",
                        List.of("Paris", "London", "Berlin", "Madrid", "Tokyo", "Sydney"), 0, "The capital of France is Paris.")
        );

        // Act & Assert
        assertThatThrownBy(() -> new ImportQuestionsRequest(certificationId, questions))
                .isInstanceOf(ConstraintViolationException.class);
    }

    @DisplayName("should reject question with negative correctIndex")
    @Test
    public void createValidImportQuestionsRequest_negativeCorrectIndex_failure() {
        // Arrange
        String certificationId = "CERT-001";
        List<QuestionImportItem> questions = List.of(
                new QuestionImportItem("JAVA-001", "Java Basics", "What is the capital of France?", "easy",
                        List.of("Paris", "London", "Berlin", "Madrid"), -1, "The capital of France is Paris.")
        );

        // Act & Assert
        assertThatThrownBy(() -> new ImportQuestionsRequest(certificationId, questions))
                .isInstanceOf(ConstraintViolationException.class);
    }

    @DisplayName("should reject question with correctIndex greater than options size")
    @Test
    public void createValidImportQuestionsRequest_correctIndexTooHigh_failure() {
        // Arrange
        String certificationId = "CERT-001";
        List<QuestionImportItem> questions = List.of(
                new QuestionImportItem("JAVA-001", "Java Basics", "What is the capital of France?", "easy",
                        List.of("Paris", "London"), 2, "The capital of France is Paris.")
        );

        // Act & Assert
        assertThatThrownBy(() -> new ImportQuestionsRequest(certificationId, questions))
                .isInstanceOf(ConstraintViolationException.class);
    }
}

