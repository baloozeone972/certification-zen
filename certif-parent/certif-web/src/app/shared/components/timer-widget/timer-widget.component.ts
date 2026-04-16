// certif-parent/certif-web/src/app/shared/components/timer-widget/timer-widget.component.ts
import { Component, Input, Output, EventEmitter, OnInit, OnDestroy,
         signal, computed, ChangeDetectionStrategy } from "@angular/core";
import { CommonModule } from "@angular/common";

/**
 * Countdown timer widget.
 * Emits (expired) when the timer reaches zero.
 * Turns red when < 5 minutes remain (300 seconds).
 * Uses Angular 18 Signals — no RxJS timer observable.
 */
@Component({
  selector: "app-timer-widget",
  standalone: true,
  imports: [CommonModule],
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    <div class="timer" [class.timer--warning]="isWarning()" [class.timer--unlimited]="!durationSeconds">
      <span class="timer__icon">⏱</span>
      <span class="timer__display">{{ displayTime() }}</span>
    </div>
  `,
  styles: [`
    .timer { display: flex; align-items: center; gap: .5rem;
             font-size: 1.25rem; font-weight: 700; color: var(--color-primary); }
    .timer--warning { color: var(--color-error); animation: pulse 1s infinite; }
    .timer--unlimited { color: var(--color-text-muted); }
    @keyframes pulse { 0%,100% { opacity: 1; } 50% { opacity: .6; } }
  `]
})
export class TimerWidgetComponent implements OnInit, OnDestroy {
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
