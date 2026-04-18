// certif-parent/certif-application/src/main/java/com/certifapp/application/dto/coaching/JobMarketDto.java
package com.certifapp.application.dto.coaching;

import java.time.OffsetDateTime;
import java.util.List;

/**
 * Job market data for a certification in a specific country.
 *
 * @param certificationId certification slug
 * @param countryCode     ISO 3166-1 alpha-2 country code
 * @param jobCount        number of job listings mentioning this certification
 * @param medianSalaryEur median salary in EUR (null if unavailable)
 * @param topCompanies    list of top hiring companies
 * @param fetchedAt       when this data was last fetched
 */
public record JobMarketDto(
        String certificationId,
        String countryCode,
        int jobCount,
        Integer medianSalaryEur,
        List<String> topCompanies,
        OffsetDateTime fetchedAt
) {
}
