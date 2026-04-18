import {TestBed} from '@angular/core/testing';
import {HttpClientTestingModule, HttpTestingController} from '@angular/common/http/testing';
import {CertificationService} from './certification.service';
import {Certification} from '../models';
import {environment} from '../../environments/environment';

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
        it('should load all certifications and set loading to false on success', async () => {
            const mockData: Certification[] = [{id: '1', name: 'Cert1'}];
            service.loading.set(true);

            await service.loadAll().toPromise();

            httpMock.expectOne(`${environment.apiUrl}/certifications`).flush({
                data: mockData,
                message: 'success'
            });

            expect(service.certifications()).toEqual(mockData);
            expect(service.loading()).toBeFalse();
        });

        it('should handle error and set loading to false on failure', async () => {
            service.loading.set(true);

            await expectAsync(service.loadAll()).toBeRejectedWith('Test error');

            httpMock.expectOne(`${environment.apiUrl}/certifications`).error(new ErrorEvent('Test error'));

            expect(service.loading()).toBeFalse();
        });
    });

    describe('getById', () => {
        it('should get certification by id and return the data', async () => {
            const mockData: Certification = {id: '1', name: 'Cert1'};

            await service.getById('1').toPromise();

            httpMock.expectOne(`${environment.apiUrl}/certifications/1`).flush({
                data: mockData,
                message: 'success'
            });

            expect(service.getById('1')).toBeObservableOf(mockData);
        });

        it('should handle error and return null on failure', async () => {
            await expectAsync(service.getById('1')).toBeRejectedWith('Test error');

            httpMock.expectOne(`${environment.apiUrl}/certifications/1`).error(new ErrorEvent('Test error'));

            expect(service.getById('1')).toBeObservableOf(null);
        });
    });
});