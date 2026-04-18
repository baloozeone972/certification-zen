import {async, ComponentFixture, TestBed} from '@angular/core/testing';
import {CommonModule} from '@angular/common';
import {FormsModule} from '@angular/forms';
import {RouterTestingModule} from '@angular/router/testing';
import {CertificationService} from '../../core/services/certification.service';
import {ExamService} from '../../core/services/exam.service';
import {Certification} from '../../core/models/certification.models';
import {ExamSetupComponent} from './exam-setup.component';

describe('ExamSetupComponent', () => {
    let component: ExamSetupComponent;
    let fixture: ComponentFixture<ExamSetupComponent>;
    let certificationService: CertificationService;
    let examService: ExamService;

    beforeEach(async(() => {
        TestBed.configureTestingModule({
            imports: [CommonModule, FormsModule, RouterTestingModule],
            declarations: [ExamSetupComponent],
            providers: [
                {provide: CertificationService, useValue: {}},
                {provide: ExamService, useValue: {}}
            ]
        }).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(ExamSetupComponent);
        component = fixture.componentInstance;
        certificationService = TestBed.inject(CertificationService);
        examService = TestBed.inject(ExamService);
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });

    it('should display certification details when available', async(() => {
        const cert: Certification = {
            id: '1',
            name: 'Certification A',
            examQuestionCount: 10,
            examDurationMin: 60,
            passingScore: 75
        };
        spyOn(certificationService, 'getById').and.returnValue(of(cert));

        fixture.detectChanges();
        await fixture.whenStable();

        const certName = fixture.nativeElement.querySelector('.setup__cert h2').textContent;
        expect(certName).toBe('Certification A');
    }));

    it('should display modes and allow selection', async(() => {
        fixture.detectChanges();
        await fixture.whenStable();

        const modeButtons = fixture.nativeElement.querySelectorAll('.mode-btn');
        expect(modeButtons.length).toBe(3);
    }));

    it('should start exam and navigate to session page', async(() => {
        const cert: Certification = {
            id: '1',
            name: 'Certification A',
            examQuestionCount: 10,
            examDurationMin: 60,
            passingScore: 75
        };
        spyOn(certificationService, 'getById').and.returnValue(of(cert));
        const session = {id: '2'};
        spyOn(examService, 'start').and.returnValue(of(session));
        spyOn(component.router, 'navigate');

        component.cert.set(cert);
        component.startExam();

        await fixture.whenStable();
        expect(component.starting()).toBe(true);
        expect(examService.start).toHaveBeenCalledWith(cert.id, component.selectedMode());
        expect(component.router.navigate).toHaveBeenCalledWith(['/exam/session', session.id]);
    }));

    it('should handle exam start error and reset starting state', async(() => {
        const cert: Certification = {
            id: '1',
            name: 'Certification A',
            examQuestionCount: 10,
            examDurationMin: 60,
            passingScore: 75
        };
        spyOn(certificationService, 'getById').and.returnValue(of(cert));
        spyOn(examService, 'start').and.throwError('Error starting exam');
        spyOn(component.router, 'navigate');

        component.cert.set(cert);
        component.startExam();

        await fixture.whenStable();
        expect(component.starting()).toBe(false);
    }));
});