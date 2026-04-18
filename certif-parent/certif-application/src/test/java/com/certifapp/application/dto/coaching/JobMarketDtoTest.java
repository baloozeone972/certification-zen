package com.certifapp.application.dto.coaching;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;

import static org.assertj.core.api.Assertions.assertThat;

@ExtendWith(MockitoExtension.class)
public class JobMarketDtoTest {

    @InjectMocks
    private JobMarketDto jobMarketDto;

    @BeforeEach
    public void setUp() {
        jobMarketDto = new JobMarketDto("certification123", "US", 50, 8000, List.of("CompanyA", "CompanyB"), OffsetDateTime.now());
    }

    @Test
    @DisplayName("Nominal case: Get certificationId")
    public void getCertificationId_nominal() {
        assertThat(jobMarketDto.certificationId()).isEqualTo("certification123");
    }

    @Test
    @DisplayName("Nominal case: Get countryCode")
    public void getCountryCode_nominal() {
        assertThat(jobMarketDto.countryCode()).isEqualTo("US");
    }

    @Test
    @DisplayName("Nominal case: Get jobCount")
    public void getJobCount_nominal() {
        assertThat(jobMarketDto.jobCount()).isEqualTo(50);
    }

    @Test
    @DisplayName("Nominal case: Get medianSalaryEur")
    public void getMedianSalaryEur_nominal() {
        assertThat(jobMarketDto.medianSalaryEur()).isEqualTo(8000);
    }

    @Test
    @DisplayName("Nominal case: Get topCompanies")
    public void getTopCompanies_nominal() {
        assertThat(jobMarketDto.topCompanies()).containsExactlyInAnyOrder("CompanyA", "CompanyB");
    }

    @Test
    @DisplayName("Nominal case: Get fetchedAt")
    public void getFetchedAt_nominal() {
        assertThat(jobMarketDto.fetchedAt()).isNotNull();
    }

    @Test
    @DisplayName("Edge case: Get medianSalaryEur is null")
    public void getMedianSalaryEur_null() {
        JobMarketDto dto = new JobMarketDto("certification123", "US", 50, null, List.of("CompanyA"), OffsetDateTime.now());
        assertThat(dto.medianSalaryEur()).isNull();
    }

    @Test
    @DisplayName("Edge case: Get topCompanies is empty")
    public void getTopCompanies_empty() {
        JobMarketDto dto = new JobMarketDto("certification123", "US", 50, 8000, List.of(), OffsetDateTime.now());
        assertThat(dto.topCompanies()).isEmpty();
    }

    @Test
    @DisplayName("Error case: Get jobCount negative")
    public void getJobCount_negative() {
        JobMarketDto dto = new JobMarketDto("certification123", "US", -50, 8000, List.of("CompanyA"), OffsetDateTime.now());
        assertThat(dto.jobCount()).isEqualTo(-50);
    }

    @Test
    @DisplayName("No interactions with mocks")
    public void noInteractionsWithMocks() {
        verifyNoInteractions(jobMarketDto);
    }
}