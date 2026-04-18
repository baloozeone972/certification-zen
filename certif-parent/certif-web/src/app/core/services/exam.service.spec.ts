import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';
import { ExamService } from './exam.service';
import { environment } from '../../../environments/environment';
import { ApiResponse, ExamSession, ExamResult, UserAnswer, ExamSessionSummary } from '../models/exam.models';

describe('ExamService', () => {
  let service: ExamService;
  let httpMock: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: [ExamService]
    });
    service = TestBed.inject(ExamService);
    httpMock = TestBed.inject(HttpTestingController);
  });

  afterEach(() => {
    httpMock.verify();
  });

  describe('start', () => {
    it('should start a new exam session', () => {
      const sessionId = '123';
      const response: ExamSession = { id: sessionId, status: 'started' };

      service.start('certifId', 'mode').subscribe(result => expect(result).toEqual(response));

      const req = httpMock.expectOne(`${environment.apiUrl}/exams/sessions`);
      expect(req.request.method).toBe('POST');
      expect(req.request.body).toEqual({ certificationId: 'certifId', mode: 'mode' });
      req.flush({ data: response });
    });

    it('should handle options with default values', () => {
      const sessionId = '123';
      const response: ExamSession = { id: sessionId, status: 'started' };

      service.start('certifId', 'mode', {}).subscribe(result => expect(result).toEqual(response));

      const req = httpMock.expectOne(`${environment.apiUrl}/exams/sessions`);
      expect(req.request.method).toBe('POST');
      expect(req.request.body).toEqual({ certificationId: 'certifId', mode: 'mode' });
      req.flush({ data: response });
    });

    it('should handle options with provided values', () => {
      const sessionId = '123';
      const selectedThemes = ['theme1', 'theme2'];
      const questionCount = 10;
      const durationMinutes = 60;
      const response: ExamSession = { id: sessionId, status: 'started' };

      service.start('certifId', 'mode', {
        selectedThemes,
        questionCount,
        durationMinutes
      }).subscribe(result => expect(result).toEqual(response));

      const req = httpMock.expectOne(`${environment.apiUrl}/exams/sessions`);
      expect(req.request.method).toBe('POST');
      expect(req.request.body).toEqual({
        certificationId: 'certifId',
        mode: 'mode',
        selectedThemes,
        questionCount,
        durationMinutes
      });
      req.flush({ data: response });
    });

    it('should handle error', () => {
      const errorResponse = { statusText: 'Bad Request', status: 400 };

      service.start('certifId', 'mode').subscribe(
        () => fail(),
        (error) => expect(error.status).toBe(400)
      );

      const req = httpMock.expectOne(`${environment.apiUrl}/exams/sessions`);
      req.error(new ErrorEvent('Bad Request'), { status: 400 });
    });
  });

  describe('submitAnswer', () => {
    it('should submit an answer', () => {
      const sessionId = '123';
      const questionId = 'q456';
      const selectedOptionId = 'o789';
      const responseTimeMs = 500;
      const userAnswer: UserAnswer = { questionId, selectedOptionId, responseTimeMs };

      service.submitAnswer(sessionId, questionId, selectedOptionId, responseTimeMs).subscribe(result => expect(result).toEqual(userAnswer));

      const req = httpMock.expectOne(`${environment.apiUrl}/exams/sessions/${sessionId}/answers`);
      expect(req.request.method).toBe('POST');
      expect(req.request.body).toEqual({ questionId, selectedOptionId, responseTimeMs });
      req.flush({ data: userAnswer });
    });

    it('should handle error', () => {
      const sessionId = '123';
      const questionId = 'q456';
      const selectedOptionId = 'o789';
      const responseTimeMs = 500;

      service.submitAnswer(sessionId, questionId, selectedOptionId, responseTimeMs).subscribe(
        () => fail(),
        (error) => expect(error.status).toBe(400)
      );

      const req = httpMock.expectOne(`${environment.apiUrl}/exams/sessions/${sessionId}/answers`);
      req.error(new ErrorEvent('Bad Request'), { status: 400 });
    });
  });

  describe('submitExam', () => {
    it('should submit an exam session', () => {
      const sessionId = '123';
      const response: ExamSession = { id: sessionId, status: 'submitted' };

      service.submitExam(sessionId).subscribe(result => expect(result).toEqual(response));

      const req = httpMock.expectOne(`${environment.apiUrl}/exams/sessions/${sessionId}/submit`);
      expect(req.request.method).toBe('POST');
      req.flush({ data: response });
    });

    it('should handle error', () => {
      const sessionId = '123';

      service.submitExam(sessionId).subscribe(
        () => fail(),
        (error) => expect(error.status).toBe(400)
      );

      const req = httpMock.expectOne(`${environment.apiUrl}/exams/sessions/${sessionId}/submit`);
      req.error(new ErrorEvent('Bad Request'), { status: 400 });
    });
  });

  describe('getResults', () => {
    it('should get exam results', () => {
      const sessionId = '123';
      const response: ExamResult = { score: 85, answers: [] };

      service.getResults(sessionId).subscribe(result => expect(result).toEqual(response));

      const req = httpMock.expectOne(`${environment.apiUrl}/exams/sessions/${sessionId}/results`);
      expect(req.request.method).toBe('GET');
      req.flush({ data: response });
    });

    it('should handle error', () => {
      const sessionId = '123';

      service.getResults(sessionId).subscribe(
        () => fail(),
        (error) => expect(error.status).toBe(400)
      );

      const req = httpMock.expectOne(`${environment.apiUrl}/exams/sessions/${sessionId}/results`);
      req.error(new ErrorEvent('Bad Request'), { status: 400 });
    });
  });

  describe('getHistory', () => {
    it('should get exam history with default parameters', () => {
      const response: ExamSessionSummary[] = [{ id: '123', certificationId: 'certif1', mode: 'mode1' }];

      service.getHistory().subscribe(result => expect(result).toEqual(response));

      const req = httpMock.expectOne(`${environment.apiUrl}/exams/history?page=0&size=20`);
      expect(req.request.method).toBe('GET');
      req.flush({ data: response });
    });

    it('should get exam history with custom parameters', () => {
      const page = 1;
      const size = 30;
      const certificationId = 'certif2';
      const mode = 'mode2';
      const response: ExamSessionSummary[] = [{ id: '456', certificationId, mode }];

      service.getHistory(page, size, certificationId, mode).subscribe(result => expect(result).toEqual(response));

      const req = httpMock.expectOne(`${environment.apiUrl}/exams/history?page=1&size=30&certificationId=${certificationId}&mode=${mode}`);
      expect(req.request.method).toBe('GET');
      req.flush({ data: response });
    });

    it('should handle error', () => {
      const page = 1;
      const size = 30;

      service.getHistory(page, size).subscribe(
        () => fail(),
        (error) => expect(error.status).toBe(400)
      );

      const req = httpMock.expectOne(`${environment.apiUrl}/exams/history?page=1&size=30`);
      req.error(new ErrorEvent('Bad Request'), { status: 400 });
    });
  });

  describe('exportPdf', () => {
    it('should export exam session as PDF', () => {
      const sessionId = '123';
      const response: Blob = new Blob(['PDF data'], { type: 'application/pdf' });

      service.exportPdf(sessionId).subscribe(result => expect(result).toEqual(response));

      const req = httpMock.expectOne(`${environment.apiUrl}/exams/sessions/${sessionId}/export-pdf`);
      expect(req.request.method).toBe('GET');
      expect(req.request.responseType).toBe('blob');
      req.flush(response);
    });

    it('should handle error', () => {
      const sessionId = '123';

      service.exportPdf(sessionId).subscribe(
        () => fail(),
        (error) => expect(error.status).toBe(400)
      );

      const req = httpMock.expectOne(`${environment.apiUrl}/exams/sessions/${sessionId}/export-pdf`);
      req.error(new ErrorEvent('Bad Request'), { status: 400 });
    });
  });
});
