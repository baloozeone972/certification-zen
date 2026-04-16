```typescript
import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ScoreWidgetComponent } from './score-widget.component';

describe('ScoreWidgetComponent', () => {
  let component: ScoreWidgetComponent;
  let fixture: ComponentFixture<ScoreWidgetComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ScoreWidgetComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ScoreWidgetComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  describe('when percentage is below passingScore', () => {
    beforeEach(() => {
      component.percentage = 67;
      component.passingScore = 68;
      fixture.detectChanges();
    });

    it('should display the failed class', () => {
      const divElement: HTMLElement = fixture.nativeElement.querySelector('.score-widget');
      expect(divElement.classList.contains('score-widget--failed')).toBeTrue();
    });

    it('should set the ring color to red', () => {
      const circleElement: HTMLElement = fixture.nativeElement.querySelector('.score-widget__ring [attr.stroke]');
      expect(circleElement.getAttribute('stroke')).toBe('#e74c3c');
    });

    it('should calculate the correct dash offset', () => {
      const circleElement: HTMLElement = fixture.nativeElement.querySelector('.score-widget__ring [attr.stroke-dashoffset]');
      expect(parseInt(circleElement.getAttribute('stroke-dashoffset'))).toBe(210);
    });
  });

  describe('when percentage is equal to passingScore', () => {
    beforeEach(() => {
      component.percentage = 68;
      component.passingScore = 68;
      fixture.detectChanges();
    });

    it('should display the passed class', () => {
      const divElement: HTMLElement = fixture.nativeElement.querySelector('.score-widget');
      expect(divElement.classList.contains('score-widget--passed')).toBeTrue();
    });

    it('should set the ring color to green', () => {
      const circleElement: HTMLElement = fixture.nativeElement.querySelector('.score-widget__ring [attr.stroke]');
      expect(circleElement.getAttribute('stroke')).toBe('#27ae60');
    });

    it('should calculate the correct dash offset', () => {
      const circleElement: HTMLElement = fixture.nativeElement.querySelector('.score-widget__ring [attr.stroke-dashoffset]');
      expect(parseInt(circleElement.getAttribute('stroke-dashoffset'))).toBe(0);
    });
  });

  describe('when percentage is above passingScore', () => {
    beforeEach(() => {
      component.percentage = 69;
      component.passingScore = 68;
      fixture.detectChanges();
    });

    it('should display the passed class', () => {
      const divElement: HTMLElement = fixture.nativeElement.querySelector('.score-widget');
      expect(divElement.classList.contains('score-widget--passed')).toBeTrue();
    });

    it('should set the ring color to green', () => {
      const circleElement: HTMLElement = fixture.nativeElement.querySelector('.score-widget__ring [attr.stroke]');
      expect(circleElement.getAttribute('stroke')).toBe('#27ae60');
    });

    it('should calculate the correct dash offset', () => {
      const circleElement: HTMLElement = fixture.nativeElement.querySelector('.score-widget__ring [attr.stroke-dashoffset]');
      expect(parseInt(circleElement.getAttribute('stroke-dashoffset'))).toBe(-14);
    });
  });

  describe('when passingScore is not provided', () => {
    beforeEach(() => {
      component.percentage = 68;
      fixture.detectChanges();
    });

    it('should default to a passing score of 68', () => {
      const divElement: HTMLElement = fixture.nativeElement.querySelector('.score-widget');
      expect(divElement.classList.contains('score-widget--passed')).toBeTrue();
    });
  });

  describe('when percentage is not provided', () => {
    beforeEach(() => {
      component.passingScore = 68;
      fixture.detectChanges();
    });

    it('should display the failed class', () => {
      const divElement: HTMLElement = fixture.nativeElement.querySelector('.score-widget');
      expect(divElement.classList.contains('score-widget--failed')).toBeTrue();
    });
  });

  describe('when percentage is NaN', () => {
    beforeEach(() => {
      component.percentage = NaN;
      component.passingScore = 68;
      fixture.detectChanges();
    });

    it('should display the failed class', () => {
      const divElement: HTMLElement = fixture.nativeElement.querySelector('.score-widget');
      expect(divElement.classList.contains('score-widget--failed')).toBeTrue();
    });
  });
});
```
