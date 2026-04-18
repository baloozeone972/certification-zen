package com.certifapp.infrastructure.cache;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

import java.util.concurrent.TimeUnit;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.cache.CacheManager;

@ExtendWith(MockitoExtension.class)
public class CaffeineCacheConfigTest {

    @Mock
    private CacheManager cacheManager;

    @InjectMocks
    private CaffeineCacheConfig caffeineCacheConfig;

    @BeforeEach
    public void setUp() {
        when(cacheManager.getCaffeine("certifications")).thenReturn(Caffeine.newBuilder().expireAfterWrite(1, TimeUnit.HOURS).maximumSize(50).build());
        when(cacheManager.getCaffeine("certificationsList")).thenReturn(Caffeine.newBuilder().expireAfterWrite(1, TimeUnit.HOURS).maximumSize(5).build());
        when(cacheManager.getCaffeine("jobMarket")).thenReturn(Caffeine.newBuilder().expireAfterWrite(24, TimeUnit.HOURS).maximumSize(200).build());
        when(cacheManager.getCaffeine("aiExplanations")).thenReturn(Caffeine.newBuilder().expireAfterWrite(24, TimeUnit.HOURS).maximumSize(5000).build());
    }

    @Test
    @DisplayName("Should create cache manager with default spec and custom caches")
    public void cacheManager_defaultSpecAndCustomCaches() {
        CacheManager result = caffeineCacheConfig.cacheManager();

        assertThat(result).isNotNull();
        verify(cacheManager, times(1)).setCaffeine(defaultSpec());
        verify(cacheManager, times(1)).registerCustomCache("certifications", any(Caffeine.class));
        verify(cacheManager, times(1)).registerCustomCache("certificationsList", any(Caffeine.class));
        verify(cacheManager, times(1)).registerCustomCache("jobMarket", any(Caffeine.class));
        verify(cacheManager, times(1)).registerCustomCache("aiExplanations", any(Caffeine.class));
    }

    @Test
    @DisplayName("Should throw exception if cache manager is null")
    public void cacheManager_nullCacheManager() {
        when(cacheManager.getCaffeine(anyString())).thenReturn(null);

        assertThrows(NullPointerException.class, () -> caffeineCacheConfig.cacheManager());
    }
}
