import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';
import { CertificationService } from './certification.service';
import { signal, computed } from '@angular/core';
import { Certification, ApiResponse } from '../models';

describe('CertificationService', () => {
  let service: CertificationService;
  let httpMock: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: [CertificationService]
    });
    service = TestBed.inject(CertificationService);
    httpMock = TestBed.inject(HttpTestingController);
  });

  afterEach(() => {
    httpMock.verify();
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  describe('loadAll', () => {
    it('should load all certifications and set loading to false on success', () => {
      const mockData: Certification[] = [{ id: '1', name: 'Cert1' }];
      service.loading.set(true);

      service.loadAll().subscribe();

      httpMock.expectOne(`${environment.apiUrl}/certifications`).flush({
        data: mockData,
        message: 'success'
      });

      expect(service.certifications()).toEqual(mockData);
      expect(service.loading()).toBeFalse();
    });

    it('should handle error and set loading to false on failure', () => {
      service.loading.set(true);

      service.loadAll().subscribe(
        () => fail('Expected an error, but got success'),
        error => expect(error).toBeTruthy()
      );

      httpMock.expectOne(`${environment.apiUrl}/certifications`).error(new ErrorEvent('Test error'));

      expect(service.loading()).toBeFalse();
    });
  });

  describe('getById', () => {
    it('should get certification by id and return the data', () => {
      const mockData: Certification = { id: '1', name: 'Cert1' };

      service.getById('1').subscribe(data => expect(data).toEqual(mockData));

      httpMock.expectOne(`${environment.apiUrl}/certifications/1`).flush({
        data: mockData,
        message: 'success'
      });
    });

    it('should handle error and return null on failure', () => {
      service.getById('1').subscribe(
        data => expect(data).toBeNull(),
        error => fail('Expected an error, but got success')
      );

      httpMock.expectOne(`${environment.apiUrl}/certifications/1`).error(new ErrorEvent('Test error'));
    });
  });
});
