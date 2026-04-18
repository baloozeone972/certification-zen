package com.certifapp.api.dto.request;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class ChatMessageRequestTest {

    @InjectMocks
    private ChatMessageRequest chatMessageRequest;

    @Mock
    private UUID sessionIdMock;

    @BeforeEach
    public void setUp() {
        // Initialize the session ID mock
        when(sessionIdMock).thenReturn(UUID.randomUUID());
    }

    @DisplayName("Should create a valid ChatMessageRequest with message and optional sessionId")
    @Test
    public void createChatMessageRequest_validMessageAndSessionId_success() {
        String message = "Hello, AI!";
        UUID sessionId = sessionIdMock;

        chatMessageRequest = new ChatMessageRequest(message, sessionId);

        Assertions.assertThat(chatMessageRequest.message()).isEqualTo(message);
        Assertions.assertThat(chatMessageRequest.sessionId()).isEqualTo(sessionId);
    }

    @DisplayName("Should create a valid ChatMessageRequest with message and null sessionId")
    @Test
    public void createChatMessageRequest_validMessageAndNullSessionId_success() {
        String message = "Hello, AI!";
        UUID sessionId = null;

        chatMessageRequest = new ChatMessageRequest(message, sessionId);

        Assertions.assertThat(chatMessageRequest.message()).isEqualTo(message);
        Assertions.assertThat(chatMessageRequest.sessionId()).isNull();
    }

    @DisplayName("Should throw IllegalArgumentException if message is blank")
    @Test
    public void createChatMessageRequest_blankMessage_exception() {
        String message = "";
        UUID sessionId = null;

        Assertions.assertThatExceptionOfType(IllegalArgumentException.class)
                .isThrownBy(() -> new ChatMessageRequest(message, sessionId))
                .withMessageContaining("must not be blank");
    }

    @DisplayName("Should throw IllegalArgumentException if message exceeds max length")
    @Test
    public void createChatMessageRequest_messageTooLong_exception() {
        String message = "a".repeat(2001);
        UUID sessionId = null;

        Assertions.assertThatExceptionOfType(IllegalArgumentException.class)
                .isThrownBy(() -> new ChatMessageRequest(message, sessionId))
                .withMessageContaining("size must be between");
    }
}

