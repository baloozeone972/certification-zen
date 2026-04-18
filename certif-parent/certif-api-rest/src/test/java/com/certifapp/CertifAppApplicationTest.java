package com.certifapp;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.boot.SpringApplication;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ExtendWith(MockitoExtension.class)
@WebMvcTest(CertifAppApplication.class)
public class CertifAppApplicationTest {

    @Mock
    private SpringApplication mockSpringApplication;

    @InjectMocks
    private CertifAppApplication certifAppApplication;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @DisplayName("nominal case: should run Spring Boot application")
    @Test
    public void run_springBootApplication_noException() throws Exception {
        mockMvc.perform(get("/api/run"))
                .andExpect(status().isOk())
                .andExpect(header().string("Content-Type", "application/json"))
                .andExpect(jsonPath("$.message").value("Spring Boot application started"));
    }

    @DisplayName("edge cases: should handle null arguments gracefully")
    @Test
    public void run_springBootApplication_withNullArgs_noException() throws Exception {
        mockMvc.perform(get("/api/run").param("args", (String[]) null))
                .andExpect(status().isOk())
                .andExpect(header().string("Content-Type", "application/json"))
                .andExpect(jsonPath("$.message").value("Spring Boot application started"));
    }

    @DisplayName("error cases: should not throw exception on non-empty string array input")
    @Test
    public void run_springBootApplication_withNonEmptyArray_noException() throws Exception {
        mockMvc.perform(get("/api/run").param("args", "--test"))
                .andExpect(status().isOk())
                .andExpect(header().string("Content-Type", "application/json"))
                .andExpect(jsonPath("$.message").value("Spring Boot application started"));
    }
}