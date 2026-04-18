package com.certifapp.api.websocket;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoExtension;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;
import static org.assertj.core.api.Assertions.assertThat;

@ExtendWith(MockitoExtension.class)
public class WebSocketConfigTest {

    @Mock
    private StompEndpointRegistry stompEndpointRegistry;

    @Mock
    private MessageBrokerRegistry messageBrokerRegistry;

    @InjectMocks
    private WebSocketConfig webSocketConfig;

    @BeforeEach
    public void setUp() {
        // Setup any necessary mocks or configurations before each test
    }

    @Test
    @DisplayName("registerStompEndpoints_withAllowedOrigins_registersEndpointWithSockJS")
    public void registerStompEndpoints_withAllowedOrigins_registersEndpointWithSockJS() {
        webSocketConfig.registerStompEndpoints(stompEndpointRegistry);

        verify(stompEndpointRegistry).addEndpoint("/ws");
        verify(stompEndpointRegistry).setAllowedOriginPatterns("http://localhost:4200", "https://certifapp.com");
        verify(stompEndpointRegistry).withSockJS();
    }

    @Test
    @DisplayName("registerStompEndpoints_withNoOrigins_registersEndpointWithSockJS")
    public void registerStompEndpoints_withNoOrigins_registersEndpointWithSockJS() {
        webSocketConfig.registerStompEndpoints(stompEndpointRegistry);

        verify(stompEndpointRegistry).addEndpoint("/ws");
        verify(stompEndpointRegistry, never()).setAllowedOriginPatterns(anyString());
        verify(stompEndpointRegistry).withSockJS();
    }

    @Test
    @DisplayName("configureMessageBroker_withNoCustomPrefixes_configuresDefaultDestinations")
    public void configureMessageBroker_withNoCustomPrefixes_configuresDefaultDestinations() {
        webSocketConfig.configureMessageBroker(messageBrokerRegistry);

        verify(messageBrokerRegistry).enableSimpleBroker("/topic", "/queue");
        verify(messageBrokerRegistry).setApplicationDestinationPrefixes("/app");
        verify(messageBrokerRegistry).setUserDestinationPrefix("/user");
    }
}
