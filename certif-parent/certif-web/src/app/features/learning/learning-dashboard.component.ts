// certif-parent/certif-web/src/app/features/learning/learning-dashboard.component.ts
import {ChangeDetectionStrategy, Component, inject, OnInit} from "@angular/core";
import {RouterLink} from "@angular/router";
import {CommonModule} from "@angular/common";
import {CertificationService} from "../../core/services/certification.service";
import {LearningService} from "../../core/services/learning.service";

@Component({
    selector: "app-learning-dashboard",
    standalone: true,
    imports: [CommonModule, RouterLink],
    changeDetection: ChangeDetectionStrategy.OnPush,
    template: `
    <div class="learn container">
      <h1>Mes révisions</h1>
      <div class="learn__grid">
        @for (cert of certService.certifications(); track cert.id) {
          <div class="learn-card card">
            <h3>{{ cert.name }}</h3>
            <p class="learn-card__code">{{ cert.code }}</p>
            <div class="learn-card__actions">
              <a [routerLink]="["/learning/flashcards", cert.id]" class="btn btn-primary">
                🃏 Flashcards SM-2
              </a>
            </div>
          </div>
        }
      </div>
    </div>
  `,
    styles: [`
    .learn { padding: 2rem 1rem; }
    .learn h1 { font-size: 1.75rem; margin-bottom: 1.5rem; }
    .learn__grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(260px,1fr)); gap: 1.25rem; }
    .learn-card h3 { margin-bottom: .25rem; }
    .learn-card__code { font-size: .85rem; color: var(--color-text-muted); margin-bottom: 1rem; }
    .learn-card__actions { display: flex; flex-direction: column; gap: .5rem; }
    .learn-card__actions .btn { justify-content: center; }
  `]
})
export class LearningDashboardComponent implements OnInit {
    readonly certService = inject(CertificationService);
    private readonly learningService = inject(LearningService);

    ngOnInit(): void {
        this.certService.loadAll().subscribe();
    }
}
