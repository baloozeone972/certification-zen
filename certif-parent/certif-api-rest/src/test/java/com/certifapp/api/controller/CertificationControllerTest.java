// certif-parent/certif-api-rest/src/test/java/com/certifapp/api/controller/CertificationControllerTest.java
package com.certifapp.api.controller;

import com.certifapp.domain.exception.CertificationNotFoundException;
import com.certifapp.domain.model.certification.Certification;
import com.certifapp.domain.port.input.certification.*;
import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.util.List;

import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Slice test for {@link CertificationController} using MockMvc.
 */
@WebMvcTest(CertificationController.class)
@Import(com.certifapp.api.security.SecurityConfig.class)
@DisplayName("CertificationController")
class CertificationControllerTest {

    @Autowired private MockMvc mockMvc;
    @MockBean  private ListCertificationsUseCase      listUseCase;
    @MockBean  private GetCertificationDetailsUseCase detailsUseCase;
    @MockBean  private com.certifapp.api.security.JwtAuthenticationFilter jwtFilter;

    private static final String OCP21_ID = "ocp21";

    @Test
    @DisplayName("GET /api/v1/certifications — returns 200 with list")
    void listCertifications_shouldReturn200() throws Exception {
        Certification cert = buildCert(OCP21_ID, "OCP Java 21");
        when(listUseCase.execute(true)).thenReturn(List.of(cert));

        mockMvc.perform(get("/api/v1/certifications")
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.data[0].id").value(OCP21_ID))
                .andExpect(jsonPath("$.data[0].name").value("OCP Java 21"));
    }

    @Test
    @DisplayName("GET /api/v1/certifications/{id} — returns 200 with details")
    void getCertification_shouldReturn200() throws Exception {
        Certification cert = buildCert(OCP21_ID, "OCP Java 21");
        when(detailsUseCase.execute(OCP21_ID)).thenReturn(cert);

        mockMvc.perform(get("/api/v1/certifications/" + OCP21_ID)
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.data.id").value(OCP21_ID));
    }

    @Test
    @DisplayName("GET /api/v1/certifications/{id} — returns 404 when not found")
    void getCertification_notFound_shouldReturn404() throws Exception {
        when(detailsUseCase.execute("unknown"))
                .thenThrow(new CertificationNotFoundException("unknown"));

        mockMvc.perform(get("/api/v1/certifications/unknown")
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isNotFound())
                .andExpect(jsonPath("$.status").value(404));
    }

    private static Certification buildCert(String id, String name) {
        return new Certification(id, "1Z0-830", name, "Description",
                500, 80, 180, 68, "MCQ", List.of(), true);
    }
}
