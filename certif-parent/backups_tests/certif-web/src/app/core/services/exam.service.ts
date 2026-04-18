// certif-parent/certif-web/src/app/core/services/exam.service.ts
import {inject, Injectable} from "@angular/core";
import {HttpClient} from "@angular/common/http";
import {map} from "rxjs";
import {environment} from "../../../environments/environment";
import {ExamResult, ExamSession, ExamSessionSummary, UserAnswer} from "../models/exam.models";
import {ApiResponse} from "../models/api.models";

/**
 * Service for exam session lifecycle API calls.
 */
@Injectable({providedIn: "root"})
export class ExamService {
    private readonly http = inject(HttpClient);
    private readonly base = `${environment.apiUrl}/exams`;

    start(certificationId: string, mode: string, options?: {
        selectedThemes?: string[];
        questionCount?: number;
        durationMinutes?: number;
    }) {
        return this.http.post<ApiResponse<ExamSession>>(`${this.base}/sessions`, {
            certificationId, mode,
            selectedThemes: options?.selectedThemes ?? [],
            questionCount: options?.questionCount ?? 0,
            durationMinutes: options?.durationMinutes ?? 0
        }).pipe(map(r => r.data));
    }

    submitAnswer(sessionId: string, questionId: string,
                 selectedOptionId: string | null, responseTimeMs: number) {
        return this.http.post<ApiResponse<UserAnswer>>(
            `${this.base}/sessions/${sessionId}/answers`,
            {questionId, selectedOptionId, responseTimeMs}
        ).pipe(map(r => r.data));
    }

    submitExam(sessionId: string) {
        return this.http.post<ApiResponse<ExamSession>>(
            `${this.base}/sessions/${sessionId}/submit`, {}
        ).pipe(map(r => r.data));
    }

    getResults(sessionId: string) {
        return this.http.get<ApiResponse<ExamResult>>(
            `${this.base}/sessions/${sessionId}/results`
        ).pipe(map(r => r.data));
    }

    getHistory(page = 0, size = 20, certificationId?: string, mode?: string) {
        let params: Record<string, string | number> = {page, size};
        if (certificationId) params["certificationId"] = certificationId;
        if (mode) params["mode"] = mode;
        return this.http.get<ApiResponse<ExamSessionSummary[]>>(
            `${this.base}/history`, {params}
        ).pipe(map(r => r.data));
    }

    exportPdf(sessionId: string) {
        return this.http.get(`${this.base}/sessions/${sessionId}/export-pdf`,
            {responseType: "blob"});
    }
}
