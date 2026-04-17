package com.certifapp.infrastructure.persistence.entity;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.testcontainers.context.SpringBootTestContextInitializer;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;

import java.time.OffsetDateTime;

import static org.assertj.core.api.Assertions.assertThat;

@DataJpaTest
@ContextConfiguration(initializers = SpringJUnitConfig.Initializer.class)
@SpringBootTestContextInitializer
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)
public class FlashcardEntityTest {

    @BeforeEach
    public void setUp() {
        flashcardEntity.setCreatedAt(OffsetDateTime.now());
    }

    @DisplayName("FlashcardEntity_initialization_nominalCase")
    @Test
    public void testInitializationNominalCase() {
        // Nominal case: Check default values are set correctly
        assertThat(flashcardEntity.getId()).isNull();
        assertThat(flashcardEntity.getQuestionId()).isNull();
        assertThat(flashcardEntity.getCourseId()).isNull();
        assertThat(flashcardEntity.getFrontText()).isNull();
        assertThat(flashcardEntity.getBackText()).isNull();
        assertThat(flashcardEntity.getCodeExample()).isNull();
        assertThat(flashcardEntity.isAiGenerated()).isFalse();
        assertThat(flashcardEntity.getCreatedAt()).isNotNull();
    }

    @DisplayName("FlashcardEntity_initialization_edgeCase_nullFrontText")
    @Test
    public void testInitializationEdgeCaseNullFrontText() {
        // Edge case: Front text is null
        flashcardEntity.setFrontText(null);
        assertThat(flashcardEntity.getFrontText()).isNull();
    }

    @DisplayName("FlashcardEntity_initialization_edgeCase_emptyBackText")
    @Test
    public void testInitializationEdgeCaseEmptyBackText() {
        // Edge case: Back text is empty
        flashcardEntity.setBackText("");
        assertThat(flashcardEntity.getBackText()).isEmpty();
    }

    @DisplayName("FlashcardEntity_initialization_errorCase_nullCourseId")
    @Test
    public void testInitializationErrorCaseNullCourseId() {
        // Error case: Course ID is null (should throw an exception)
        flashcardEntity.setCourseId(null);
        assertThat(flashcardEntity.getCourseId()).isNull();
    }

    @DisplayName("FlashcardEntity_setCreatedAt_nominalCase")
    @Test
    public void testSetCreatedAtNominalCase() {
        // Nominal case: Set created at to a new value
        OffsetDateTime newCreatedAt = OffsetDateTime.now().plusDays(1);
        flashcardEntity.setCreatedAt(newCreatedAt);
        assertThat(flashcardEntity.getCreatedAt()).isEqualTo(newCreatedAt);
    }

    @DisplayName("FlashcardEntity_setAiGenerated_nominalCase")
    @Test
    public void testSetAiGeneratedNominalCase() {
        // Nominal case: Set aiGenerated to true
        flashcardEntity.setAiGenerated(true);
        assertThat(flashcardEntity.isAiGenerated()).isTrue();
    }
}