// certif-parent/certif-web/src/app/core/services/learning.service.ts
import {inject, Injectable} from "@angular/core";
import {HttpClient} from "@angular/common/http";
import {map} from "rxjs";
import {environment} from "../../../environments/environment";
import {AdaptivePlan, Course, Flashcard, SM2Progress} from "../models/learning.models";
import {ApiResponse} from "../models/api.models";

/**
 * Service for learning features: courses, flashcards and SM-2 review.
 */
@Injectable({providedIn: "root"})
export class LearningService {
    private readonly http = inject(HttpClient);
    private readonly base = `${environment.apiUrl}/learning`;

    getFlashcardsDue(certificationId: string, limit = 20) {
        return this.http.get<ApiResponse<Flashcard[]>>(
            `${this.base}/flashcards/${certificationId}`, {params: {limit}}
        ).pipe(map(r => r.data));
    }

    reviewFlashcard(id: string, rating: number) {
        return this.http.post<ApiResponse<SM2Progress>>(
            `${this.base}/flashcards/${id}/review`, {rating}
        ).pipe(map(r => r.data));
    }

    getCourses(certificationId: string) {
        return this.http.get<ApiResponse<Course[]>>(
            `${this.base}/courses/${certificationId}`
        ).pipe(map(r => r.data));
    }

    getCourse(certificationId: string, themeCode: string) {
        return this.http.get<ApiResponse<Course>>(
            `${this.base}/courses/${certificationId}/${themeCode}`
        ).pipe(map(r => r.data));
    }

    getAdaptivePlan(certificationId: string) {
        return this.http.get<ApiResponse<AdaptivePlan>>(
            `${this.base}/adaptive-plan`, {params: {certificationId}}
        ).pipe(map(r => r.data));
    }
}
