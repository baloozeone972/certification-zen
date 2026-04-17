package com.certifapp.infrastructure.persistence.repository;

import com.certifapp.infrastructure.persistence.entity.ExamSessionEntity;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;

import java.time.OffsetDateTime;
import java.util.Collections;
import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class ExamSessionJpaRepositoryTest {

    @Mock
    private ExamSessionEntity examSessionEntity;

    @InjectMocks
    private ExamSessionJpaRepositoryImpl examSessionJpaRepository;

    @BeforeEach
    public void setUp() {
        // Set up any initial configurations or mocks here if needed
    }

    @DisplayName("Count today's exam sessions by user and certification - Nominal case")
    @Test
    public void countTodayByUserAndCertification_nominalCase() {
        UUID userId = UUID.randomUUID();
        String certId = "cert123";
        String mode = "testMode";
        OffsetDateTime startOfDay = OffsetDateTime.now().withNano(0);

        when(examSessionEntityRepository.countTodayByUserAndCertification(userId, certId, mode, startOfDay)).thenReturn(5);

        int count = examSessionJpaRepository.countTodayByUserAndCertification(userId, certId, mode, startOfDay);
        assertThat(count).isEqualTo(5);

        verify(examSessionEntityRepository, times(1))
                .countTodayByUserAndCertification(userId, certId, mode, startOfDay);
    }

    @DisplayName("Count today's exam sessions by user and certification - Edge case with zero count")
    @Test
    public void countTodayByUserAndCertification_edgeCaseZeroCount() {
        UUID userId = UUID.randomUUID();
        String certId = "cert123";
        String mode = "testMode";
        OffsetDateTime startOfDay = OffsetDateTime.now().withNano(0);

        when(examSessionEntityRepository.countTodayByUserAndCertification(userId, certId, mode, startOfDay)).thenReturn(0);

        int count = examSessionJpaRepository.countTodayByUserAndCertification(userId, certId, mode, startOfDay);
        assertThat(count).isEqualTo(0);

        verify(examSessionEntityRepository, times(1))
                .countTodayByUserAndCertification(userId, certId, mode, startOfDay);
    }

    @DisplayName("Find exam sessions by user with filters - Nominal case")
    @Test
    public void findByUserIdWithFilters_nominalCase() {
        UUID userId = UUID.randomUUID();
        String certId = "cert123";
        String mode = "testMode";
        OffsetDateTime from = OffsetDateTime.now().withNano(0);
        OffsetDateTime to = OffsetDateTime.now().plusHours(1).withNano(0);
        Pageable pageable = mock(Pageable.class);

        ExamSessionEntity sessionEntity1 = new ExamSessionEntity();
        ExamSessionEntity sessionEntity2 = new ExamSessionEntity();

        when(examSessionEntityRepository.findByUserIdWithFilters(userId, certId, mode, from, to, pageable))
                .thenReturn(new PageImpl<>(List.of(sessionEntity1, sessionEntity2)));

        Page<ExamSessionEntity> sessions = examSessionJpaRepository.findByUserIdWithFilters(userId, certId, mode, from, to, pageable);
        assertThat(sessions.getContent()).hasSize(2);

        verify(examSessionEntityRepository, times(1))
                .findByUserIdWithFilters(userId, certId, mode, from, to, pageable);
    }

    @DisplayName("Find exam sessions by user with filters - Edge case with no results")
    @Test
    public void findByUserIdWithFilters_edgeCaseNoResults() {
        UUID userId = UUID.randomUUID();
        String certId = "cert123";
        String mode = "testMode";
        OffsetDateTime from = OffsetDateTime.now().withNano(0);
        OffsetDateTime to = OffsetDateTime.now().plusHours(1).withNano(0);
        Pageable pageable = mock(Pageable.class);

        when(examSessionEntityRepository.findByUserIdWithFilters(userId, certId, mode, from, to, pageable))
                .thenReturn(new PageImpl<>(Collections.emptyList()));

        Page<ExamSessionEntity> sessions = examSessionJpaRepository.findByUserIdWithFilters(userId, certId, mode, from, to, pageable);
        assertThat(sessions.getContent()).isEmpty();

        verify(examSessionEntityRepository, times(1))
                .findByUserIdWithFilters(userId, certId, mode, from, to, pageable);
    }

    @DisplayName("Find exam sessions by user with filters - Error case with invalid pageable")
    @Test
    public void findByUserIdWithFilters_errorCaseInvalidPageable() {
        UUID userId = UUID.randomUUID();
        String certId = "cert123";
        String mode = "testMode";
        OffsetDateTime from = OffsetDateTime.now().withNano(0);
        OffsetDateTime to = OffsetDateTime.now().plusHours(1).withNano(0);
        Pageable pageable = mock(Pageable.class);

        when(pageable.getPageNumber()).thenReturn(-1); // Invalid page number

        Exception exception = assertThrows(IllegalArgumentException.class, () -> {
            examSessionJpaRepository.findByUserIdWithFilters(userId, certId, mode, from, to, pageable);
        });

        assertThat(exception.getMessage()).contains("Invalid page index: -1");

        verify(examSessionEntityRepository, never())
                .findByUserIdWithFilters(any(UUID.class), any(String.class), any(String.class), any(OffsetDateTime.class), any(OffsetDateTime.class), any(Pageable.class));
    }
}
