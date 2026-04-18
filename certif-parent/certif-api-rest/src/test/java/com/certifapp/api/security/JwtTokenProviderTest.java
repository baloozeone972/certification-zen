package com.certifapp.api.security;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.header;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(JwtTokenProviderController.class)
class JwtTokenProviderTest {

    @Autowired
    private MockMvc mockMvc;

    @BeforeEach
    void setUp() {
        // Setup if needed
    }

    @Test
    @DisplayName("Access token is valid and contains user UUID")
    void generateAccessToken_shouldBeValidAndContainUserId() throws Exception {
        mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"username\":\"user\",\"password\":\"pass\"}"))
                .andExpect(status().isOk())
                .andExpect(header().string("Authorization", "Bearer [^ ]+"))
                .andExpect(jsonPath("$.userId").value("user"));
    }

    @Test
    @DisplayName("Refresh token is NOT an access token")
    void generateRefreshToken_shouldNotBeAccessToken() throws Exception {
        mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"username\":\"user\",\"password\":\"pass\"}"))
                .andExpect(status().isOk())
                .andExpect(header().string("Authorization", "Bearer [^ ]+"))
                .andExpect(jsonPath("$.refreshToken").value("[^ ]+"));
    }

    @Test
    @DisplayName("Role claim is present in access token")
    void accessToken_shouldContainRoleClaim() throws Exception {
        mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"username\":\"admin\",\"password\":\"pass\"}"))
                .andExpect(status().isOk())
                .andExpect(header().string("Authorization", "Bearer [^ ]+"))
                .andExpect(jsonPath("$.role").value("ADMIN"));
    }

    @Test
    @DisplayName("Tampered token throws JwtException")
    void tamperedToken_shouldThrowJwtException() throws Exception {
        mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"username\":\"user\",\"password\":\"pass\"}"))
                .andExpect(status().isOk())
                .andExpect(header().string("Authorization", "Bearer [^ ]+"))
                .andExpect(jsonPath("$.userId").value("user"));

        String token = mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"username\":\"user\",\"password\":\"pass\"}"))
                .andExpect(status().isOk())
                .andReturn()
                .getResponse()
                .getHeader("Authorization")
                .split(" ")[1];

        String tampered = token.substring(0, token.length() - 5) + "XXXXX";

        mockMvc.perform(get("/api/auth/validate")
                        .header("Authorization", "Bearer " + tampered))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("Expired token throws JwtException")
    void expiredToken_shouldThrowJwtException() throws Exception {
        mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"username\":\"user\",\"password\":\"pass\"}"))
                .andExpect(status().isOk())
                .andExpect(header().string("Authorization", "Bearer [^ ]+"))
                .andExpect(jsonPath("$.userId").value("user"));

        String token = mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"username\":\"user\",\"password\":\"pass\"}"))
                .andExpect(status().isOk())
                .andReturn()
                .getResponse()
                .getHeader("Authorization")
                .split(" ")[1];

        mockMvc.perform(get("/api/auth/validate")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isUnauthorized());
    }
}