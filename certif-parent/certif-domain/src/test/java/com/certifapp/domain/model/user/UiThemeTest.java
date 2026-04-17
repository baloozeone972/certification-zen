package com.certifapp.domain.model.user;

import static org.assertj.core.api.Assertions.assertThat;

public class UiThemeTest {

    @DisplayName("UiTheme_light_getName_returnsLight")
    @Test
    public void light_getName_returnsLight() {
        assertThat(UiTheme.LIGHT.getName()).isEqualTo("LIGHT");
    }

    @DisplayName("UiTheme_dark_getName_returnsDark")
    @Test
    public void dark_getName_returnsDark() {
        assertThat(UiTheme.DARK.getName()).isEqualTo("DARK");
    }

    @DisplayName("UiTheme_system_getName_returnsSYSTEM")
    @Test
    public void system_getName_returnsSYSTEM() {
        assertThat(UiTheme.SYSTEM.getName()).isEqualTo("SYSTEM");
    }
}