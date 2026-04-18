package com.certifapp.api.dto.request;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

@WebMvcTest(UpdatePreferencesController.class)
@ExtendWith(MockitoExtension.class)
public class UpdatePreferencesRequestTest {

    @InjectMocks
    private UpdatePreferencesController updatePreferencesController;

    @Mock
    private PreferencesService preferencesService;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
        Authentication authentication = mock(Authentication.class);
        SecurityContext securityContext = mock(SecurityContext.class);
        when(securityContext.getAuthentication()).thenReturn(authentication);
        SecurityContextHolder.setContext(securityContext);
    }

    @Test
    @DisplayName("Should update preferences with valid request")
    public void shouldUpdatePreferencesWithValidRequest() throws Exception {
        String theme = "light";
        String language = "en-US";
        String defaultMode = "EXAM";
        Boolean notificationsEnabled = true;

        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.put("/api/preferences")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"theme\":\"" + theme + "\",\"language\":\"" + language + "\",\"defaultMode\":\"" + defaultMode + "\",\"notificationsEnabled\":" + notificationsEnabled + "}")
                        .header("Authorization", "Bearer token"))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andReturn();

        Assertions.assertThat(result.getResponse().getContentAsString()).contains("\"theme\":\"" + theme + "\"");
    }

    @Test
    @DisplayName("Should return 400 Bad Request for invalid theme value")
    public void shouldReturn400BadRequestForInvalidThemeValue() throws Exception {
        String theme = "invalid";
        String language = "en-US";
        String defaultMode = "EXAM";
        Boolean notificationsEnabled = true;

        mockMvc.perform(MockMvcRequestBuilders.put("/api/preferences")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"theme\":\"" + theme + "\",\"language\":\"" + language + "\",\"defaultMode\":\"" + defaultMode + "\",\"notificationsEnabled\":" + notificationsEnabled + "}")
                        .header("Authorization", "Bearer token"))
                .andExpect(MockMvcResultMatchers.status().isBadRequest());
    }

    @Test
    @DisplayName("Should return 400 Bad Request for invalid defaultMode value")
    public void shouldReturn400BadRequestForInvalidDefaultModeValue() throws Exception {
        String theme = "light";
        String language = "en-US";
        String defaultMode = "INVALID";
        Boolean notificationsEnabled = true;

        mockMvc.perform(MockMvcRequestBuilders.put("/api/preferences")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"theme\":\"" + theme + "\",\"language\":\"" + language + "\",\"defaultMode\":\"" + defaultMode + "\",\"notificationsEnabled\":" + notificationsEnabled + "}")
                        .header("Authorization", "Bearer token"))
                .andExpect(MockMvcResultMatchers.status().isBadRequest());
    }
}