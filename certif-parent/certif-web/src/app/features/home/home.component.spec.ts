import { ComponentFixture, TestBed } from '@angular/core/testing';
import { CertificationService } from '../../core/services/certification.service';
import { AuthService } from '../../core/auth/auth.service';
import { Certification } from '../../core/models/certification.models';
import { HomeComponent } from './home.component';

describe('HomeComponent', () => {
  let component: HomeComponent;
  let fixture: ComponentFixture<HomeComponent>;
  let authServiceSpy: jasmine.SpyObj<AuthService>;
  let certServiceSpy: jasmine.SpyObj<CertificationService>;

  beforeEach(async () => {
    authServiceSpy = jasmine.createSpyObj('AuthService', ['isAuthenticated']);
    certServiceSpy = jasmine.createSpyObj('CertificationService', ['loadAll']);

    await TestBed.configureTestingModule({
      imports: [HomeComponent],
      providers: [
        { provide: AuthService, useValue: authServiceSpy },
        { provide: CertificationService, useValue: certServiceSpy }
      ]
    }).compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(HomeComponent);
    component = fixture.componentInstance;
    authServiceSpy.isAuthenticated.and.returnValue(false);
    certServiceSpy.loadAll.and.returnValue(Promise.resolve());
  });

  afterEach(() => {
    fixture.destroy();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  describe('ngOnInit', () => {
    it('should call loadAll from CertificationService', () => {
      component.ngOnInit();
      expect(certServiceSpy.loadAll).toHaveBeenCalledOnceWith();
    });
  });

  describe('Template tests', () => {
    it('should display hero section when not authenticated', () => {
      authServiceSpy.isAuthenticated.and.returnValue(false);
      fixture.detectChanges();
      const heroSection = fixture.nativeElement.querySelector('.hero');
      expect(heroSection).toBeTruthy();
    });

    it('should display catalogue section when authenticated', () => {
      authServiceSpy.isAuthenticated.and.returnValue(true);
      certServiceSpy.certifications.set([
        { id: 1, name: 'Certification A', code: 'A123', totalQuestions: 50, passingScore: 75, examDurationMin: 60 } as Certification
      ]);
      fixture.detectChanges();
      const catalogueSection = fixture.nativeElement.querySelector('.catalogue');
      expect(catalogueSection).toBeTruthy();
    });

    it('should display loading state while loading certifications', () => {
      certServiceSpy.loading.set(true);
      fixture.detectChanges();
      const loadingElement = fixture.nativeElement.querySelector('.catalogue__loading');
      expect(loadingElement).toBeTruthy();
    });

    it('should not display catalogue section when loading certifications', () => {
      certServiceSpy.loading.set(true);
      fixture.detectChanges();
      const catalogueSection = fixture.nativeElement.querySelector('.catalogue');
      expect(catalogueSection).toBeFalsy();
    });
  });
});
