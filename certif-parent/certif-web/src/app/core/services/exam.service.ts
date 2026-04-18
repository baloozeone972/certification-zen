import {TestBed} from '@angular/core/testing';
import {HttpClientTestingModule, HttpTestingController} from '@angular/common/http/testing';
import {ExamService} from './exam.service';
import {environment} from '../../../environments/environment';

describe('ExamService', () => {
    let service: ExamService;
    let httpMock: HttpTestingController;

    beforeEach(() => {
        TestBed.configureTestingModule({
            imports: [HttpClientTestingModule],
            providers: []
        });
        service = TestBed.inject(ExamService);
        httpMock = TestBed.inject(HttpTestingController);
    });

    afterEach(() => {
        httpMock.verify();
    });

    it('should start exam session', async () => {
        const certificationId = '123';
        const mode = 'testMode';
        const options = {selectedThemes: ['theme1'], questionCount: 10, durationMinutes: 60};
        const expectedSession: ExamSession = {id: 'session1', ...options};

        service.start(certificationId, mode, options).subscribe(session => {
            expect(session).toEqual(expectedSession);
        });

        const req = httpMock.expectOne(`${environment.apiUrl}/exams/sessions`);
        expect(req.request.method).toBe('POST');
        expect(req.request.body).toEqual({certificationId, mode, selectedThemes: ['theme1'], questionCount: 10, durationMinutes: 60});
        req.flush({data: expectedSession});
    });

    it('should submit answer', async () => {
        const sessionId = 'session1';
        const questionId = 'question1';
        const selectedOptionId = 'option1';
        const responseTimeMs = 500;
        const expectedAnswer: UserAnswer = {id: 'answer1', questionId, selectedOptionId, responseTimeMs};

        service.submitAnswer(sessionId, questionId, selectedOptionId, responseTimeMs).subscribe(answer => {
            expect(answer).toEqual(expectedAnswer);
        });

        const req = httpMock.expectOne(`${environment.apiUrl}/exams/sessions/${sessionId}/answers`);
        expect(req.request.method).toBe('POST');
        expect(req.request.body).toEqual({questionId, selectedOptionId, responseTimeMs});
        req.flush({data: expectedAnswer});
    });

    it('should submit exam', async () => {
        const sessionId = 'session1';
        const expectedSession: ExamSession = {id: 'session1', status: 'submitted'};

        service.submitExam(sessionId).subscribe(session => {
            expect(session).toEqual(expectedSession);
        });

        const req = httpMock.expectOne(`${environment.apiUrl}/exams/sessions/${sessionId}/submit`);
        expect(req.request.method).toBe('POST');
        req.flush({data: expectedSession});
    });

    it('should get results', async () => {
        const sessionId = 'session1';
        const expectedResult: ExamResult = {id: 'result1', score: 85};

        service.getResults(sessionId).subscribe(result => {
            expect(result).toEqual(expectedResult);
        });

        const req = httpMock.expectOne(`${environment.apiUrl}/exams/sessions/${sessionId}/results`);
        expect(req.request.method).toBe('GET');
        req.flush({data: expectedResult});
    });

    it('should get history', async () => {
        const page = 0;
        const size = 20;
        const certificationId = 'cert1';
        const mode = 'testMode';
        const expectedHistory: ExamSessionSummary[] = [{id: 'history1', certificationId, mode}];

        service.getHistory(page, size, certificationId, mode).subscribe(history => {
            expect(history).toEqual(expectedHistory);
        });

        const req = httpMock.expectOne(`${environment.apiUrl}/exams/history?page=0&size=20&certificationId=cert1&mode=testMode`);
        expect(req.request.method).toBe('GET');
        req.flush({data: expectedHistory});
    });

    it('should export PDF', async () => {
        const sessionId = 'session1';
        const expectedBlob = new Blob(['PDF content'], {type: 'application/pdf'});

        service.exportPdf(sessionId).subscribe(blob => {
            expect(blob).toEqual(expectedBlob);
        });

        const req = httpMock.expectOne(`${environment.apiUrl}/exams/sessions/${sessionId}/export-pdf`);
        expect(req.request.method).toBe('GET');
        req.flush(expectedBlob, {responseType: 'blob'});
    });
});