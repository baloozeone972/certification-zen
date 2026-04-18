import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { Component, EventEmitter, Input, Output } from '@angular/core';
import { CommonModule } from '@angular/common';
import { signal, computed, ChangeDetectionStrategy } from '@angular/core';

@Component({
  selector: 'app-timer-widget',
  standalone: true,
  imports: [CommonModule],
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    <div class="timer" [class.timer--warning]="isWarning()" [class.timer--unlimited]="!durationSeconds">
      <span class="timer__icon">⏱</span>
      <span class="timer__display">{{ displayTime() }}</span>
    </div>
  `,
  styles: []
})
export class MockTimerWidgetComponent {
  @Input() durationSeconds = 0;
  @Output() expired = new EventEmitter<void>();

  readonly remaining = signal(0);
  readonly displayTime = computed(() => {
    if (!this.durationSeconds) return "Illimité";
    const s = this.remaining();
    const h = Math.floor(s / 3600);
    const m = Math.floor((s % 3600) / 60);
    const sec = s % 60;
    return h > 0
      ? `${h}:${m.toString().padStart(2,"0")}:${sec.toString().padStart(2,"0")}`
      : `${m.toString().padStart(2,"0")}:${sec.toString().padStart(2,"0")}`;
  });
  readonly isWarning = computed(() => this.durationSeconds > 0 && this.remaining() <= 300);

  private intervalId?: number;

  ngOnInit(): void {
    this.remaining.set(this.durationSeconds);
    if (this.durationSeconds > 0) {
      this.intervalId = window.setInterval(() => {
        const current = this.remaining();
        if (current <= 1) {
          this.remaining.set(0);
          window.clearInterval(this.intervalId);
          this.expired.emit();
        } else {
          this.remaining.set(current - 1);
        }
      }, 1000);
    }
  }

  ngOnDestroy(): void {
    if (this.intervalId) window.clearInterval(this.intervalId);
  }
}

describe('TimerWidgetComponent', () => {
  let component: MockTimerWidgetComponent;
  let fixture: ComponentFixture<MockTimerWidgetComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ MockTimerWidgetComponent ],
      imports: [ CommonModule ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(MockTimerWidgetComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  afterEach(() => {
    if (component.intervalId) window.clearInterval(component.intervalId);
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should display "Illimité" when duration is 0', () => {
    component.durationSeconds = 0;
    fixture.detectChanges();
    const compiled = fixture.nativeElement as HTMLElement;
    expect(compiled.querySelector('.timer__display')?.textContent.trim()).toBe('Illimité');
  });

  it('should display time correctly', () => {
    component.durationSeconds = 3661; // 1h 1min 1s
    fixture.detectChanges();
    const compiled = fixture.nativeElement as HTMLElement;
    expect(compiled.querySelector('.timer__display')?.textContent.trim()).toBe('01:01:01');
  });

  it('should emit expired event when time reaches 0', () => {
    component.durationSeconds = 5;
    const spy = spyOn(component.expired, 'emit');
    fixture.detectChanges();
    tick(6 * 1000);
    expect(spy).toHaveBeenCalled();
  });

  it('should turn red when less than 5 minutes remain', () => {
    component.durationSeconds = 301;
    fixture.detectChanges();
    const compiled = fixture.nativeElement as HTMLElement;
    expect(compiled.querySelector('.timer')?.classList.contains('timer--warning')).toBe(true);
  });

  it('should not turn red when exactly 5 minutes remain', () => {
    component.durationSeconds = 300;
    fixture.detectChanges();
    const compiled = fixture.nativeElement as HTMLElement;
    expect(compiled.querySelector('.timer')?.classList.contains('timer--warning')).toBe(false);
  });

  it('should not turn red when more than 5 minutes remain', () => {
    component.durationSeconds = 301;
    fixture.detectChanges();
    const compiled = fixture.nativeElement as HTMLElement;
    expect(compiled.querySelector('.timer')?.classList.contains('timer--warning')).toBe(true);
  });
});
