// certif-parent/certif-domain/src/main/java/com/certifapp/domain/port/output/QuestionRepository.java
package com.certifapp.domain.port.output;

import com.certifapp.domain.model.question.Question;
import com.certifapp.domain.model.question.QuestionFilter;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

/** Output port: persistence and retrieval operations for {@link Question}. */
public interface QuestionRepository {
    Optional<Question>  findById(UUID id);
    Optional<Question>  findByLegacyId(String legacyId);
    /** Returns questions matching the filter, shuffled randomly. */
    List<Question>      findByFilter(QuestionFilter filter);
    /** Returns the count of questions per theme for a given certification. */
    java.util.Map<String, Integer> countByTheme(String certificationId);
    Question            save(Question question);
    List<Question>      saveAll(List<Question> questions);
}
