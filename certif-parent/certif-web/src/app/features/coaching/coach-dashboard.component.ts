// certif-parent/certif-web/src/app/features/coaching/coach-dashboard.component.ts
import { Component, OnInit, inject, signal, ChangeDetectionStrategy } from "@angular/core";
import { CommonModule, DecimalPipe } from "@angular/common";
import { RouterLink } from "@angular/router";
import { HttpClient } from "@angular/common/http";
import { AuthService } from "../../core/auth/auth.service";
import { environment } from "../../../environments/environment";
import { map } from "rxjs";

interface WeeklyReport {
  weekLabel: string;
  certificationId: string;
  totalSessions: number;
  averageScore: number;
  strongThemes: string[];
  weakThemes: string[];
  recommendedActions: string[];
  predictedPassDate?: string;
}

interface AdaptivePlan {
  certificationId: string;
  dueTodayCount: number;
  weakThemes: string[];
  predictedScore?: number;
  recommendedExamDate?: string;
}

@Component({
  selector: "app-coach-dashboard",
  standalone: true,
  imports: [CommonModule, RouterLink, DecimalPipe],
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    <div class="coach container">
      <div class="coach__header">
        <h1>🎓 Coach IA</h1>
        @if (!authService.isPro()) {
          <div class="coach__paywall card">
            <p>Le Coach IA est disponible avec l'abonnement <strong>Pro</strong>.</p>
            <a routerLink="/profile" class="btn btn-primary">Passer à Pro</a>
          </div>
        }
      </div>

      @if (authService.isPro()) {
        <!-- Plan adaptatif -->
        @if (plan()) {
          <div class="card coach__plan">
            <h2>📅 Plan du jour</h2>
            <div class="coach__plan-grid">
              <div class="coach__stat">
                <span class="coach__stat-value">{{ plan()!.dueTodayCount }}</span>
                <span class="coach__stat-label">flashcards à réviser</span>
              </div>
              @if (plan()!.predictedScore) {
                <div class="coach__stat">
                  <span class="coach__stat-value">{{ plan()!.predictedScore | number:'1.0-0' }}%</span>
                  <span class="coach__stat-label">score prédit</span>
                </div>
              }
              @if (plan()!.recommendedExamDate) {
                <div class="coach__stat">
                  <span class="coach__stat-value">{{ plan()!.recommendedExamDate }}</span>
                  <span class="coach__stat-label">date d'examen conseillée</span>
                </div>
              }
            </div>
            @if (plan()!.weakThemes.length) {
              <div class="coach__weak">
                <strong>Thèmes à renforcer :</strong>
                <div class="coach__tags">
                  @for (t of plan()!.weakThemes; track t) {
                    <span class="badge badge-warning">{{ t }}</span>
                  }
                </div>
              </div>
            }
            <div class="coach__actions">
              <a routerLink="/learning" class="btn btn-primary">📚 Réviser maintenant</a>
              <a routerLink="/exam" class="btn btn-secondary">📝 Examen blanc</a>
            </div>
          </div>
        } @else if (loading()) {
          <div class="card">Chargement du plan...</div>
        }

        <!-- Rapport hebdomadaire -->
        @if (report()) {
          <div class="card coach__report" style="margin-top:1.5rem">
            <h2>📊 Rapport — {{ report()!.weekLabel }}</h2>
            <div class="coach__plan-grid">
              <div class="coach__stat">
                <span class="coach__stat-value">{{ report()!.totalSessions }}</span>
                <span class="coach__stat-label">sessions cette semaine</span>
              </div>
              <div class="coach__stat">
                <span class="coach__stat-value">{{ report()!.averageScore | number:'1.0-1' }}%</span>
                <span class="coach__stat-label">score moyen</span>
              </div>
            </div>

            @if (report()!.strongThemes.length) {
              <div class="coach__weak" style="margin-top:1rem">
                <strong>✅ Points forts :</strong>
                <div class="coach__tags">
                  @for (t of report()!.strongThemes; track t) {
                    <span class="badge badge-success">{{ t }}</span>
                  }
                </div>
              </div>
            }

            @if (report()!.weakThemes.length) {
              <div class="coach__weak" style="margin-top:.75rem">
                <strong>⚠️ À améliorer :</strong>
                <div class="coach__tags">
                  @for (t of report()!.weakThemes; track t) {
                    <span class="badge badge-warning">{{ t }}</span>
                  }
                </div>
              </div>
            }

            @if (report()!.recommendedActions.length) {
              <div style="margin-top:1rem">
                <strong>💡 Recommandations du coach :</strong>
                <ul style="margin-top:.5rem;padding-left:1.5rem;color:var(--color-text-muted)">
                  @for (action of report()!.recommendedActions; track action) {
                    <li style="margin-bottom:.35rem">{{ action }}</li>
                  }
                </ul>
              </div>
            }
          </div>
        }
      }
    </div>
  `,
  styles: [`
    .coach { padding: 2rem 1rem; max-width: 900px; }
    .coach__header { display: flex; align-items: flex-start; justify-content: space-between;
                      flex-wrap: wrap; gap: 1rem; margin-bottom: 1.5rem; }
    .coach__header h1 { font-size: 1.75rem; margin: 0; }
    .coach__paywall { background: #fff3cd; border-left: 4px solid var(--color-warning); }
    .coach__paywall p { margin-bottom: 1rem; }
    .coach__plan-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(140px,1fr));
                         gap: 1rem; margin-bottom: 1rem; }
    .coach__stat { text-align: center; padding: 1rem;
                    background: var(--color-bg); border-radius: var(--radius-md); }
    .coach__stat-value { display: block; font-size: 2rem; font-weight: 800;
                          color: var(--color-secondary); }
    .coach__stat-label { display: block; font-size: .8rem; color: var(--color-text-muted);
                          margin-top: .25rem; }
    .coach__weak { margin-top: .75rem; }
    .coach__tags { display: flex; flex-wrap: wrap; gap: .5rem; margin-top: .35rem; }
    .coach__actions { display: flex; gap: 1rem; margin-top: 1.25rem; flex-wrap: wrap; }
  `]
})
export class CoachDashboardComponent implements OnInit {
  readonly authService = inject(AuthService);
  private readonly http = inject(HttpClient);

  readonly plan    = signal<AdaptivePlan | null>(null);
  readonly report  = signal<WeeklyReport | null>(null);
  readonly loading = signal(true);

  ngOnInit(): void {
    if (!this.authService.isPro()) return;
    const base = `${environment.apiUrl}/learning`;
    this.http.get<{ data: AdaptivePlan }>(`${base}/adaptive-plan`)
      .pipe(map(r => r.data))
      .subscribe({ next: p => { this.plan.set(p); this.loading.set(false); },
                   error: () => this.loading.set(false) });
    this.http.get<{ data: WeeklyReport }>(`${environment.apiUrl}/coaching/weekly-report`)
      .pipe(map(r => r.data))
      .subscribe({ next: r => this.report.set(r), error: () => {} });
  }
}
