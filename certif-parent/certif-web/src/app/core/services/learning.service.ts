// certif-parent/certif-web/src/app/core/services/learning.service.ts
import {inject, Injectable} from "@angular/core";
import {HttpClientTestingModule, HttpTestingController} from "@angular/common/http/testing";
// certif-parent/certif-web/src/app/core/services/learning.service.spec.ts
import {TestBed} from "@angular/core/testing";
import {environment} from "../../../environments/environment";
import {AdaptivePlan, ApiResponse, Course, Flashcard, SM2Progress} from "../models/learning.models";
import {ApiResponse} from "../models/api.models";
import {LearningService} from "./learning.service";

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

describe('LearningService', () => {
    let service: LearningService;
    let httpMock: HttpTestingController;

    beforeEach(() => {
        TestBed.configureTestingModule({
            imports: [HttpClientTestingModule],
            providers: []
        });
        service = TestBed.inject(LearningService);
        httpMock = TestBed.inject(HttpTestingController);
    });

    afterEach(() => {
        httpMock.verify();
    });

    it('should get flashcards due', async () => {
        const certificationId = '123';
        const limit = 20;
        const mockFlashcards: Flashcard[] = [];

        service.getFlashcardsDue(certificationId, limit).subscribe(flashcards => {
            expect(flashcards).toEqual(mockFlashcards);
        });

        const req = httpMock.expectOne(`${environment.apiUrl}/learning/flashcards/${certificationId}?limit=${limit}`);
        expect(req.request.method).toBe('GET');
        req.flush({data: mockFlashcards});
    });

    it('should review flashcard', async () => {
        const id = '456';
        const rating = 3;
        const mockSM2Progress: SM2Progress = {};

        service.reviewFlashcard(id, rating).subscribe(sm2Progress => {
            expect(sm2Progress).toEqual(mockSM2Progress);
        });

        const req = httpMock.expectOne(`${environment.apiUrl}/learning/flashcards/${id}/review`);
        expect(req.request.method).toBe('POST');
        req.flush({data: mockSM2Progress});
    });

    it('should get courses', async () => {
        const certificationId = '789';
        const mockCourses: Course[] = [];

        service.getCourses(certificationId).subscribe(courses => {
            expect(courses).toEqual(mockCourses);
        });

        const req = httpMock.expectOne(`${environment.apiUrl}/learning/courses/${certificationId}`);
        expect(req.request.method).toBe('GET');
        req.flush({data: mockCourses});
    });

    it('should get course', async () => {
        const certificationId = '101';
        const themeCode = 'abc';
        const mockCourse: Course = {};

        service.getCourse(certificationId, themeCode).subscribe(course => {
            expect(course).toEqual(mockCourse);
        });

        const req = httpMock.expectOne(`${environment.apiUrl}/learning/courses/${certificationId}/${themeCode}`);
        expect(req.request.method).toBe('GET');
        req.flush({data: mockCourse});
    });

    it('should get adaptive plan', async () => {
        const certificationId = '112';
        const mockAdaptivePlan: AdaptivePlan = {};

        service.getAdaptivePlan(certificationId).subscribe(adaptivePlan => {
            expect(adaptivePlan).toEqual(mockAdaptivePlan);
        });

        const req = httpMock.expectOne(`${environment.apiUrl}/learning/adaptive-plan?certificationId=${certificationId}`);
        expect(req.request.method).toBe('GET');
        req.flush({data: mockAdaptivePlan});
    });
});