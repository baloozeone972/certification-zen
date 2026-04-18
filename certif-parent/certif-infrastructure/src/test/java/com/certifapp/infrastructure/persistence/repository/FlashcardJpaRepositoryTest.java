package com.certifapp.infrastructure.persistence.repository;

import com.certifapp.infrastructure.persistence.entity.FlashcardEntity;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class FlashcardJpaRepositoryTest {

    @Mock
    private JpaRepository<FlashcardEntity, UUID> jpaRepository;

    @InjectMocks
    private FlashcardJpaRepository flashcardJpaRepository;

    @BeforeEach
    public void setUp() {
        // Setup any initial configurations or mocks if needed
    }

    @DisplayName("Should find due flashcards for a user and certification")
    @Test
    public void findDueByUserAndCertification_nominalCase() {
        UUID userId = UUID.randomUUID();
        String certId = "cert123";
        LocalDate today = LocalDate.now();

        List<FlashcardEntity> expectedFlashcards = Arrays.asList(
                FlashcardEntity.builder().id(UUID.randomUUID()).build(),
                FlashcardEntity.builder().id(UUID.randomUUID()).build()
        );

        when(jpaRepository.findAll(any())).thenReturn(expectedFlashcards);

        List<FlashcardEntity> actualFlashcards = flashcardJpaRepository.findDueByUserAndCertification(userId, certId, today, null);

        assertThat(actualFlashcards).isEqualTo(expectedFlashcards);
        verify(jpaRepository, times(1)).findAll(any());
    }

    @DisplayName("Should return empty list if no due flashcards are found")
    @Test
    public void findDueByUserAndCertification_noDueFlashcards() {
        UUID userId = UUID.randomUUID();
        String certId = "cert123";
        LocalDate today = LocalDate.now();

        when(jpaRepository.findAll(any())).thenReturn(Arrays.asList());

        List<FlashcardEntity> actualFlashcards = flashcardJpaRepository.findDueByUserAndCertification(userId, certId, today, null);

        assertThat(actualFlashcards).isEmpty();
        verify(jpaRepository, times(1)).findAll(any());
    }

    @DisplayName("Should throw exception if repository throws exception")
    @Test
    public void findDueByUserAndCertification_repositoryException() {
        UUID userId = UUID.randomUUID();
        String certId = "cert123";
        LocalDate today = LocalDate.now();

        when(jpaRepository.findAll(any())).thenThrow(new RuntimeException("Mocked Exception"));

        assertThatThrownBy(() -> flashcardJpaRepository.findDueByUserAndCertification(userId, certId, today, null))
                .isInstanceOf(RuntimeException.class)
                .hasMessage("Mocked Exception");

        verify(jpaRepository, times(1)).findAll(any());
    }

    @DisplayName("Should find due flashcards with pagination")
    @Test
    public void findDueByUserAndCertification_pagination() {
        UUID userId = UUID.randomUUID();
        String certId = "cert123";
        LocalDate today = LocalDate.now();

        List<FlashcardEntity> expectedFlashcards = Arrays.asList(
                FlashcardEntity.builder().id(UUID.randomUUID()).build(),
                FlashcardEntity.builder().id(UUID.randomUUID()).build()
        );

        Pageable pageable = mock(Pageable.class);

        when(jpaRepository.findAll(any())).thenReturn(expectedFlashcards);

        List<FlashcardEntity> actualFlashcards = flashcardJpaRepository.findDueByUserAndCertification(userId, certId, today, pageable);

        assertThat(actualFlashcards).isEqualTo(expectedFlashcards);
        verify(jpaRepository, times(1)).findAll(any());
    }
}

