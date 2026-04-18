// certif-application/src/test/java/com/certifapp/application/dto/payment/SubscriptionStatusDtoTest.java
package com.certifapp.application.dto.payment;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("SubscriptionStatusDtoTest")
class SubscriptionStatusDtoTest {

    private final SubscriptionStatusDto dto = new SubscriptionStatusDto("PRO",null,null,true,false);

    @Test @DisplayName("tier() returns expected")
    void tier_expected() { assertThat(dto.tier()).isEqualTo("PRO"); }
    @Test @DisplayName("isActive() returns expected")
    void isActive_expected() { assertThat(dto.isActive()).isTrue(); }

    @Test @DisplayName("record equality holds")
    void equality_holds() { assertThat(dto).isEqualTo(new SubscriptionStatusDto("PRO",null,null,true,false)); }
}
