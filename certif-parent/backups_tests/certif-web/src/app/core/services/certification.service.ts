// certif-parent/certif-web/src/app/core/services/certification.service.ts
import {inject, Injectable, signal} from "@angular/core";
import {HttpClient} from "@angular/common/http";
import {map, tap} from "rxjs";
import {environment} from "../../../environments/environment";
import {Certification} from "../models/certification.models";
import {ApiResponse} from "../models/api.models";

/**
 * Service for certification catalogue data.
 * Uses Angular 18 signals for reactive local state.
 */
@Injectable({providedIn: "root"})
export class CertificationService {
    readonly certifications = signal<Certification[]>([]);
    readonly loading = signal(false);
    private readonly http = inject(HttpClient);
    private readonly base = `${environment.apiUrl}/certifications`;

    loadAll() {
        this.loading.set(true);
        return this.http.get<ApiResponse<Certification[]>>(this.base).pipe(
            map(res => res.data),
            tap(data => {
                this.certifications.set(data);
                this.loading.set(false);
            })
        );
    }

    getById(id: string) {
        return this.http.get<ApiResponse<Certification>>(`${this.base}/${id}`)
            .pipe(map(res => res.data));
    }
}
