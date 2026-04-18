package com.certifapp;

import org.junit.jupiter.api.extension.ExtendWith;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.boot.SpringApplication;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
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
    public void run_springBootApplication_noException() {
        certifAppApplication.main(new String[]{});
        verify(mockSpringApplication, times(1)).run(anyString());
    }

    @DisplayName("edge cases: should handle null arguments gracefully")
    @Test
    public void run_springBootApplication_withNullArgs_noException() {
        certifAppApplication.main(null);
        verify(mockSpringApplication, never()).run(anyString());
    }

    @DisplayName("error cases: should not throw exception on non-empty string array input")
    @Test
    public void run_springBootApplication_withNonEmptyArray_noException() {
        certifAppApplication.main(new String[]{"--test"});
        verify(mockSpringApplication, times(1)).run(anyString());
    }
}
