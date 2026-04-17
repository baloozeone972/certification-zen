// certif-parent/certif-web/src/app/shared/components/question-card/question-card.component.ts
import {ChangeDetectionStrategy, Component, EventEmitter, Input, Output, signal} from "@angular/core";
import {CommonModule} from "@angular/common";
import {Question} from "../../../core/models/exam.models";
import {DifficultyBadgeComponent} from "../difficulty-badge/difficulty-badge.component";

/**
 * Question card component — renders a question with answer options.
 * Emits (answered) with the selected option UUID.
 * In REVISION mode, reveals the correct answer after selection.
 */
@Component({
    selector: "app-question-card",
    standalone: true,
    imports: [CommonModule, DifficultyBadgeComponent],
    changeDetection: ChangeDetectionStrategy.OnPush,
    template: `
    <div class="q-card card">
      <div class="q-card__header">
        <app-difficulty-badge [difficulty]="question.difficulty" />
        <span class="q-card__theme">{{ question.themeCode }}</span>
      </div>

      <p class="q-card__statement" [innerHTML]="question.statement"></p>

      <div class="q-card__options">
        @for (option of question.options; track option.id) {
          <button
            class="q-option"
            [class.q-option--selected]="selectedOptionId() === option.id"
            [class.q-option--correct]="revealMode && correctOptionId === option.id"
            [class.q-option--wrong]="revealMode && selectedOptionId() === option.id && selectedOptionId() !== correctOptionId"
            [disabled]="locked || (revealMode && selectedOptionId() !== null)"
            (click)="selectOption(option.id)">
            <span class="q-option__label">{{ option.label }}</span>
            <span class="q-option__text">{{ option.text }}</span>
          </button>
        }
      </div>
    </div>
  `,
    styles: [`
    .q-card { max-width: 800px; }
    .q-card__header { display: flex; gap: .75rem; align-items: center; margin-bottom: 1rem; }
    .q-card__theme { font-size: .75rem; color: var(--color-text-muted); }
    .q-card__statement { font-size: 1.05rem; line-height: 1.7; margin-bottom: 1.25rem; white-space: pre-wrap; }
    .q-card__options { display: flex; flex-direction: column; gap: .5rem; }
    .q-option {
      display: flex; align-items: flex-start; gap: .75rem;
      padding: .85rem 1rem;
      border: 2px solid var(--color-border);
      border-radius: var(--radius-md);
      background: var(--color-surface);
      cursor: pointer; text-align: left;
      transition: all var(--transition);
      &:hover:not(:disabled) { border-color: var(--color-secondary); background: #f0f7ff; }
      &--selected { border-color: var(--color-secondary); background: #e8f4fd; }
      &--correct  { border-color: var(--color-success)!important; background: #d4edda!important; }
      &--wrong    { border-color: var(--color-error)!important;   background: #f8d7da!important; }
      &:disabled { cursor: default; }
    }
    .q-option__label {
      width: 28px; height: 28px; border-radius: 50%;
      background: var(--color-border); display: flex;
      align-items: center; justify-content: center;
      font-weight: 700; font-size: .8rem; flex-shrink: 0;
    }
    .q-option__text { line-height: 1.5; }
  `]
})
export class QuestionCardComponent {
    @Input({required: true}) question!: Question;
    @Input() locked = false;
    @Input() revealMode = false;
    @Input() correctOptionId?: string;
    @Output() answered = new EventEmitter<string | null>();
    readonly selectedOptionId = signal<string | null>(null);

    @Input() set preselected(val: string | null) {
        this.selectedOptionId.set(val);
    }

    selectOption(optionId: string): void {
        if (this.locked) return;
        this.selectedOptionId.set(optionId);
        this.answered.emit(optionId);
    }
}
