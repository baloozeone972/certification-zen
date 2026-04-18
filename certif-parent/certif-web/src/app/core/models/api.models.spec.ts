import {ApiResponse, ErrorResponse, PageResponse} from './api.models';
import {TestBed} from '@angular/core/testing';

describe('API Models', () => {
    let apiResponse: ApiResponse<any>;
    let errorResponse: ErrorResponse;
    let pageResponse: PageResponse<any>;

    beforeEach(() => {
        TestBed.configureTestingModule({
            providers: [
                {provide: ApiResponse, useValue: {}},
                {provide: ErrorResponse, useValue: {}},
                {provide: PageResponse, useValue: {}}
            ]
        });

        apiResponse = TestBed.inject(ApiResponse);
        errorResponse = TestBed.inject(ErrorResponse);
        pageResponse = TestBed.inject(PageResponse);

        apiResponse.data = {};
        apiResponse.message = 'Success';
        apiResponse.timestamp = new Date().toISOString();

        errorResponse.status = 400;
        errorResponse.message = 'Bad Request';
        errorResponse.errors = [
            {field: 'email', message: 'Invalid email'}
        ];
        errorResponse.timestamp = new Date().toISOString();

        pageResponse.content = [];
        pageResponse.totalElements = 0;
        pageResponse.totalPages = 1;
        pageResponse.page = 0;
        pageResponse.size = 10;
    });

    describe('ApiResponse', () => {
        it('should create an instance with data, message, and timestamp', () => {
            expect(apiResponse).toBeTruthy();
            expect(apiResponse.data).toBeDefined();
            expect(apiResponse.message).toBe('Success');
            expect(apiResponse.timestamp).toContain('T');
        });

        it('should handle empty data object', () => {
            apiResponse.data = {};
            expect(apiResponse.data).toEqual({});
        });
    });

    describe('ErrorResponse', () => {
        it('should create an instance with status, message, errors, and timestamp', () => {
            expect(errorResponse).toBeTruthy();
            expect(errorResponse.status).toBe(400);
            expect(errorResponse.message).toBe('Bad Request');
            expect(errorResponse.errors).toEqual([{field: 'email', message: 'Invalid email'}]);
            expect(errorResponse.timestamp).toContain('T');
        });

        it('should handle empty errors array', () => {
            errorResponse.errors = [];
            expect(errorResponse.errors).toEqual([]);
        });
    });

    describe('PageResponse', () => {
        it('should create an instance with content, totalElements, totalPages, page, and size', () => {
            expect(pageResponse).toBeTruthy();
            expect(pageResponse.content).toEqual([]);
            expect(pageResponse.totalElements).toBe(0);
            expect(pageResponse.totalPages).toBe(1);
            expect(pageResponse.page).toBe(0);
            expect(pageResponse.size).toBe(10);
        });

        it('should handle empty content array', () => {
            pageResponse.content = [];
            expect(pageResponse.content).toEqual([]);
        });
    });
});