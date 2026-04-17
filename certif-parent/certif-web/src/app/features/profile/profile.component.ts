// certif-parent/certif-web/src/app/features/profile/profile.component.ts
import {ChangeDetectionStrategy, Component} from "@angular/core";
import {CommonModule} from "@angular/common";

/** Mon profil — implémentation complète Phase 4 */
@Component({
    selector: "app-profile",
    standalone: true,
    imports: [CommonModule],
    changeDetection: ChangeDetectionStrategy.OnPush,
    template: `
    <div class="placeholder container">
      <h1>Mon profil</h1>
      <p class="placeholder__msg">Cette section sera disponible prochainement.</p>
    </div>
  `,
    styles: [`.placeholder { padding: 3rem 1rem; } .placeholder__msg { color: var(--color-text-muted); }`]
})
export class ProfileComponent {
}
