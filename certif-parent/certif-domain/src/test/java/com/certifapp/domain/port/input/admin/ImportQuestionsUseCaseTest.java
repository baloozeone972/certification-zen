package com.certifapp.domain.port.input.admin;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.List;
import java.util.UUID;

public class ImportQuestionsUseCaseTest {

    @DisplayName("nominal case: successfully imports questions")
    @Test
    public void execute_nominal_case_successfully_imports_questions() {
        String certificationId = "cert123";
        List<Question> questions = List.of(new Question("q1", "a1"), new Question("q2", "a2"));
        UUID adminId = UUID.randomUUID();

        ImportResult importResult = new ImportQuestionsUseCase().execute(certificationId, questions, adminId);

        assertThat(importResult.imported()).isEqualTo(2);
        assertThat(importResult.skipped()).isEqualTo(0);
        assertThat(importResult.errors()).isEmpty();
    }

    @DisplayName("edge case: empty list of questions")
    @Test
    public void execute_edge_case_empty_list_of_questions() {
        String certificationId = "cert123";
        List<Question> questions = List.of();
        UUID adminId = UUID.randomUUID();

        ImportResult importResult = new ImportQuestionsUseCase().execute(certificationId, questions, adminId);

        assertThat(importResult.imported()).isEqualTo(0);
        assertThat(importResult.skipped()).isEqualTo(0);
        assertThat(importResult.errors()).isEmpty();
    }

    @DisplayName("error case: repository throws exception during save")
    @Test
    public void execute_error_case_repository_throws_exception_during_save() {
        String certificationId = "cert123";
        List<Question> questions = List.of(new Question("q1", "a1"), new Question("q2", "a2"));
        UUID adminId = UUID.randomUUID();

        ImportResult importResult = new ImportQuestionsUseCase().execute(certificationId, questions, adminId);

        assertThat(importResult.imported()).isEqualTo(0);
        assertThat(importResult.skipped()).isEqualTo(2);
        assertThat(importResult.errors()).hasSize(2);
    }
}