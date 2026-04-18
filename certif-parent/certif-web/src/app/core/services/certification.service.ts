import {TestBed} from '@angular/core/testing';
import {HttpClientTestingModule, HttpTestingController} from '@angular/common/http/testing';
import {CertificationService} from './certification.service';
import {environment} from '../../../environments/environment';
import {Certification} from '../models/certification.models';

describe('CertificationService', () => {
    let service: CertificationService;
    let httpMock: HttpTestingController;

    beforeEach(() => {
        TestBed.configureTestingModule({
            imports: [HttpClientTestingModule],
            providers: [
                CertificationService,
                {provide: environment, useValue: {apiUrl: 'http://localhost:3000'}}
            ]
        });
        service = TestBed.inject(CertificationService);
        httpMock = TestBed.inject(HttpTestingController);
    });

    afterEach(() => {
        httpMock.verify();
    });

    it('should load all certifications', async () => {
        const mockCertifications: Certification[] = [
            {id: '1', name: 'Certification 1'},
            {id: '2', name: 'Certification 2'}
        ];

        service.loadAll().subscribe(certifications => {
            expect(certifications).toEqual(mockCertifications);
        });

        const req = httpMock.expectOne(`${environment.apiUrl}/certifications`);
        expect(req.request.method).toBe('GET');
        req.flush({data: mockCertifications, status: 200});
    });

    it('should get certification by id', async () => {
        const mockCertification: Certification = {id: '1', name: 'Certification 1'};

        service.getById('1').subscribe(certification => {
            expect(certification).toEqual(mockCertification);
        });

        const req = httpMock.expectOne(`${environment.apiUrl}/certifications/1`);
        expect(req.request.method).toBe('GET');
        req.flush({data: mockCertification, status: 200});
    });
});