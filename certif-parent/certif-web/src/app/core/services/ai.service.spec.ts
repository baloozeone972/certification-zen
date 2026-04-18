import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { map } from 'rxjs';

import { AiService } from './ai.service';
import { environment } from '../../../environments/environment';
import { ApiResponse } from '../models/api.models';

describe('AiService', () => {
  let service: AiService;
  let httpMock: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: []
    });

    service = TestBed.inject(AiService);
    httpMock = TestBed.inject(HttpTestingController);
  });

  afterEach(() => {
    httpMock.verify();
  });

  describe('chat', () => {
    it('should return the expected data from a chat request', () => {
      const mockData: { message: string; sources: string[] } = { message: 'response', sources: ['source1', 'source2'] };
      const message = 'test message';
      const sessionId = 'session123';

      service.chat(message, sessionId).subscribe(data => expect(data).toEqual(mockData));

      const req = httpMock.expectOne(`${environment.apiUrl}/ai/chat`);
      expect(req.request.method).toBe('POST');
      expect(req.request.body).toEqual({ message, sessionId });
      req.flush(mockData);
    });

    it('should handle the case where no sessionId is provided', () => {
      const mockData: { message: string; sources: string[] } = { message: 'response', sources: ['source1', 'source2'] };
      const message = 'test message';

      service.chat(message).subscribe(data => expect(data).toEqual(mockData));

      const req = httpMock.expectOne(`${environment.apiUrl}/ai/chat`);
      expect(req.request.method).toBe('POST');
      expect(req.request.body).toEqual({ message });
      req.flush(mockData);
    });

    it('should handle errors from the chat request', () => {
      const errorResponse = { error: 'Something went wrong' };

      service.chat('test message').subscribe(
        () => fail('Expected to catch an error but no error was thrown'),
        error => expect(error).toEqual(errorResponse)
      );

      const req = httpMock.expectOne(`${environment.apiUrl}/ai/chat`);
      expect(req.request.method).toBe('POST');
      req.flush(errorResponse, { status: 500, statusText: 'Server Error' });
    });
  });

  describe('explainQuestion', () => {
    it('should return the expected data from an explain request', () => {
      const mockData: { explanation: string; codeExample?: string; officialDocUrl?: string } = {
        explanation: 'explanation',
        codeExample: 'code example',
        officialDocUrl: 'https://example.com'
      };
      const questionId = 'question123';

      service.explainQuestion(questionId).subscribe(data => expect(data).toEqual(mockData));

      const req = httpMock.expectOne(`${environment.apiUrl}/ai/explain/question123`);
      expect(req.request.method).toBe('GET');
      req.flush(mockData);
    });

    it('should handle errors from the explain request', () => {
      const errorResponse = { error: 'Something went wrong' };

      service.explainQuestion('question123').subscribe(
        () => fail('Expected to catch an error but no error was thrown'),
        error => expect(error).toEqual(errorResponse)
      );

      const req = httpMock.expectOne(`${environment.apiUrl}/ai/explain/question123`);
      expect(req.request.method).toBe('GET');
      req.flush(errorResponse, { status: 500, statusText: 'Server Error' });
    });
  });
});
