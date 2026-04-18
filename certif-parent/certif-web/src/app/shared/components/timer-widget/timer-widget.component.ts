import { ComponentFixture, TestBed, async, fakeAsync, tick } from '@angular/core/testing';
import { By } from '@angular/platform-browser';
import { TimerWidgetComponent } from './timer-widget.component';

describe('TimerWidgetComponent', () => {
    let component: TimerWidgetComponent;
    let fixture: ComponentFixture<TimerWidgetComponent>;

    beforeEach(async(() => {
        TestBed.configureTestingModule({
            declarations: [TimerWidgetComponent],
        }).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(TimerWidgetComponent);
        component = fixture.componentInstance;
    });

    it('should display "Illimité" when durationSeconds is 0', () => {
        component.durationSeconds = 0;
        fixture.detectChanges();
        const displayTimeElement = fixture.debugElement.query(By.css('.timer__display'));
        expect(displayTimeElement.nativeElement.textContent).toBe('Illimité');
    });

    it('should display the correct time format when durationSeconds is greater than 0', () => {
        component.durationSeconds = 3661;
        fixture.detectChanges();
        const displayTimeElement = fixture.debugElement.query(By.css('.timer__display'));
        expect(displayTimeElement.nativeElement.textContent).toBe('01:01:01');
    });

    it('should emit expired event when timer reaches zero', fakeAsync(() => {
        component.durationSeconds = 1;
        fixture.detectChanges();
        const expiredSpy = spyOn(component.expired, 'emit');
        tick(1000);
        expect(expiredSpy).toHaveBeenCalled();
    }));

    it('should turn red when less than 5 minutes remain', () => {
        component.durationSeconds = 301;
        fixture.detectChanges();
        const timerElement = fixture.debugElement.query(By.css('.timer'));
        expect(timerElement.nativeElement.classList).toContain('timer--warning');
    });

    it('should not turn red when more than or equal to 5 minutes remain', () => {
        component.durationSeconds = 300;
        fixture.detectChanges();
        const timerElement = fixture.debugElement.query(By.css('.timer'));
        expect(timerElement.nativeElement.classList).not.toContain('timer--warning');
    });

    it('should clear interval on destroy', () => {
        component.durationSeconds = 1;
        fixture.detectChanges();
        const intervalId = component.intervalId;
        expect(intervalId).toBeDefined();
        component.ngOnDestroy();
        expect(component.intervalId).toBeUndefined();
    });
});