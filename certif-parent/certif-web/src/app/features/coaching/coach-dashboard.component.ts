// certif-parent/certif-web/src/app/features/coaching/coach-dashboard.component.ts
import { Component, ChangeDetectionStrategy } from "@angular/core";
import { CommonModule } from "@angular/common";

/** Coach IA — implémentation complète Phase 4 */
@Component({
  selector: "app-coach-dashboard",
  standalone: true,
  imports: [CommonModule],
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    <div class="placeholder container">
      <h1>Coach IA</h1>
      <p class="placeholder__msg">Cette section sera disponible prochainement.</p>
    </div>
  `,
  styles: [`.placeholder { padding: 3rem 1rem; } .placeholder__msg { color: var(--color-text-muted); }`]
})
export class CoachDashboardComponent {}
