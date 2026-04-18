package com.certifapp.api.config;

import io.swagger.v3.oas.models.OpenAPI;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import org.springframework.context.annotation.Bean;

import static io.swagger.v3.oas.models.security.SecurityScheme.Type.HTTP;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class OpenApiConfigTest {

    @InjectMocks
    private OpenApiConfig openApiConfig;

    @BeforeEach
    public void setUp() {
        // Setup any initial state or dependencies before each test
    }

    @AfterEach
    public void tearDown() {
        // Cleanup after each test if necessary
    }

    @DisplayName("Should return an OpenAPI object with default configuration")
    @Test
    public void certifAppOpenApi_defaultConfiguration_success() {
        OpenAPI openAPI = openApiConfig.certifAppOpenApi();

        assertThat(openAPI)
                .isNotNull()
                .hasFieldOrPropertyWithValue("info.title", "CertifApp API")
                .hasFieldOrPropertyWithValue("info.description", "Plateforme SaaS de préparation aux certifications professionnelles")
                .hasFieldOrPropertyWithValue("info.version", "1.0.0")
                .extracting(OpenAPI::getInfo)
                .extracting(Info::getContact)
                .isNotNull()
                .hasFieldOrPropertyWithValue("name", "CertifApp Support")
                .hasFieldOrPropertyWithValue("url", "https://certifapp.com/support");

        assertThat(openAPI.getComponents())
                .containsKey("securitySchemes")
                .extracting(Components::getSecuritySchemes)
                .hasSize(1)
                .containsEntry("BearerAuth",
                        new SecurityScheme()
                                .type(HTTP)
                                .scheme("bearer")
                                .bearerFormat("JWT")
                                .description("JWT access token — prefix: Bearer "));

        assertThat(openAPI.getSecurityRequirements())
                .isNotEmpty()
                .extracting(SecurityRequirement::getLists)
                .hasSize(1)
                .containsEntry("BearerAuth", List.of());
    }

    @DisplayName("Should handle null contact details")
    @Test
    public void certifAppOpenApi_nullContact_success() {
        when(openApiConfig.certifAppOpenApi().info().getContact()).thenReturn(null);

        OpenAPI openAPI = openApiConfig.certifAppOpenApi();

        assertThat(openAPI)
                .isNotNull()
                .hasFieldOrPropertyWithValue("info.title", "CertifApp API")
                .hasFieldOrPropertyWithValue("info.description", "Plateforme SaaS de préparation aux certifications professionnelles")
                .hasFieldOrPropertyWithValue("info.version", "1.0.0")
                .extracting(OpenAPI::getInfo)
                .extracting(Info::getContact)
                .isNull();

        assertThat(openAPI.getComponents())
                .containsKey("securitySchemes")
                .extracting(Components::getSecuritySchemes)
                .hasSize(1)
                .containsEntry("BearerAuth",
                        new SecurityScheme()
                                .type(HTTP)
                                .scheme("bearer")
                                .bearerFormat("JWT")
                                .description("JWT access token — prefix: Bearer "));

        assertThat(openAPI.getSecurityRequirements())
                .isNotEmpty()
                .extracting(SecurityRequirement::getLists)
                .hasSize(1)
                .containsEntry("BearerAuth", List.of());
    }

    @DisplayName("Should handle empty security requirements")
    @Test
    public void certifAppOpenApi_emptySecurityRequirements_success() {
        when(openApiConfig.certifAppOpenApi().getSecurityRequirements()).thenReturn(List.of());

        OpenAPI openAPI = openApiConfig.certifAppOpenApi();

        assertThat(openAPI)
                .isNotNull()
                .hasFieldOrPropertyWithValue("info.title", "CertifApp API")
                .hasFieldOrPropertyWithValue("info.description", "Plateforme SaaS de préparation aux certifications professionnelles")
                .hasFieldOrPropertyWithValue("info.version", "1.0.0")
                .extracting(OpenAPI::getInfo)
                .extracting(Info::getContact)
                .isNotNull()
                .hasFieldOrPropertyWithValue("name", "CertifApp Support")
                .hasFieldOrPropertyWithValue("url", "https://certifapp.com/support");

        assertThat(openAPI.getComponents())
                .containsKey("securitySchemes")
                .extracting(Components::getSecuritySchemes)
                .hasSize(1)
                .containsEntry("BearerAuth",
                        new SecurityScheme()
                                .type(HTTP)
                                .scheme("bearer")
                                .bearerFormat("JWT")
                                .description("JWT access token — prefix: Bearer "));

        assertThat(openAPI.getSecurityRequirements())
                .isNotEmpty()
                .extracting(SecurityRequirement::getLists)
                .hasSize(1)
                .containsEntry("BearerAuth", List.of());
    }

    @DisplayName("Should handle null components")
    @Test
    public void certifAppOpenApi_nullComponents_success() {
        when(openApiConfig.certifAppOpenApi().getComponents()).thenReturn(null);

        OpenAPI openAPI = openApiConfig.certifAppOpenApi();

        assertThat(openAPI)
                .isNotNull()
                .hasFieldOrPropertyWithValue("info.title", "CertifApp API")
                .hasFieldOrPropertyWithValue("info.description", "Plateforme SaaS de préparation aux certifications professionnelles")
                .hasFieldOrPropertyWithValue("info.version", "1.0.0")
                .extracting(OpenAPI::getInfo)
                .extracting(Info::getContact)
                .isNotNull()
                .hasFieldOrPropertyWithValue("name", "CertifApp Support")
                .hasFieldOrPropertyWithValue("url", "https://certifapp.com/support");

        assertThat(openAPI.getSecurityRequirements())
                .isNotEmpty()
                .extracting(SecurityRequirement::getLists)
                .hasSize(1)
                .containsEntry("BearerAuth", List.of());
    }
}
