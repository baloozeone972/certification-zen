// certif-parent/certif-web/src/app/features/community/community.component.ts
import { Component, ChangeDetectionStrategy } from "@angular/core";
import { CommonModule } from "@angular/common";

/** Communauté — implémentation complète Phase 4 */
@Component({
  selector: "app-community",
  standalone: true,
  imports: [CommonModule],
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    <div class="placeholder container">
      <h1>Communauté</h1>
      <p class="placeholder__msg">Cette section sera disponible prochainement.</p>
    </div>
  `,
  styles: [`.placeholder { padding: 3rem 1rem; } .placeholder__msg { color: var(--color-text-muted); }`]
})
export class CommunityComponent {}
