// certif-parent/certif-web/src/app/features/results/results.component.ts
import {ChangeDetectionStrategy, Component, inject, OnInit, signal} from "@angular/core";
import {ActivatedRoute, RouterLink} from "@angular/router";
import {CommonModule, DecimalPipe} from "@angular/common";
import {ExamService} from "../../core/services/exam.service";
import {ExamResult} from "../../core/models/exam.models";
import {ScoreWidgetComponent} from "../../shared/components/score-widget/score-widget.component";
import {DurationPipe} from "../../shared/pipes/duration.pipe";

@Component({
    selector: "app-results",
    standalone: true,
    imports: [CommonModule, RouterLink, ScoreWidgetComponent, DurationPipe, DecimalPipe],
    changeDetection: ChangeDetectionStrategy.OnPush,
    template: `
    <div class="results container">
      @if (result()) {
        <div class="results__hero" [class.results__hero--pass]="result()!.passed"
                                    [class.results__hero--fail]="!result()!.passed">
          <app-score-widget [percentage]="result()!.percentage"
                            [passingScore]="68" />
          <div class="results__summary">
            <h1>{{ result()!.passed ? "Félicitations ! 🎉" : "Continuez vos efforts 💪" }}</h1>
            <p>{{ result()!.correctCount }} / {{ result()!.totalQuestions }} questions correctes</p>
            <p>Durée : {{ result()!.durationSeconds | duration }}</p>
          </div>
        </div>

        <div class="results__themes card">
          <h2>Résultats par thème</h2>
          <table class="theme-table">
            <thead>
              <tr><th>Thème</th><th>Correct</th><th>Faux</th><th>Score</th></tr>
            </thead>
            <tbody>
              @for (t of result()!.themeStats; track t.themeCode) {
                <tr>
                  <td>{{ t.themeLabel }}</td>
                  <td>{{ t.correct }}</td>
                  <td>{{ t.wrong }}</td>
                  <td>
                    <span class="badge" [class.badge-success]="t.percentage >= 68"
                                         [class.badge-danger]="t.percentage < 68">
                      {{ t.percentage | number:"1.0-1" }}%
                    </span>
                  </td>
                </tr>
              }
            </tbody>
          </table>
        </div>

        <div class="results__actions">
          <a routerLink="/exam" class="btn btn-primary">Nouvel examen</a>
          <a routerLink="/history" class="btn btn-secondary">Historique</a>
          <button class="btn" (click)="exportPdf()">📄 Exporter PDF</button>
        </div>
      } @else {
        <p>Chargement des résultats...</p>
      }
    </div>
  `,
    styles: [`
    .results { padding: 2rem 1rem; max-width: 900px; }
    .results__hero { display: flex; gap: 2rem; align-items: center; padding: 2rem;
                      border-radius: var(--radius-lg); margin-bottom: 2rem; flex-wrap: wrap; }
    .results__hero--pass { background: #d4edda; }
    .results__hero--fail { background: #f8d7da; }
    .results__summary h1 { font-size: 1.75rem; margin-bottom: .5rem; }
    .results__summary p  { color: var(--color-text-muted); }
    .theme-table { width: 100%; border-collapse: collapse; margin-top: 1rem; }
    .theme-table th, .theme-table td { padding: .75rem 1rem; text-align: left;
                                         border-bottom: 1px solid var(--color-border); }
    .theme-table th { font-weight: 700; color: var(--color-text-muted); font-size: .85rem; }
    .results__actions { display: flex; gap: 1rem; margin-top: 2rem; flex-wrap: wrap; }
  `]
})
export class ResultsComponent implements OnInit {
    readonly result = signal<ExamResult | null>(null);
    private readonly examService = inject(ExamService);
    private readonly route = inject(ActivatedRoute);

    ngOnInit(): void {
        const id = this.route.snapshot.paramMap.get("sessionId") ?? "";
        this.examService.getResults(id).subscribe(r => this.result.set(r));
    }

    exportPdf(): void {
        const id = this.result()?.sessionId;
        if (!id) return;
        this.examService.exportPdf(id).subscribe(blob => {
            const url = URL.createObjectURL(blob);
            const a = document.createElement("a");
            a.href = url;
            a.download = `results-${id}.pdf`;
            a.click();
            URL.revokeObjectURL(url);
        });
    }
}
