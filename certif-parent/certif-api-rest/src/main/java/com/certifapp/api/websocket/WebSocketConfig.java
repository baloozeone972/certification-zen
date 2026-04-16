// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/websocket/WebSocketConfig.java
package com.certifapp.api.websocket;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.*;

/**
 * WebSocket STOMP configuration for real-time features:
 * study group chat and challenge live leaderboard.
 *
 * <p>STOMP endpoints:
 * <ul>
 *   <li>Client subscribes: {@code /topic/challenge/{id}/leaderboard}</li>
 *   <li>Client subscribes: {@code /topic/group/{id}/messages}</li>
 *   <li>Client sends: {@code /app/challenge/{id}/submit}</li>
 * </ul>
 * </p>
 */
@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/ws")
                .setAllowedOriginPatterns("http://localhost:4200", "https://certifapp.com")
                .withSockJS();
    }

    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        // In-memory broker for topics and queues
        registry.enableSimpleBroker("/topic", "/queue");
        // Application destination prefix for @MessageMapping methods
        registry.setApplicationDestinationPrefixes("/app");
        // User destination prefix for private messages
        registry.setUserDestinationPrefix("/user");
    }
}
