package com.certifapp.api.security;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(SpringExtension.class)
public class SecurityConfigTest {

    @Mock
    private JwtAuthenticationFilter jwtFilter;

    @InjectMocks
    private SecurityConfig securityConfig;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @DisplayName("Should configure filter chain with correct settings")
    @Test
    public void configure_filterChain_withCorrectSettings() throws Exception {
        HttpSecurity http = mock(HttpSecurity.class);

        when(http.sessionManagement(any())).thenReturn(http);
        when(http.csrf(any(AbstractHttpConfigurer.class))).thenReturn(http);
        when(http.cors()).thenReturn(http);
        when(http.authorizeHttpRequests()).thenReturn(http);
        when(http.addFilterBefore(any(UsernamePasswordAuthenticationFilter.class), eq(UsernamePasswordAuthenticationFilter.class))).thenReturn(http);

        SecurityFilterChain filterChain = securityConfig.filterChain(http);

        assertThat(filterChain).isNotNull();
        verify(http).sessionManagement(any());
        verify(http).csrf(AbstractHttpConfigurer::disable);
        verify(http).cors();
        verify(http).authorizeHttpRequests();
        verify(http).addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class);
    }

    @DisplayName("Should configure CORS with correct settings")
    @Test
    public void configure_corsConfigurationSource_withCorrectSettings() {
        CorsConfigurationSource corsConfigSource = securityConfig.corsConfigurationSource();

        assertThat(corsConfigSource).isNotNull();
        CorsConfiguration config = corsConfigSource.getCorsConfiguration(new org.springframework.mock.web.MockHttpServletRequest());
        assertThat(config.getAllowedOriginPatterns()).containsExactly("http://localhost:4200", "https://certifapp.com", "https://*.certifapp.com");
        assertThat(config.getAllowedMethods()).containsExactly("GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS");
        assertThat(config.getAllowedHeaders()).containsExactly("Authorization", "Content-Type", "Accept", "X-Requested-With");
        assertThat(config.getExposedHeaders()).containsExactly("Authorization");
        assertThat(config.isAllowCredentials()).isTrue();
        assertThat(config.getMaxAge()).isEqualTo(3600L);
    }

    @DisplayName("Should configure password encoder with BCryptPasswordEncoder")
    @Test
    public void configure_passwordEncoder_withBCryptPasswordEncoder() {
        PasswordEncoder passwordEncoder = securityConfig.passwordEncoder();

        assertThat(passwordEncoder).isNotNull();
        assertThat(passwordEncoder instanceof BCryptPasswordEncoder).isTrue();
        assertThat(((BCryptPasswordEncoder) passwordEncoder).getStrength()).isEqualTo(12);
    }
}
