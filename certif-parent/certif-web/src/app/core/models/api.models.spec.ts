```typescript
import { TestBed } from '@angular/core/testing';
import { ApiResponse, ErrorResponse, FieldError, PageResponse } from './api.models';

describe('API Models', () => {
  let apiResponse: ApiResponse<any>;
  let errorResponse: ErrorResponse;

  beforeEach(() => {
    apiResponse = {
      data: {},
      message: 'Success',
      timestamp: new Date().toISOString()
    };

    errorResponse = {
      status: 400,
      message: 'Bad Request',
      errors: [
        { field: 'email', message: 'Invalid email' }
      ],
      timestamp: new Date().toISOString()
    };
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
      expect(errorResponse.errors).toEqual([{ field: 'email', message: 'Invalid email' }]);
      expect(errorResponse.timestamp).toContain('T');
    });

    it('should handle empty errors array', () => {
      errorResponse.errors = [];
      expect(errorResponse.errors).toEqual([]);
    });
  });

  describe('PageResponse', () => {
    let pageResponse: PageResponse<any>;

    beforeEach(() => {
      pageResponse = {
        content: [],
        totalElements: 0,
        totalPages: 1,
        page: 0,
        size: 10
      };
    });

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
```
