// certif-parent/certif-web/src/app/core/services/ai.service.ts
import {Injectable} from "@angular/core";
import {HttpClient, HttpErrorResponse} from "@angular/common/http";
import {environment} from "../../../environments/environment";

/**
 * Service for AI assistant features.
 */
@Injectable({providedIn: "root"})
export class AiService {
    private readonly http: HttpClient;
    private readonly base: string;

    constructor(http: HttpClient) {
        this.http = http;
        this.base = `${environment.apiUrl}/ai`;
    }

    chat(message: string, sessionId?: string) {
        return this.http.post<{ message: string; sources: string[] }>(
            `${this.base}/chat`, {message, sessionId}
        );
    }

    explainQuestion(questionId: string) {
        return this.http.get<{ explanation: string; codeExample?: string; officialDocUrl?: string }>(
            `${this.base}/explain/${questionId}`
        );
    }
}