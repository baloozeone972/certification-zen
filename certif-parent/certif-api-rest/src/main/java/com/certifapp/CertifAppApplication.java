// certif-parent/certif-api-rest/src/main/java/com/certifapp/CertifAppApplication.java
package com.certifapp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * CertifApp Spring Boot entry point.
 *
 * <p>Virtual Threads are enabled globally via {@code spring.threads.virtual.enabled=true}
 * in application.yml — no code change required here.</p>
 *
 * <p>Entity scanning is explicit to cover the multi-module Maven structure.</p>
 */
@SpringBootApplication(scanBasePackages = {
    "com.certifapp.api",
    "com.certifapp.application",
    "com.certifapp.infrastructure",
    "com.certifapp.ai"
})
@EntityScan("com.certifapp.infrastructure.persistence.entity")
@EnableScheduling
public class CertifAppApplication {

    public static void main(String[] args) {
        SpringApplication.run(CertifAppApplication.class, args);
    }
}
