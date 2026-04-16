// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/config/OpenApiConfig.java
package com.certifapp.api.config;

import io.swagger.v3.oas.models.*;
import io.swagger.v3.oas.models.info.*;
import io.swagger.v3.oas.models.security.*;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * SpringDoc OpenAPI configuration.
 *
 * <p>Swagger UI available at: {@code /swagger-ui.html}
 * OpenAPI JSON at: {@code /v3/api-docs}</p>
 */
@Configuration
public class OpenApiConfig {

    @Bean
    public OpenAPI certifAppOpenApi() {
        return new OpenAPI()
                .info(new Info()
                        .title("CertifApp API")
                        .description("Plateforme SaaS de préparation aux certifications professionnelles")
                        .version("1.0.0")
                        .contact(new Contact()
                                .name("CertifApp Support")
                                .url("https://certifapp.com/support")))
                .addSecurityItem(new SecurityRequirement().addList("BearerAuth"))
                .components(new Components()
                        .addSecuritySchemes("BearerAuth",
                                new SecurityScheme()
                                        .type(SecurityScheme.Type.HTTP)
                                        .scheme("bearer")
                                        .bearerFormat("JWT")
                                        .description("JWT access token — prefix: Bearer ")));
    }
}
