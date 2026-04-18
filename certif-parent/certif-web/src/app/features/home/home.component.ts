import {ComponentFixture, TestBed, async} from '@angular/core/testing';
import {RouterTestingModule} from '@angular/router/testing';
import {CommonModule} from '@angular/common';
import {CertificationService} from '../../core/services/certification.service';
import {AuthService} from '../../core/auth/auth.service';
import {HomeComponent} from './home.component';

describe('HomeComponent', () => {
    let component: HomeComponent;
    let fixture: ComponentFixture<HomeComponent>;
    let certificationServiceMock: CertificationService;
    let authServiceMock: AuthService;

    beforeEach(async(() => {
        certificationServiceMock = jasmine.createSpyObj('CertificationService', ['loadAll']);
        authServiceMock = jasmine.createSpyObj('AuthService', ['isAuthenticated']);

        TestBed.configureTestingModule({
            imports: [RouterTestingModule, CommonModule],
            declarations: [HomeComponent],
            providers: [
                {provide: CertificationService, useValue: certificationServiceMock},
                {provide: AuthService, useValue: authServiceMock}
            ]
        }).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(HomeComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });

    it('should display the hero section when not authenticated', () => {
        authServiceMock.isAuthenticated.and.returnValue(false);
        fixture.detectChanges();
        const heroSection = fixture.nativeElement.querySelector('.hero');
        expect(heroSection).toBeTruthy();
    });

    it('should display the catalogue section when authenticated', () => {
        authServiceMock.isAuthenticated.and.returnValue(true);
        fixture.detectChanges();
        const catalogueSection = fixture.nativeElement.querySelector('.catalogue');
        expect(catalogueSection).toBeTruthy();
    });

    it('should call loadAll on CertificationService in ngOnInit', () => {
        authServiceMock.isAuthenticated.and.returnValue(true);
        fixture.detectChanges();
        expect(certificationServiceMock.loadAll).toHaveBeenCalled();
    });
});