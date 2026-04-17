package com.certifapp.domain.model.user;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class UiThemeTest {

    @InjectMocks
    private UiTheme uiTheme;

    @BeforeEach
    public void setUp() {
        // No setup needed for this enum
    }

    @DisplayName("UiTheme_light_getName_returnsLight")
    @Test
    public void light_getName_returnsLight() {
        assertThat(uiTheme.LIGHT.getName()).isEqualTo("LIGHT");
    }

    @DisplayName("UiTheme_dark_getName_returnsDark")
    @Test
    public void dark_getName_returnsDark() {
        assertThat(uiTheme.DARK.getName()).isEqualTo("DARK");
    }

    @DisplayName("UiTheme_system_getName_returnsSYSTEM")
    @Test
    public void system_getName_returnsSYSTEM() {
        assertThat(uiTheme.SYSTEM.getName()).isEqualTo("SYSTEM");
    }
}

