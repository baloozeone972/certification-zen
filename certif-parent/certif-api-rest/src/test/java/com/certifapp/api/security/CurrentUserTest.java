```java
package com.certifapp.api.security;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;

import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.assertThrows;

@ExtendWith(MockitoExtension.class)
public class CurrentUserTest {

    @Mock
    private SecurityContextHolder securityContextHolder;

    @Mock
    private SecurityContext securityContext;

    @Mock
    private Authentication authentication;

    @InjectMocks
    private CurrentUser currentUser;

    @BeforeEach
    public void setUp() {
        when(securityContextHolder.getContext()).thenReturn(securityContext);
    }

    @Test
    @DisplayName("Should return user UUID from security context")
    public void id_authenticatedUserPresent_expectedUUID() {
        UUID expectedUserId = UUID.randomUUID();
        when(authentication.isAuthenticated()).thenReturn(true);
        when(authentication.getPrincipal()).thenReturn(expectedUserId.toString());
        when(securityContext.getAuthentication()).thenReturn(authentication);

        UUID userId = currentUser.id();

        assertThat(userId).isEqualTo(expectedUserId);
    }

    @Test
    @DisplayName("Should throw IllegalStateException if no authenticated user")
    public void id_noAuthenticatedUserPresent_exceptionThrown() {
        when(authentication.isAuthenticated()).thenReturn(false);
        when(securityContext.getAuthentication()).thenReturn(authentication);

        assertThrows(IllegalStateException.class, () -> currentUser.id());
    }

    @Test
    @DisplayName("Should throw IllegalStateException if authentication is null")
    public void id_authenticationNull_exceptionThrown() {
        when(securityContext.getAuthentication()).thenReturn(null);

        assertThrows(IllegalStateException.class, () -> currentUser.id());
    }

    @Test
    @DisplayName("Should throw IllegalStateException if principal is null")
    public void id_principalNull_exceptionThrown() {
        when(authentication.isAuthenticated()).thenReturn(true);
        when(authentication.getPrincipal()).thenReturn(null);
        when(securityContext.getAuthentication()).thenReturn(authentication);

        assertThrows(IllegalStateException.class, () -> currentUser.id());
    }
}
```
