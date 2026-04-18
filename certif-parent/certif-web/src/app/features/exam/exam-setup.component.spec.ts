import {ComponentFixture, TestBed} from '@angular/core/testing';
import {CommonModule} from '@angular/common';
import {FormsModule} from '@angular/forms';
import {RouterTestingModule} from '@angular/router/testing';
import {ActivatedRoute, Router} from '@angular/router';
import {CertificationService} from '../../core/services/certification.service';
import {ExamService} from '../../core/services/exam.service';
import {Certification} from '../../core/models/certification.models';
import {ExamSetupComponent} from './exam-setup.component';

describe('ExamSetupComponent', () => {
    let component: ExamSetupComponent;
    let fixture: ComponentFixture<ExamSetupComponent>;
    let certificationService: CertificationService;
    let examService: ExamService;
    let router: Router;

    beforeEach(async () => {
        await TestBed.configureTestingModule({
            imports: [CommonModule, FormsModule, RouterTestingModule],
            declarations: [ExamSetupComponent]
        }).compileComponents();
    });

    beforeEach(() => {
        fixture = TestBed.createComponent(ExamSetupComponent);
        component = fixture.componentInstance;
        certificationService = TestBed.inject(CertificationService);
        examService = TestBed.inject(ExamService);
        router = TestBed.inject(Router);

        spyOn(certificationService, 'getById').and.returnValue(of(null));
        spyOn(examService, 'start').and.returnValue(of({id: 'session-id'}));
    });

    afterEach(() => {
        jest.clearAllMocks();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });

    it('should load certification on init when certId is provided', () => {
        const certId = 'mock-cert-id';
        spyOnProperty(TestBed.inject(ActivatedRoute), 'snapshot').and.returnValue({
            queryParams: {certId}
        });
        component.ngOnInit();
        expect(certificationService.getById).toHaveBeenCalledWith(certId);
    });

    it('should not start exam if certification is null', () => {
        component.startExam();
        expect(examService.start).not.toHaveBeenCalled();
        expect(component.starting()).toBeFalse();
    });

    it('should start exam and redirect on success', async () => {
        const cert: Certification = {
            id: 'cert-id',
            name: 'Mock Cert',
            examQuestionCount: 10,
            examDurationMin: 30,
            passingScore: 80
        };
        spyOnProperty(TestBed.inject(ActivatedRoute), 'snapshot').and.returnValue({
            queryParams: {certId: cert.id}
        });
        certificationService.getById.and.returnValue(of(cert));
        component.ngOnInit();
        await component.startExam();
        expect(examService.start).toHaveBeenCalledWith(cert.id, 'EXAM');
        expect(component.starting()).toBeTrue();
    });

    it('should handle error during exam start', async () => {
        const certId = 'mock-cert-id';
        spyOnProperty(TestBed.inject(ActivatedRoute), 'snapshot').and.returnValue({
            queryParams: {certId}
        });
        certificationService.getById.and.returnValue(of({id: certId, name: 'Mock Cert'}));
        examService.start.and.throwError('Error starting exam');
        component.ngOnInit();
        await component.startExam();
        expect(examService.start).toHaveBeenCalledWith(certId, 'EXAM');
        expect(component.starting()).toBeFalse();
    });
});