import {fakeAsync, inject, TestBed, tick} from '@angular/core/testing';
import {HttpClientTestingModule, HttpTestingController} from '@angular/common/http/testing';
import {LearningService} from './learning.service';
import {AdaptivePlan, Course, Flashcard, SM2Progress} from '../models/learning.models';

describe('LearningService', () => {
    let service: LearningService;
    let httpMock: HttpTestingController;

    beforeEach(() => {
        TestBed.configureTestingModule({
            imports: [HttpClientTestingModule],
            providers: [LearningService]
        });
        service = TestBed.inject(LearningService);
        httpMock = TestBed.inject(HttpTestingController);
    });

    afterEach(() => {
        httpMock.verify();
    });

    it('should be created', inject([LearningService], (service: LearningService) => {
        expect(service).toBeTruthy();
    }));

    describe('getFlashcardsDue', () => {
        it('should return flashcards due for a given certification ID', fakeAsync(() => {
            const mockData: Flashcard[] = [];
            service.getFlashcardsDue('cert123').subscribe(data => {
                expect(data).toEqual(mockData);
            });

            const req = httpMock.expectOne(`${environment.apiUrl}/learning/flashcards/cert123?limit=20`);
            expect(req.request.method).toBe('GET');
            req.flush({data: mockData});
            tick();
        }));

        it('should handle edge case with empty result', fakeAsync(() => {
            const mockData: Flashcard[] = [];
            service.getFlashcardsDue('cert123').subscribe(data => {
                expect(data.length).toBe(0);
            });

            const req = httpMock.expectOne(`${environment.apiUrl}/learning/flashcards/cert123?limit=20`);
            expect(req.request.method).toBe('GET');
            req.flush({data: []});
            tick();
        }));

        it('should handle error case', fakeAsync(() => {
            const mockError = new Error('Internal Server Error');
            service.getFlashcardsDue('cert123').subscribe(
                () => fail(),
                error => expect(error).toEqual(mockError)
            );

            const req = httpMock.expectOne(`${environment.apiUrl}/learning/flashcards/cert123?limit=20`);
            expect(req.request.method).toBe('GET');
            req.error(mockError);
            tick();
        }));
    });

    describe('reviewFlashcard', () => {
        it('should review a flashcard and return the SM2 progress', fakeAsync(() => {
            const mockData: SM2Progress = {};
            service.reviewFlashcard('flash123', 5).subscribe(data => {
                expect(data).toEqual(mockData);
            });

            const req = httpMock.expectOne(`${environment.apiUrl}/learning/flashcards/flash123/review`);
            expect(req.request.method).toBe('POST');
            expect(req.request.body).toEqual({rating: 5});
            req.flush({data: mockData});
            tick();
        }));

        it('should handle error case', fakeAsync(() => {
            const mockError = new Error('Internal Server Error');
            service.reviewFlashcard('flash123', 5).subscribe(
                () => fail(),
                error => expect(error).toEqual(mockError)
            );

            const req = httpMock.expectOne(`${environment.apiUrl}/learning/flashcards/flash123/review`);
            expect(req.request.method).toBe('POST');
            expect(req.request.body).toEqual({rating: 5});
            req.error(mockError);
            tick();
        }));
    });

    describe('getCourses', () => {
        it('should return courses for a given certification ID', fakeAsync(() => {
            const mockData: Course[] = [];
            service.getCourses('cert123').subscribe(data => {
                expect(data).toEqual(mockData);
            });

            const req = httpMock.expectOne(`${environment.apiUrl}/learning/courses/cert123`);
            expect(req.request.method).toBe('GET');
            req.flush({data: mockData});
            tick();
        }));

        it('should handle edge case with empty result', fakeAsync(() => {
            const mockData: Course[] = [];
            service.getCourses('cert123').subscribe(data => {
                expect(data.length).toBe(0);
            });

            const req = httpMock.expectOne(`${environment.apiUrl}/learning/courses/cert123`);
            expect(req.request.method).toBe('GET');
            req.flush({data: []});
            tick();
        }));

        it('should handle error case', fakeAsync(() => {
            const mockError = new Error('Internal Server Error');
            service.getCourses('cert123').subscribe(
                () => fail(),
                error => expect(error).toEqual(mockError)
            );

            const req = httpMock.expectOne(`${environment.apiUrl}/learning/courses/cert123`);
            expect(req.request.method).toBe('GET');
            req.error(mockError);
            tick();
        }));
    });

    describe('getCourse', () => {
        it('should return a course for a given certification ID and theme code', fakeAsync(() => {
            const mockData: Course = {};
            service.getCourse('cert123', 'themeCode').subscribe(data => {
                expect(data).toEqual(mockData);
            });

            const req = httpMock.expectOne(`${environment.apiUrl}/learning/courses/cert123/themeCode`);
            expect(req.request.method).toBe('GET');
            req.flush({data: mockData});
            tick();
        }));

        it('should handle error case', fakeAsync(() => {
            const mockError = new Error('Internal Server Error');
            service.getCourse('cert123', 'themeCode').subscribe(
                () => fail(),
                error => expect(error).toEqual(mockError)
            );

            const req = httpMock.expectOne(`${environment.apiUrl}/learning/courses/cert123/themeCode`);
            expect(req.request.method).toBe('GET');
            req.error(mockError);
            tick();
        }));
    });

    describe('getAdaptivePlan', () => {
        it('should return the adaptive plan for a given certification ID', fakeAsync(() => {
            const mockData: AdaptivePlan = {};
            service.getAdaptivePlan('cert123').subscribe(data => {
                expect(data).toEqual(mockData);
            });

            const req = httpMock.expectOne(`${environment.apiUrl}/learning/adaptive-plan?certificationId=cert123`);
            expect(req.request.method).toBe('GET');
            req.flush({data: mockData});
            tick();
        }));

        it('should handle error case', fakeAsync(() => {
            const mockError = new Error('Internal Server Error');
            service.getAdaptivePlan('cert123').subscribe(
                () => fail(),
                error => expect(error).toEqual(mockError)
            );

            const req = httpMock.expectOne(`${environment.apiUrl}/learning/adaptive-plan?certificationId=cert123`);
            expect(req.request.method).toBe('GET');
            req.error(mockError);
            tick();
        }));
    });
});

