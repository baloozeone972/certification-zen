package com.certifapp.infrastructure.persistence.adapter;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class UserPreferencesRepositoryAdapterTest {

    @Mock
    private UserPreferencesJpaRepository jpaRepository;

    @Mock
    private UserMapper mapper;

    @InjectMocks
    private UserPreferencesRepositoryAdapter repositoryAdapter;

    @BeforeEach
    public void setUp() {
        // Setup if needed
    }

    @DisplayName("findByUserId_nominalCase_successfullyRetrievesUserPreferences")
    @Test
    public void findByUserId_nominalCase_successfullyRetrievesUserPreferences() {
        UUID userId = UUID.randomUUID();
        UserPreferencesJpaEntity entity = new UserPreferencesJpaEntity();
        UserPreferences domainObject = new UserPreferences();

        when(jpaRepository.findById(userId)).thenReturn(Optional.of(entity));
        when(mapper.toDomain(entity)).thenReturn(domainObject);

        Optional<UserPreferences> result = repositoryAdapter.findByUserId(userId);

        assertThat(result).isPresent().containsSame(domainObject);
        verify(jpaRepository, times(1)).findById(userId);
        verify(mapper, times(1)).toDomain(entity);
    }

    @DisplayName("findByUserId_edgeCase_emptyOptionalWhenNoUserFound")
    @Test
    public void findByUserId_edgeCase_emptyOptionalWhenNoUserFound() {
        UUID userId = UUID.randomUUID();

        when(jpaRepository.findById(userId)).thenReturn(Optional.empty());

        Optional<UserPreferences> result = repositoryAdapter.findByUserId(userId);

        assertThat(result).isEmpty();
        verify(jpaRepository, times(1)).findById(userId);
        verify(mapper, never()).toDomain(any());
    }

    @DisplayName("save_nominalCase_successfullySavesUserPreferences")
    @Test
    public void save_nominalCase_successfullySavesUserPreferences() {
        UserPreferences preferences = new UserPreferences();
        UserPreferencesJpaEntity entity = new UserPreferencesJpaEntity();

        when(mapper.toEntity(preferences)).thenReturn(entity);
        when(jpaRepository.save(entity)).thenReturn(entity);
        when(mapper.toDomain(entity)).thenReturn(preferences);

        UserPreferences savedPreferences = repositoryAdapter.save(preferences);

        assertThat(savedPreferences).isSameAs(preferences);
        verify(mapper, times(1)).toEntity(preferences);
        verify(jpaRepository, times(1)).save(entity);
        verify(mapper, times(1)).toDomain(entity);
    }

    @DisplayName("save_errorCase_throwsExceptionWhenJpaThrowsException")
    @Test
    public void save_errorCase_throwsExceptionWhenJpaThrowsException() {
        UserPreferences preferences = new UserPreferences();
        UserPreferencesJpaEntity entity = new UserPreferencesJpaEntity();

        when(mapper.toEntity(preferences)).thenReturn(entity);
        doThrow(new RuntimeException("JPA exception")).when(jpaRepository).save(entity);

        assertThatThrownBy(() -> repositoryAdapter.save(preferences))
                .isInstanceOf(RuntimeException.class)
                .hasMessage("JPA exception");

        verify(mapper, times(1)).toEntity(preferences);
        verify(jpaRepository, times(1)).save(entity);
    }
}

