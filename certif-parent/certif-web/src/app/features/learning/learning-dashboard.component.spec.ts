import { ComponentFixture, TestBed } from '@angular/core/testing';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { CertificationService } from '../../core/services/certification.service';
import { LearningDashboardComponent } from './learning-dashboard.component';
import { of, throwError } from 'rxjs';

describe('LearningDashboardComponent', () => {
  let component: LearningDashboardComponent;
  let fixture: ComponentFixture<LearningDashboardComponent>;
  let certificationService: CertificationService;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CommonModule, RouterLink],
      declarations: [LearningDashboardComponent]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(LearningDashboardComponent);
    component = fixture.componentInstance;
    certificationService = TestBed.inject(CertificationService);
    spyOn(certificationService, 'loadAll').and.returnValue(of([]));
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should load certifications on init', () => {
    spyOnProperty(certificationService, 'certifications').and.returnValue(signal([]));
    component.ngOnInit();
    fixture.detectChanges();
    expect(certificationService.loadAll).toHaveBeenCalled();
  });

  it('should display certifications', () => {
    const mockCertifications = [
      { id: 1, name: 'Certif 1', code: 'C1' },
      { id: 2, name: 'Certif 2', code: 'C2' }
    ];
    spyOnProperty(certificationService, 'certifications').and.returnValue(signal(mockCertifications));
    component.ngOnInit();
    fixture.detectChanges();
    const cards = fixture.nativeElement.querySelectorAll('.learn-card');
    expect(cards.length).toBe(2);
    expect(cards[0].querySelector('h3').textContent.trim()).toBe('Certif 1');
    expect(cards[1].querySelector('h3').textContent.trim()).toBe('Certif 2');
  });

  it('should handle error when loading certifications', () => {
    spyOn(certificationService, 'loadAll').and.returnValue(throwError(() => new Error('Failed to load certifications')));
    component.ngOnInit();
    fixture.detectChanges();
    expect(console.error).toHaveBeenCalledWith(new Error('Failed to load certifications'));
  });
});
