package com.certifapp.application.dto.session;

import java.util.UUID;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class UserProgressDtoTest {

    @Mock
    private Map<String, Double> progressByTheme;

    @InjectMocks
    private UserProgressDto userProgressDto;

    @BeforeEach
    public void setUp() {
        userProgressDto = new UserProgressDto(
                UUID.randomUUID(),
                "certificationId",
                5,
                90.0,
                85.0,
                75.0,
                progressByTheme
        );
    }

    @Test
    @DisplayName("Constructor initializes with correct values")
    public void constructor_initializesWithCorrectValues() {
        assertThat(userProgressDto.userId()).isNotNull();
        assertThat(userProgressDto.certificationId()).isEqualTo("certificationId");
        assertThat(userProgressDto.totalSessions()).isEqualTo(5);
        assertThat(userProgressDto.bestScore()).isEqualTo(90.0);
        assertThat(userProgressDto.averageScore()).isEqualTo(85.0);
        assertThat(userProgressDto.passRate()).isEqualTo(75.0);
        assertThat(userProgressDto.progressByTheme()).isSameAs(progressByTheme);
    }

    @Test
    @DisplayName("Default constructor initializes with null values")
    public void defaultConstructor_initializesWithNullValues() {
        UserProgressDto dto = new UserProgressDto();
        assertThat(dto.userId()).isNull();
        assertThat(dto.certificationId()).isNull();
        assertThat(dto.totalSessions()).isEqualTo(0);
        assertThat(dto.bestScore()).isEqualTo(0.0);
        assertThat(dto.averageScore()).isEqualTo(0.0);
        assertThat(dto.passRate()).isEqualTo(0.0);
        assertThat(dto.progressByTheme()).isNull();
    }

    @Test
    @DisplayName("Constructor throws NullPointerException if userId is null")
    public void constructor_throwsNullPointerExceptionIfUserIdIsNull() {
        Exception exception = assertThrows(NullPointerException.class, () -> 
            new UserProgressDto(
                null,
                "certificationId",
                5,
                90.0,
                85.0,
                75.0,
                progressByTheme
            )
        );
        assertThat(exception.getMessage()).isEqualTo("userId is marked non-null but is null");
    }

    @Test
    @DisplayName("Constructor throws NullPointerException if certificationId is null")
    public void constructor_throwsNullPointerExceptionIfCertificationIdIsNull() {
        Exception exception = assertThrows(NullPointerException.class, () -> 
            new UserProgressDto(
                UUID.randomUUID(),
                null,
                5,
                90.0,
                85.0,
                75.0,
                progressByTheme
            )
        );
        assertThat(exception.getMessage()).isEqualTo("certificationId is marked non-null but is null");
    }

    @Test
    @DisplayName("Constructor throws NullPointerException if progressByTheme is null")
    public void constructor_throwsNullPointerExceptionIfProgressByThemeIsNull() {
        Exception exception = assertThrows(NullPointerException.class, () -> 
            new UserProgressDto(
                UUID.randomUUID(),
                "certificationId",
                5,
                90.0,
                85.0,
                75.0,
                null
            )
        );
        assertThat(exception.getMessage()).isEqualTo("progressByTheme is marked non-null but is null");
    }

}
