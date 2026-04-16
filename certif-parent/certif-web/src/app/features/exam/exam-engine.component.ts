// certif-parent/certif-web/src/app/features/exam/exam-engine.component.ts
import { Component, OnInit, inject, signal, computed, ChangeDetectionStrategy } from "@angular/core";
import { ActivatedRoute, Router } from "@angular/router";
import { CommonModule } from "@angular/common";
import { ExamService } from "../../core/services/exam.service";
import { ExamSession, Question } from "../../core/models/exam.models";
import { QuestionCardComponent } from "../../shared/components/question-card/question-card.component";
import { TimerWidgetComponent } from "../../shared/components/timer-widget/timer-widget.component";

/**
 * Main exam engine — navigates through questions,
 * submits answers in real time, finalises the session.
 */
@Component({
  selector: "app-exam-engine",
  standalone: true,
  imports: [CommonModule, QuestionCardComponent, TimerWidgetComponent],
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    <div class="engine">
      @if (session()) {
        <header class="engine__header">
          <div class="engine__progress">
            <span>{{ currentIndex() + 1 }} / {{ session()!.questions.length }}</span>
            <div class="progress-bar">
              <div class="progress-bar__fill"
                   [style.width.%]="(currentIndex() / session()!.questions.length) * 100"></div>
            </div>
          </div>
          <app-timer-widget [durationSeconds]="session()!.durationSeconds"
                            (expired)="onTimerExpired()" />
        </header>

        <div class="engine__question container">
          <app-question-card
            [question]="currentQuestion()"
            [revealMode]="session()!.mode === 'REVISION'"
            [correctOptionId]="answers().get(currentQuestion().id)"
            (answered)="onAnswered($event)" />
        </div>

        <footer class="engine__footer">
          <button class="btn" (click)="skipQuestion()">Passer →</button>
          @if (currentIndex() === session()!.questions.length - 1) {
            <button class="btn btn-primary" [disabled]="submitting()" (click)="submitExam()">
              {{ submitting() ? "Envoi..." : "Terminer l'examen ✓" }}
            </button>
          } @else {
            <button class="btn btn-secondary" (click)="nextQuestion()">Question suivante →</button>
          }
        </footer>
      } @else {
        <div class="engine__loading">Chargement de la session...</div>
      }
    </div>
  `,
  styles: [`
    .engine { display: flex; flex-direction: column; min-height: calc(100vh - 60px); }
    .engine__header { padding: 1rem 2rem; background: var(--color-surface);
                       border-bottom: 1px solid var(--color-border);
                       display: flex; align-items: center; justify-content: space-between; gap: 2rem; }
    .engine__progress { display: flex; align-items: center; gap: 1rem; flex: 1; }
    .progress-bar { flex: 1; height: 6px; background: var(--color-border); border-radius: 3px; }
    .progress-bar__fill { height: 100%; background: var(--color-secondary);
                           border-radius: 3px; transition: width .3s; }
    .engine__question { flex: 1; padding: 2rem 1rem; display: flex; justify-content: center; }
    .engine__footer { padding: 1.5rem 2rem; background: var(--color-surface);
                       border-top: 1px solid var(--color-border);
                       display: flex; justify-content: flex-end; gap: 1rem; }
    .engine__loading { display: flex; align-items: center; justify-content: center;
                        flex: 1; font-size: 1.1rem; color: var(--color-text-muted); }
  `]
})
export class ExamEngineComponent implements OnInit {
  private readonly examService = inject(ExamService);
  private readonly route       = inject(ActivatedRoute);
  private readonly router      = inject(Router);

  readonly session      = signal<ExamSession | null>(null);
  readonly currentIndex = signal(0);
  readonly answers      = signal<Map<string, string>>(new Map());
  readonly submitting   = signal(false);
  readonly startTime    = signal(Date.now());

  readonly currentQuestion = computed<Question>(() =>
    this.session()!.questions[this.currentIndex()]
  );

  ngOnInit(): void {
    const sessionId = this.route.snapshot.paramMap.get("sessionId") ?? "";
    this.examService.getResults(sessionId).subscribe(s => this.session.set(s as any));
  }

  onAnswered(optionId: string | null): void {
    if (!optionId) return;
    const qId = this.currentQuestion().id;
    this.answers.update(m => { const nm = new Map(m); nm.set(qId, optionId); return nm; });
    const elapsed = Date.now() - this.startTime();
    this.examService.submitAnswer(this.session()!.id, qId, optionId, elapsed).subscribe();
  }

  skipQuestion(): void {
    const qId = this.currentQuestion().id;
    this.examService.submitAnswer(this.session()!.id, qId, null, 0).subscribe();
    this.nextQuestion();
  }

  nextQuestion(): void {
    const max = (this.session()?.questions.length ?? 1) - 1;
    if (this.currentIndex() < max) this.currentIndex.update(i => i + 1);
  }

  onTimerExpired(): void { this.submitExam(); }

  submitExam(): void {
    this.submitting.set(true);
    this.examService.submitExam(this.session()!.id).subscribe({
      next: () => this.router.navigate(["/results", this.session()!.id]),
      error: () => this.submitting.set(false)
    });
  }
}
