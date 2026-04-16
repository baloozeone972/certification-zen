```java
package com.certifapp.api.security;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.mock.web.MockFilterChain;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import java.io.IOException;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class JwtAuthenticationFilterTest {

    @Mock
    private JwtTokenProvider tokenProvider;

    @InjectMocks
    private JwtAuthenticationFilter jwtAuthenticationFilter;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    @DisplayName("should authenticate request with valid Bearer token")
    public void doFilterInternal_validBearerToken_authenticated() throws IOException, ServletException {
        String token = "valid_token";
        when(tokenProvider.isAccessToken(token)).thenReturn(true);
        when(tokenProvider.validateAndGetClaims(token)).thenReturn(Map.of("subject", "user1", "role", "admin"));

        MockHttpServletRequest request = new MockHttpServletRequest();
        request.addHeader("Authorization", "Bearer " + token);

        MockHttpServletResponse response = new MockHttpServletResponse();
        FilterChain chain = mock(FilterChain.class);

        jwtAuthenticationFilter.doFilterInternal(request, response, chain);

        UsernamePasswordAuthenticationToken authentication = (UsernamePasswordAuthenticationToken)
                SecurityContextHolder.getContext().getAuthentication();

        assertThat(authentication).isNotNull();
        assertThat(authentication.getName()).isEqualTo("user1");
        assertThat(authentication.getAuthorities()).containsExactly(new SimpleGrantedAuthority("ROLE_ADMIN"));

        verify(chain, times(1)).doFilter(request, response);
    }

    @Test
    @DisplayName("should not authenticate request with invalid Bearer token")
    public void doFilterInternal_invalidBearerToken_unauthenticated() throws IOException, ServletException {
        String token = "invalid_token";
        when(tokenProvider.isAccessToken(token)).thenReturn(true);
        when(tokenProvider.validateAndGetClaims(anyString())).thenThrow(new RuntimeException());

        MockHttpServletRequest request = new MockHttpServletRequest();
        request.addHeader("Authorization", "Bearer " + token);

        MockHttpServletResponse response = new MockHttpServletResponse();
        FilterChain chain = mock(FilterChain.class);

        jwtAuthenticationFilter.doFilterInternal(request, response, chain);

        assertThat(SecurityContextHolder.getContext().getAuthentication()).isNull();

        verify(chain, times(1)).doFilter(request, response);
    }

    @Test
    @DisplayName("should not authenticate request without Bearer token")
    public void doFilterInternal_noBearerToken_unauthenticated() throws IOException, ServletException {
        MockHttpServletRequest request = new MockHttpServletRequest();
        MockHttpServletResponse response = new MockHttpServletResponse();
        FilterChain chain = mock(FilterChain.class);

        jwtAuthenticationFilter.doFilterInternal(request, response, chain);

        assertThat(SecurityContextHolder.getContext().getAuthentication()).isNull();

        verify(chain, times(1)).doFilter(request, response);
    }

    @Test
    @DisplayName("should not authenticate request with empty Bearer token")
    public void doFilterInternal_emptyBearerToken_unauthenticated() throws IOException, ServletException {
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.addHeader("Authorization", "Bearer ");

        MockHttpServletResponse response = new MockHttpServletResponse();
        FilterChain chain = mock(FilterChain.class);

        jwtAuthenticationFilter.doFilterInternal(request, response, chain);

        assertThat(SecurityContextHolder.getContext().getAuthentication()).isNull();

        verify(chain, times(1)).doFilter(request, response);
    }
}
```
