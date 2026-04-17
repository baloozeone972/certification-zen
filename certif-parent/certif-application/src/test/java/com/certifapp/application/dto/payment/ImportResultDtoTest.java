package com.certifapp.application.dto.payment;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.assertj.core.api.Assertions.assertThat;

@ExtendWith(MockitoExtension.class)
public class ImportResultDtoTest {

    @InjectMocks
    private ImportResultDto importResultDto;

    @BeforeEach
    public void setUp() {
        importResultDto = new ImportResultDto(0, 0, null);
    }

    @Test
    @DisplayName("should create an instance with default values")
    public void constructor_defaultValues_validInstance() {
        assertThat(importResultDto).isNotNull();
        assertThat(importResultDto.imported()).isEqualTo(0);
        assertThat(importResultDto.skipped()).isEqualTo(0);
        assertThat(importResultDto.errors()).isNull();
    }

    @Test
    @DisplayName("should create an instance with custom values")
    public void constructor_customValues_validInstance() {
        importResultDto = new ImportResultDto(5, 2, List.of("Error1", "Error2"));

        assertThat(importResultDto).isNotNull();
        assertThat(importResultDto.imported()).isEqualTo(5);
        assertThat(importResultDto.skipped()).isEqualTo(2);
        assertThat(importResultDto.errors()).hasSize(2);
    }

    @Test
    @DisplayName("should return the number of imported questions")
    public void imported_getter_validValue() {
        importResultDto = new ImportResultDto(3, 0, null);

        assertThat(importResultDto.imported()).isEqualTo(3);
    }

    @Test
    @DisplayName("should return the number of skipped questions")
    public void skipped_getter_validValue() {
        importResultDto = new ImportResultDto(0, 4, List.of());

        assertThat(importResultDto.skipped()).isEqualTo(4);
    }

    @Test
    @DisplayName("should return the list of error messages")
    public void errors_getter_validList() {
        importResultDto = new ImportResultDto(0, 0, List.of("Error1", "Error2"));

        assertThat(importResultDto.errors()).hasSize(2);
        assertThat(importResultDto.errors().get(0)).isEqualTo("Error1");
        assertThat(importResultDto.errors().get(1)).isEqualTo("Error2");
    }
}

