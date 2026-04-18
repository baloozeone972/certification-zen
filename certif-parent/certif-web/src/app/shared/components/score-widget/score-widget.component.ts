import {ComponentFixture, TestBed} from '@angular/core/testing';
import {By} from '@angular/platform-browser';
import {ScoreWidgetComponent} from './score-widget.component';

describe('ScoreWidgetComponent', () => {
    let component: ScoreWidgetComponent;
    let fixture: ComponentFixture<ScoreWidgetComponent>;

    beforeEach(async () => {
        await TestBed.configureTestingModule({
            declarations: [ScoreWidgetComponent],
        }).compileComponents();
    });

    beforeEach(() => {
        fixture = TestBed.createComponent(ScoreWidgetComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should display passed status with green color', () => {
        component.percentage = 70;
        fixture.detectChanges();
        const ringColor = fixture.debugElement.query(By.css('circle[stroke="#27ae60"]'));
        expect(ringColor).toBeTruthy();
    });

    it('should display failed status with red color', () => {
        component.percentage = 65;
        fixture.detectChanges();
        const ringColor = fixture.debugElement.query(By.css('circle[stroke="#e74c3c"]'));
        expect(ringColor).toBeTruthy();
    });

    it('should display percentage correctly', () => {
        component.percentage = 75;
        fixture.detectChanges();
        const pctElement = fixture.debugElement.query(By.css('.score-widget__pct'));
        expect(pctElement.nativeElement.textContent).toContain('75.0%');
    });

    it('should display passed label when percentage is above passing score', () => {
        component.percentage = 70;
        fixture.detectChanges();
        const labelElement = fixture.debugElement.query(By.css('.score-widget__label'));
        expect(labelElement.nativeElement.textContent).toContain('RÉUSSI ✓');
    });

    it('should display failed label when percentage is below passing score', () => {
        component.percentage = 65;
        fixture.detectChanges();
        const labelElement = fixture.debugElement.query(By.css('.score-widget__label'));
        expect(labelElement.nativeElement.textContent).toContain('ÉCHEC ✗');
    });
});