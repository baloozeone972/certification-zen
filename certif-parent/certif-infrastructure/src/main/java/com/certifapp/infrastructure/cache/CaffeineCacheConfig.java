// certif-parent/certif-infrastructure/src/main/java/com/certifapp/infrastructure/cache/CaffeineCacheConfig.java
package com.certifapp.infrastructure.cache;

import com.github.benmanes.caffeine.cache.Caffeine;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.caffeine.CaffeineCacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.concurrent.TimeUnit;

/**
 * Caffeine cache configuration for certifapp.
 *
 * <p>Cache TTLs:
 * <ul>
 *   <li>{@code certifications} — 1 hour (rarely changes)</li>
 *   <li>{@code certificationsList} — 1 hour</li>
 *   <li>{@code jobMarket} — 24 hours (fetched weekly)</li>
 *   <li>{@code aiExplanations} — 24 hours (AI responses are deterministic per question)</li>
 * </ul>
 */
@Configuration
@EnableCaching
public class CaffeineCacheConfig {

    @Bean
    public CacheManager cacheManager() {
        CaffeineCacheManager manager = new CaffeineCacheManager();

        // Default spec for all caches not explicitly configured
        manager.setCaffeine(defaultSpec());

        // Per-cache configuration
        manager.registerCustomCache("certifications",
                Caffeine.newBuilder().expireAfterWrite(1, TimeUnit.HOURS)
                        .maximumSize(50).build());

        manager.registerCustomCache("certificationsList",
                Caffeine.newBuilder().expireAfterWrite(1, TimeUnit.HOURS)
                        .maximumSize(5).build());

        manager.registerCustomCache("jobMarket",
                Caffeine.newBuilder().expireAfterWrite(24, TimeUnit.HOURS)
                        .maximumSize(200).build());

        manager.registerCustomCache("aiExplanations",
                Caffeine.newBuilder().expireAfterWrite(24, TimeUnit.HOURS)
                        .maximumSize(5000).build());

        return manager;
    }

    private Caffeine<Object, Object> defaultSpec() {
        return Caffeine.newBuilder()
                .expireAfterWrite(30, TimeUnit.MINUTES)
                .maximumSize(100);
    }
}
