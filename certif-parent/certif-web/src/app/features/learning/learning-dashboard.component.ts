import {ComponentFixture, TestBed} from '@angular/core/testing';
import {RouterTestingModule} from '@angular/router/testing';
import {CommonModule} from '@angular/common';
import {CertificationService} from '../../core/services/certification.service';
import {LearningDashboardComponent} from './learning-dashboard.component';

describe('LearningDashboardComponent', () => {
    let component: LearningDashboardComponent;
    let fixture: ComponentFixture<LearningDashboardComponent>;
    let certificationService: CertificationService;

    beforeEach(async () => {
        await TestBed.configureTestingModule({
            imports: [CommonModule, RouterTestingModule],
            declarations: [LearningDashboardComponent],
            providers: [
                {provide: CertificationService, useValue: jasmine.createSpyObj('CertificationService', ['loadAll'])}
            ]
        }).compileComponents();
    });

    beforeEach(() => {
        fixture = TestBed.createComponent(LearningDashboardComponent);
        component = fixture.componentInstance;
        certificationService = TestBed.inject(CertificationService);
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });

    it('should call loadAll on ngOnInit', () => {
        component.ngOnInit();
        expect(certificationService.loadAll).toHaveBeenCalled();
    });

    it('should display certifications', async () => {
        const mockCertifications = [
            {id: 1, name: 'Certification 1', code: 'C1'},
            {id: 2, name: 'Certification 2', code: 'C2'}
        ];
        certificationService.loadAll.and.returnValue(Promise.resolve(mockCertifications));

        fixture.detectChanges();
        await fixture.whenStable();

        const certificationCards = fixture.nativeElement.querySelectorAll('.learn-card');
        expect(certificationCards.length).toBe(2);
        expect(certificationCards[0].querySelector('h3').textContent).toContain('Certification 1');
        expect(certificationCards[1].querySelector('h3').textContent).toContain('Certification 2');
    });
});