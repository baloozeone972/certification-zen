// certif-parent/certif-domain/src/main/java/com/certifapp/domain/port/output/UserAnswerRepository.java
package com.certifapp.domain.port.output;

import com.certifapp.domain.model.session.UserAnswer;
import java.util.List;
import java.util.UUID;

/** Output port: persistence of individual user answers. */
public interface UserAnswerRepository {
    UserAnswer        save(UserAnswer answer);
    List<UserAnswer>  saveAll(List<UserAnswer> answers);
    List<UserAnswer>  findBySessionId(UUID sessionId);
}
