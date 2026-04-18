// certif-parent/certif-web/src/app/features/history/history.component.ts
import {ChangeDetectionStrategy, Component, inject, OnInit, signal} from "@angular/core";
import {RouterLink} from "@angular/router";
import {CommonModule, DecimalPipe} from "@angular/common";
import {ExamService} from "../../core/services/exam.service";
import {ExamSessionSummary} from "../../core/models/exam.models";
import {DurationPipe} from "../../shared/pipes/duration.pipe";

@Component({
    selector: "app-history",
    standalone: true,
    imports: [CommonModule, RouterLink, DurationPipe, DecimalPipe],
    changeDetection: ChangeDetectionStrategy.OnPush,
    template: `
    <div class="history container">
      <h1>Historique des examens</h1>
      @if (sessions().length === 0) {
        <div class="history__empty card">
          <p>Aucun examen terminé pour le moment.</p>
          <a routerLink="/exam" class="btn btn-primary">Commencer un examen</a>
        </div>
      } @else {
        <div class="history__list">
          @for (s of sessions(); track s.id) {
            <div class="history-row card">
              <div class="history-row__info">
                <strong>{{ s.certificationId | uppercase }}</strong>
                <span class="badge" [class.badge-info]="true">{{ s.mode }}</span>
              </div>
              <div class="history-row__stats">
                <span>{{ s.correctCount }}/{{ s.totalQuestions }}</span>
                <span>{{ s.percentage | number:"1.0-1" }}%</span>
                <span>{{ s.durationSeconds | duration }}</span>
              </div>
              <span class="badge" [class.badge-success]="s.passed" [class.badge-danger]="!s.passed">
                {{ s.passed ? "Réussi" : "Échec" }}
              </span>
              <a [routerLink]="["/results", s.id]" class="btn">Voir détails</a>
            </div>
          }
        </div>
      }
    </div>
  `,
    styles: [`
    .history { padding: 2rem 1rem; max-width: 900px; }
    .history h1 { font-size: 1.75rem; margin-bottom: 1.5rem; }
    .history__list { display: flex; flex-direction: column; gap: 1rem; }
    .history-row { display: flex; align-items: center; gap: 1.5rem; flex-wrap: wrap; }
    .history-row__info { display: flex; align-items: center; gap: .75rem; flex: 1; }
    .history-row__stats { display: flex; gap: 1rem; color: var(--color-text-muted); font-size: .9rem; }
    .history__empty { text-align: center; padding: 3rem; }
    .history__empty p { margin-bottom: 1rem; color: var(--color-text-muted); }
  `]
})
export class HistoryComponent implements OnInit {
    readonly sessions = signal<ExamSessionSummary[]>([]);
    private readonly examService = inject(ExamService);

    ngOnInit(): void {
        this.examService.getHistory().subscribe(s => this.sessions.set(s));
    }
}
