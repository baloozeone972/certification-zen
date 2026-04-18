// certif-parent/certif-web/src/app/shared/components/difficulty-badge/difficulty-badge.component.ts
import {ChangeDetectionStrategy, Component, Input} from "@angular/core";
import {CommonModule} from "@angular/common";

/** Colour-coded difficulty badge: easy (green), medium (orange), hard (red). */
@Component({
    selector: "app-difficulty-badge",
    standalone: true,
    imports: [CommonModule],
    changeDetection: ChangeDetectionStrategy.OnPush,
    template: `
    <span class="badge badge-diff" [ngClass]="'badge-diff--' + difficulty">
      {{ labels[difficulty] }}
    </span>
  `,
    styles: [`
    .badge-diff { font-size: .7rem; padding: .2rem .5rem; border-radius: 4px; }
    .badge-diff--easy   { background: #d4edda; color: #155724; }
    .badge-diff--medium { background: #fff3cd; color: #856404; }
    .badge-diff--hard   { background: #f8d7da; color: #721c24; }
  `]
})
export class DifficultyBadgeComponent {
    @Input({required: true}) difficulty: "easy" | "medium" | "hard" = "medium";
    readonly labels = {easy: "Facile", medium: "Moyen", hard: "Difficile"};
}
