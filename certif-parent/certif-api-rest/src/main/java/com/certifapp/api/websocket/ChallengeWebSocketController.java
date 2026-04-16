// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/websocket/ChallengeWebSocketController.java
package com.certifapp.api.websocket;

import org.springframework.messaging.handler.annotation.*;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import java.util.Map;

/**
 * WebSocket controller for live challenge leaderboard updates.
 *
 * <p>When a user submits their challenge, the leaderboard is broadcast
 * to all subscribers of {@code /topic/challenge/{id}/leaderboard}.</p>
 */
@Controller
public class ChallengeWebSocketController {

    private final SimpMessagingTemplate messagingTemplate;

    public ChallengeWebSocketController(SimpMessagingTemplate messagingTemplate) {
        this.messagingTemplate = messagingTemplate;
    }

    /**
     * Broadcasts a leaderboard update to all challenge participants.
     *
     * @param challengeId the challenge UUID
     * @param payload     leaderboard update payload
     */
    public void broadcastLeaderboardUpdate(String challengeId, Object payload) {
        messagingTemplate.convertAndSend(
                "/topic/challenge/" + challengeId + "/leaderboard", payload);
    }

    /**
     * Handles challenge progress messages from participants.
     *
     * @param challengeId the challenge UUID from path
     * @param message     progress message payload
     */
    @MessageMapping("/challenge/{challengeId}/progress")
    public void handleProgress(
            @DestinationVariable String challengeId,
            Map<String, Object> message) {
        // Broadcast progress update to all subscribers
        messagingTemplate.convertAndSend(
                "/topic/challenge/" + challengeId + "/progress", message);
    }
}
