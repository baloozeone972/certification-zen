package com.certifapp.domain.model.session;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class SessionStatusTest {

    @Test
    @DisplayName("SessionStatus.isFinished should return true for COMPLETED")
    public void isFinished_Completed_ReturnsTrue() {
        assertThat(SessionStatus.COMPLETED.isFinished()).isTrue();
    }

    @Test
    @DisplayName("SessionStatus.isFinished should return true for EXPIRED")
    public void isFinished_Expired_ReturnsTrue() {
        assertThat(SessionStatus.EXPIRED.isFinished()).isTrue();
    }

    @Test
    @DisplayName("SessionStatus.isFinished should return false for IN_PROGRESS")
    public void isFinished_InProgress_ReturnsFalse() {
        assertThat(SessionStatus.IN_PROGRESS.isFinished()).isFalse();
    }

    @Test
    @DisplayName("SessionStatus.isFinished should return false for ABANDONED")
    public void isFinished_Abandoned_ReturnsFalse() {
        assertThat(SessionStatus.ABANDONED.isFinished()).isFalse();
    }
}