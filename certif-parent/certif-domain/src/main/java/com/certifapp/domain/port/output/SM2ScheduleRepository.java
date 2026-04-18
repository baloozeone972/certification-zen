// certif-parent/certif-domain/src/main/java/com/certifapp/domain/port/output/SM2ScheduleRepository.java
package com.certifapp.domain.port.output;

import com.certifapp.domain.model.learning.SM2Schedule;

import java.util.Optional;
import java.util.UUID;

/**
 * Output port: persistence of SM-2 review schedules.
 */
public interface SM2ScheduleRepository {
    Optional<SM2Schedule> findByUserAndQuestion(UUID userId, UUID questionId);

    SM2Schedule save(SM2Schedule schedule);
}
