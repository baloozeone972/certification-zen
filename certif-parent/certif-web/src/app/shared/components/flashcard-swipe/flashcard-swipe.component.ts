// certif-parent/certif-web/src/app/shared/components/flashcard-swipe/flashcard-swipe.component.ts
import {ChangeDetectionStrategy, Component, EventEmitter, Input, Output, signal} from "@angular/core";
import {CommonModule} from "@angular/common";
import {Flashcard} from "../../../core/models/learning.models";

/**
 * Flashcard swipe component for SM-2 review.
 * Click to flip, then rate 0-5 using the buttons.
 * Emits (rated) with the SM-2 quality rating.
 */
@Component({
    selector: "app-flashcard-swipe",
    standalone: true,
    imports: [CommonModule],
    changeDetection: ChangeDetectionStrategy.OnPush,
    template: `
    <div class="fc-container">
      <div class="fc-card" [class.fc-card--flipped]="flipped()" (click)="flip()">
        <div class="fc-front">
          <p>{{ flashcard.frontText }}</p>
          <span class="fc-hint">Cliquer pour voir la réponse</span>
        </div>
        <div class="fc-back">
          <p>{{ flashcard.backText }}</p>
          @if (flashcard.codeExample) {
            <pre><code>{{ flashcard.codeExample }}</code></pre>
          }
        </div>
      </div>

      @if (flipped()) {
        <div class="fc-ratings">
          <p class="fc-ratings__label">Quelle facilité ?</p>
          <div class="fc-ratings__buttons">
            @for (btn of ratingButtons; track btn.value) {
              <button class="fc-btn" [class]="'fc-btn--' + btn.color"
                      (click)="rate(btn.value)">
                {{ btn.label }}
              </button>
            }
          </div>
        </div>
      }
    </div>
  `,
    styles: [`
    .fc-container { display: flex; flex-direction: column; align-items: center; gap: 1.5rem; }
    .fc-card {
      width: 100%; max-width: 600px; min-height: 200px;
      perspective: 1000px; cursor: pointer;
      position: relative;
    }
    .fc-front, .fc-back {
      position: absolute; inset: 0;
      padding: 2rem; border-radius: var(--radius-lg);
      box-shadow: var(--shadow-md);
      display: flex; flex-direction: column; justify-content: center;
      backface-visibility: hidden;
      transition: transform 0.5s;
    }
    .fc-front { background: var(--color-surface); font-size: 1.1rem; }
    .fc-back  { background: #f0f7ff; transform: rotateY(180deg); }
    .fc-card--flipped .fc-front { transform: rotateY(180deg); }
    .fc-card--flipped .fc-back  { transform: rotateY(0deg); }
    .fc-hint { font-size: .75rem; color: var(--color-text-muted); margin-top: auto; }
    .fc-ratings { width: 100%; max-width: 600px; }
    .fc-ratings__label { text-align: center; font-weight: 600; margin-bottom: .75rem; }
    .fc-ratings__buttons { display: flex; gap: .5rem; justify-content: center; flex-wrap: wrap; }
    .fc-btn { padding: .5rem 1rem; border: none; border-radius: var(--radius-md);
               cursor: pointer; font-weight: 600; font-size: .875rem; }
    .fc-btn--red    { background: #f8d7da; color: #721c24; }
    .fc-btn--orange { background: #fff3cd; color: #856404; }
    .fc-btn--yellow { background: #fef9c3; color: #713f12; }
    .fc-btn--green  { background: #d4edda; color: #155724; }
  `]
})
export class FlashcardSwipeComponent {
    @Input({required: true}) flashcard!: Flashcard;
    @Output() rated = new EventEmitter<number>();

    readonly flipped = signal(false);

    readonly ratingButtons = [
        {value: 0, label: "0 — Oublié", color: "red"},
        {value: 1, label: "1 — Difficile", color: "orange"},
        {value: 3, label: "3 — Correct", color: "yellow"},
        {value: 4, label: "4 — Facile", color: "green"},
        {value: 5, label: "5 — Parfait", color: "green"}
    ];

    flip(): void {
        this.flipped.set(!this.flipped());
    }

    rate(value: number): void {
        this.rated.emit(value);
        this.flipped.set(false);
    }
}
