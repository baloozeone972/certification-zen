package com.certifapp.infrastructure.persistence.mapper;

import com.certifapp.domain.model.session.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class ExamSessionMapperTest {

    @Mock
    private UserAnswerMapper userAnswerMapper;

    @InjectMocks
    private ExamSessionMapper examSessionMapper;

    @BeforeEach
    public void setUp() {
        // Setup any necessary mocks or configurations here
    }

    @Test
    @DisplayName("toDomain_nominalCase")
    public void toDomain_nominalCase() {
        // Arrange
        ExamSessionEntity entity = new ExamSessionEntity();
        entity.setMode("ONLINE");
        entity.setStatus("ACTIVE");

        when(userAnswerMapper.toDomain(anyList())).thenReturn(List.of(new UserAnswer()));

        // Act
        ExamSession result = examSessionMapper.toDomain(entity);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.mode()).isEqualTo(ExamMode.ONLINE);
        assertThat(result.status()).isEqualTo(SessionStatus.ACTIVE);
        verify(userAnswerMapper, never()).toDomain(anyList());
    }

    @Test
    @DisplayName("toDomain_emptyAnswers")
    public void toDomain_emptyAnswers() {
        // Arrange
        ExamSessionEntity entity = new ExamSessionEntity();
        entity.setMode("ONLINE");
        entity.setStatus("ACTIVE");

        when(userAnswerMapper.toDomain(anyList())).thenReturn(List.of());

        // Act
        ExamSession result = examSessionMapper.toDomain(entity);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.mode()).isEqualTo(ExamMode.ONLINE);
        assertThat(result.status()).isEqualTo(SessionStatus.ACTIVE);
        verify(userAnswerMapper, never()).toDomain(anyList());
    }

    @Test
    @DisplayName("toEntity_nominalCase")
    public void toEntity_nominalCase() {
        // Arrange
        ExamSession domain = new ExamSession(ExamMode.ONLINE, SessionStatus.ACTIVE);

        // Act
        ExamSessionEntity result = examSessionMapper.toEntity(domain);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.getMode()).isEqualTo("ONLINE");
        assertThat(result.getStatus()).isEqualTo("ACTIVE");
    }

    @Test
    @DisplayName("toDomainAnswerList_nominalCase")
    public void toDomainAnswerList_nominalCase() {
        // Arrange
        List<UserAnswerEntity> entities = List.of(new UserAnswerEntity());

        when(userAnswerMapper.toDomain(any(UserAnswerEntity.class))).thenReturn(new UserAnswer());

        // Act
        List<UserAnswer> result = examSessionMapper.toDomainAnswerList(entities);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.size()).isEqualTo(1);
        verify(userAnswerMapper, times(1)).toDomain(any(UserAnswerEntity.class));
    }
}
