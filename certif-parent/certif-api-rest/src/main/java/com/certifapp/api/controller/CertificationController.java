// certif-parent/certif-api-rest/src/main/java/com/certifapp/api/controller/CertificationController.java
package com.certifapp.api.controller;

import com.certifapp.api.dto.response.ApiResponse;
import com.certifapp.domain.model.certification.Certification;
import com.certifapp.domain.port.input.certification.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * REST controller for certification catalogue endpoints.
 *
 * <p>All GET endpoints are public — no authentication required.</p>
 */
@RestController
@RequestMapping("/api/v1/certifications")
@Tag(name = "Certifications", description = "Certification catalogue")
public class CertificationController {

    private final ListCertificationsUseCase      listUseCase;
    private final GetCertificationDetailsUseCase detailsUseCase;

    public CertificationController(
            ListCertificationsUseCase      listUseCase,
            GetCertificationDetailsUseCase detailsUseCase) {
        this.listUseCase    = listUseCase;
        this.detailsUseCase = detailsUseCase;
    }

    /**
     * List all active certifications.
     *
     * @return 200 OK with list of certification summaries
     */
    @GetMapping
    @Operation(summary = "List all active certifications")
    public ResponseEntity<ApiResponse<List<Certification>>> listAll() {
        return ResponseEntity.ok(ApiResponse.ok(listUseCase.execute(true)));
    }

    /**
     * Get full details of a certification including all themes.
     *
     * @param id the certification slug (e.g. ocp21)
     * @return 200 OK with certification details
     */
    @GetMapping("/{id}")
    @Operation(summary = "Get certification details")
    public ResponseEntity<ApiResponse<Certification>> getById(@PathVariable String id) {
        return ResponseEntity.ok(ApiResponse.ok(detailsUseCase.execute(id)));
    }
}
