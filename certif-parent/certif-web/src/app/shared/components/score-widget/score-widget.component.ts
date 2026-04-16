// certif-parent/certif-web/src/app/shared/components/score-widget/score-widget.component.ts
import { Component, Input, computed, signal, ChangeDetectionStrategy } from "@angular/core";
import { CommonModule } from "@angular/common";

/**
 * Circular score display widget.
 * Shows percentage with a color-coded ring: green (pass), red (fail).
 */
@Component({
  selector: "app-score-widget",
  standalone: true,
  imports: [CommonModule],
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    <div class="score-widget" [class.score-widget--passed]="passed()" [class.score-widget--failed]="!passed()">
      <svg viewBox="0 0 120 120" class="score-widget__ring">
        <circle cx="60" cy="60" r="50" fill="none" stroke="#e9ecef" stroke-width="10"/>
        <circle cx="60" cy="60" r="50" fill="none"
          [attr.stroke]="ringColor()"
          stroke-width="10"
          stroke-linecap="round"
          stroke-dasharray="314"
          [attr.stroke-dashoffset]="dashOffset()"
          transform="rotate(-90 60 60)"/>
      </svg>
      <div class="score-widget__content">
        <span class="score-widget__pct">{{ percentage | number:'1.0-1' }}%</span>
        <span class="score-widget__label">{{ passed() ? "RÉUSSI ✓" : "ÉCHEC ✗" }}</span>
      </div>
    </div>
  `,
  styles: [`
    .score-widget { position: relative; width: 160px; height: 160px; }
    .score-widget__ring { width: 100%; height: 100%; }
    .score-widget__content {
      position: absolute; inset: 0;
      display: flex; flex-direction: column;
      align-items: center; justify-content: center;
    }
    .score-widget__pct { font-size: 1.75rem; font-weight: 800; }
    .score-widget__label { font-size: .75rem; font-weight: 700; text-transform: uppercase; }
    .score-widget--passed .score-widget__pct,
    .score-widget--passed .score-widget__label { color: var(--color-success); }
    .score-widget--failed .score-widget__pct,
    .score-widget--failed .score-widget__label { color: var(--color-error); }
  `]
})
export class ScoreWidgetComponent {
  @Input({ required: true }) percentage = 0;
  @Input() passingScore = 68;

  readonly passed    = computed(() => this.percentage >= this.passingScore);
  readonly ringColor = computed(() => this.passed() ? "#27ae60" : "#e74c3c");
  readonly dashOffset = computed(() => 314 - (314 * this.percentage / 100));
}
