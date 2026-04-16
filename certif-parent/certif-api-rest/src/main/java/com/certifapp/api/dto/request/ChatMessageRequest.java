// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/dto/request/ChatMessageRequest.java
package com.certifapp.api.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import java.util.UUID;

/**
 * HTTP request body for {@code POST /api/v1/ai/chat}.
 *
 * @param message   the user message to the AI assistant
 * @param sessionId conversation session ID for context continuity (optional)
 */
public record ChatMessageRequest(
        @NotBlank @Size(max = 2000) String message,
        UUID sessionId
) {}
