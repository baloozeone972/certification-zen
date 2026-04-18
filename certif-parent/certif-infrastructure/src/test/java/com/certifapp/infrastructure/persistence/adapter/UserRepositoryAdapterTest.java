package com.certifapp.infrastructure.persistence.adapter;

import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class UserRepositoryAdapterTest {

    @Mock
    private UserJpaRepository jpaRepository;

    @Mock
    private UserMapper mapper;

    @InjectMocks
    private UserRepositoryAdapter userRepositoryAdapter;

    @BeforeEach
    public void setUp() {
        // Setup mocks if needed
    }

    @Test
    @DisplayName("findById_nominal_case")
    public void findById_nominal_case() {
        UUID id = UUID.randomUUID();
        UserEntity userEntity = new UserEntity();
        User user = new User();

        when(jpaRepository.findById(id)).thenReturn(Optional.of(userEntity));
        when(mapper.toDomain(userEntity)).thenReturn(user);

        Optional<User> result = userRepositoryAdapter.findById(id);

        assertThat(result).isPresent();
        assertThat(result.get()).isEqualTo(user);
        verify(jpaRepository, times(1)).findById(id);
        verify(mapper, times(1)).toDomain(userEntity);
    }

    @Test
    @DisplayName("findById_edge_case_not_found")
    public void findById_edge_case_not_found() {
        UUID id = UUID.randomUUID();

        when(jpaRepository.findById(id)).thenReturn(Optional.empty());

        Optional<User> result = userRepositoryAdapter.findById(id);

        assertThat(result).isNotPresent();
        verify(jpaRepository, times(1)).findById(id);
    }

    @Test
    @DisplayName("findByEmail_nominal_case")
    public void findByEmail_nominal_case() {
        String email = "test@example.com";
        UserEntity userEntity = new UserEntity();
        User user = new User();

        when(jpaRepository.findByEmail(email)).thenReturn(Optional.of(userEntity));
        when(mapper.toDomain(userEntity)).thenReturn(user);

        Optional<User> result = userRepositoryAdapter.findByEmail(email);

        assertThat(result).isPresent();
        assertThat(result.get()).isEqualTo(user);
        verify(jpaRepository, times(1)).findByEmail(email);
        verify(mapper, times(1)).toDomain(userEntity);
    }

    @Test
    @DisplayName("findByEmail_edge_case_not_found")
    public void findByEmail_edge_case_not_found() {
        String email = "test@example.com";

        when(jpaRepository.findByEmail(email)).thenReturn(Optional.empty());

        Optional<User> result = userRepositoryAdapter.findByEmail(email);

        assertThat(result).isNotPresent();
        verify(jpaRepository, times(1)).findByEmail(email);
    }

    @Test
    @DisplayName("existsByEmail_nominal_case")
    public void existsByEmail_nominal_case() {
        String email = "test@example.com";

        when(jpaRepository.existsByEmail(email)).thenReturn(true);

        boolean result = userRepositoryAdapter.existsByEmail(email);

        assertThat(result).isTrue();
        verify(jpaRepository, times(1)).existsByEmail(email);
    }

    @Test
    @DisplayName("existsByEmail_edge_case_not_found")
    public void existsByEmail_edge_case_not_found() {
        String email = "test@example.com";

        when(jpaRepository.existsByEmail(email)).thenReturn(false);

        boolean result = userRepositoryAdapter.existsByEmail(email);

        assertThat(result).isFalse();
        verify(jpaRepository, times(1)).existsByEmail(email);
    }

    @Test
    @DisplayName("save_nominal_case")
    public void save_nominal_case() {
        User user = new User();
        UserEntity userEntity = new UserEntity();

        when(mapper.toEntity(user)).thenReturn(userEntity);
        when(jpaRepository.save(userEntity)).thenReturn(userEntity);
        when(mapper.toDomain(userEntity)).thenReturn(user);

        User savedUser = userRepositoryAdapter.save(user);

        assertThat(savedUser).isEqualTo(user);
        verify(mapper, times(1)).toEntity(user);
        verify(jpaRepository, times(1)).save(userEntity);
        verify(mapper, times(1)).toDomain(userEntity);
    }

    @Test
    @DisplayName("deleteById_nominal_case")
    public void deleteById_nominal_case() {
        UUID id = UUID.randomUUID();

        userRepositoryAdapter.deleteById(id);

        verify(jpaRepository, times(1)).deleteById(id);
    }
}
