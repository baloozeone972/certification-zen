```java
package com.certifapp.api.websocket;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.jupiter.MockitoExtension;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class ChallengeWebSocketControllerTest {

    @Mock
    private SimpMessagingTemplate messagingTemplate;

    @InjectMocks
    private ChallengeWebSocketController challengeWebSocketController;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @DisplayName("broadcastLeaderboardUpdate_nominalCase_shouldBroadcastPayload")
    @Test
    public void broadcastLeaderboardUpdate_nominalCase_shouldBroadcastPayload() {
        // Given
        String challengeId = "testChallengeId";
        Object payload = new Object();

        // When
        challengeWebSocketController.broadcastLeaderboardUpdate(challengeId, payload);

        // Then
        verify(messagingTemplate).convertAndSend("/topic/challenge/testChallengeId/leaderboard", payload);
    }

    @DisplayName("broadcastLeaderboardUpdate_emptyPayload_shouldBroadcastEmptyPayload")
    @Test
    public void broadcastLeaderboardUpdate_emptyPayload_shouldBroadcastEmptyPayload() {
        // Given
        String challengeId = "testChallengeId";
        Object payload = null;

        // When
        challengeWebSocketController.broadcastLeaderboardUpdate(challengeId, payload);

        // Then
        verify(messagingTemplate).convertAndSend("/topic/challenge/testChallengeId/leaderboard", null);
    }

    @DisplayName("handleProgress_nominalCase_shouldBroadcastMessage")
    @Test
    public void handleProgress_nominalCase_shouldBroadcastMessage() {
        // Given
        String challengeId = "testChallengeId";
        Map<String, Object> message = mock(Map.class);

        // When
        challengeWebSocketController.handleProgress(challengeId, message);

        // Then
        verify(messagingTemplate).convertAndSend("/topic/challenge/testChallengeId/progress", message);
    }

    @DisplayName("handleProgress_emptyMessage_shouldBroadcastEmptyMessage")
    @Test
    public void handleProgress_emptyMessage_shouldBroadcastEmptyMessage() {
        // Given
        String challengeId = "testChallengeId";
        Map<String, Object> message = null;

        // When
        challengeWebSocketController.handleProgress(challengeId, message);

        // Then
        verify(messagingTemplate).convertAndSend("/topic/challenge/testChallengeId/progress", null);
    }

    @DisplayName("handleProgress_nullChallengeId_shouldThrowException")
    @Test
    public void handleProgress_nullChallengeId_shouldThrowException() {
        // Given
        String challengeId = null;
        Map<String, Object> message = mock(Map.class);

        // When & Then
        assertThatThrownBy(() -> challengeWebSocketController.handleProgress(challengeId, message))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessage("Challenge ID must not be null");
    }
}
```
