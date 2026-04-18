// certif-parent/certif-web/src/app/features/interview/interview.component.ts
import { Component, inject, signal, ChangeDetectionStrategy } from "@angular/core";
import { CommonModule } from "@angular/common";
import { FormsModule } from "@angular/forms";
import { RouterLink } from "@angular/router";
import { HttpClient } from "@angular/common/http";
import { AuthService } from "../../core/auth/auth.service";
import { environment } from "../../../environments/environment";

interface InterviewQuestion { id: string; question: string; context?: string; }
interface InterviewFeedback {
  score: number;
  strengths: string[];
  improvements: string[];
  modelAnswer: string;
}

@Component({
  selector: "app-interview",
  standalone: true,
  imports: [CommonModule, FormsModule, RouterLink],
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    <div class="interview container">
      <h1>🎤 Simulateur d'entretien IA</h1>

      @if (!authService.isPro()) {
        <div class="card interview__paywall">
          <p>Le simulateur d'entretien est disponible avec l'abonnement <strong>Pro</strong>.</p>
          <a routerLink="/profile" class="btn btn-primary">Passer à Pro</a>
        </div>
      } @else {
        <!-- Configuration -->
        @if (!currentQuestion()) {
          <div class="card">
            <h2>Configurer la session</h2>
            <div class="form-row">
              <label>Certification cible</label>
              <select [(ngModel)]="selectedCert">
                <option value="ocp21">Oracle Certified Professional Java 21</option>
                <option value="aws_saa">AWS Solutions Architect Associate</option>
                <option value="springboot3">Spring Boot 3</option>
                <option value="docker">Docker</option>
                <option value="cka">Kubernetes (CKA)</option>
              </select>
            </div>
            <div class="form-row">
              <label>Niveau de difficulté</label>
              <select [(ngModel)]="difficulty">
                <option value="junior">Junior (0-2 ans)</option>
                <option value="mid">Intermédiaire (2-5 ans)</option>
                <option value="senior">Senior (5+ ans)</option>
              </select>
            </div>
            <button class="btn btn-primary" [disabled]="loading()" (click)="startInterview()">
              {{ loading() ? "Préparation..." : "Démarrer l'entretien →" }}
            </button>
          </div>
        }

        <!-- Question en cours -->
        @if (currentQuestion() && !feedback()) {
          <div class="card interview__question">
            <div class="interview__progress">
              Question {{ questionIndex() + 1 }} / 5
              <div class="interview__bar">
                <div class="interview__bar-fill"
                     [style.width.%]="(questionIndex() + 1) * 20"></div>
              </div>
            </div>
            <h2>{{ currentQuestion()!.question }}</h2>
            @if (currentQuestion()!.context) {
              <p class="interview__context">{{ currentQuestion()!.context }}</p>
            }
            <textarea
              [(ngModel)]="userAnswer"
              placeholder="Rédigez votre réponse en détail (minimum 3 phrases)..."
              rows="8"
              class="interview__textarea">
            </textarea>
            <div class="interview__footer">
              <span class="interview__hint">💡 Prenez votre temps — l'IA évaluera votre raisonnement</span>
              <button class="btn btn-primary"
                      [disabled]="!userAnswer.trim() || submitting()"
                      (click)="submitAnswer()">
                {{ submitting() ? "Analyse en cours..." : "Soumettre ma réponse" }}
              </button>
            </div>
          </div>
        }

        <!-- Feedback IA -->
        @if (feedback()) {
          <div class="card interview__feedback">
            <h2>Analyse de votre réponse</h2>
            <div class="interview__score"
                 [class.interview__score--good]="feedback()!.score >= 7"
                 [class.interview__score--avg]="feedback()!.score >= 5 && feedback()!.score < 7"
                 [class.interview__score--poor]="feedback()!.score < 5">
              {{ feedback()!.score }}/10
            </div>

            @if (feedback()!.strengths.length) {
              <div class="interview__section">
                <strong>✅ Points forts</strong>
                <ul>
                  @for (s of feedback()!.strengths; track s) { <li>{{ s }}</li> }
                </ul>
              </div>
            }

            @if (feedback()!.improvements.length) {
              <div class="interview__section">
                <strong>💡 Axes d'amélioration</strong>
                <ul>
                  @for (i of feedback()!.improvements; track i) { <li>{{ i }}</li> }
                </ul>
              </div>
            }

            <div class="interview__section interview__model">
              <strong>📝 Réponse modèle</strong>
              <p>{{ feedback()!.modelAnswer }}</p>
            </div>

            <div class="interview__nav">
              @if (questionIndex() < 4) {
                <button class="btn btn-primary" (click)="nextQuestion()">
                  Question suivante →
                </button>
              } @else {
                <div class="interview__done">
                  <p>🎉 Session terminée ! Continuez à pratiquer pour progresser.</p>
                  <button class="btn btn-secondary" (click)="restart()">
                    Nouvelle session
                  </button>
                </div>
              }
            </div>
          </div>
        }
      }
    </div>
  `,
  styles: [`
    .interview { padding: 2rem 1rem; max-width: 800px; }
    h1 { font-size: 1.75rem; margin-bottom: 1.5rem; }
    .interview__paywall { background: #fff3cd; border-left: 4px solid var(--color-warning); }
    .interview__paywall p { margin-bottom: 1rem; }
    .form-row { display: flex; flex-direction: column; gap: .35rem; margin-bottom: 1rem; }
    .form-row label { font-weight: 600; font-size: .9rem; }
    .form-row select { padding: .5rem .75rem; border: 1px solid var(--color-border);
                        border-radius: var(--radius-md); background: var(--color-surface); }
    .interview__progress { display: flex; align-items: center; gap: 1rem;
                             margin-bottom: 1.25rem; font-size: .9rem; color: var(--color-text-muted); }
    .interview__bar { flex: 1; height: 6px; background: var(--color-border); border-radius: 3px; }
    .interview__bar-fill { height: 100%; background: var(--color-secondary);
                             border-radius: 3px; transition: width .3s; }
    .interview__context { font-style: italic; color: var(--color-text-muted);
                           background: var(--color-bg); padding: .75rem; border-radius: var(--radius-md);
                           margin-bottom: 1rem; font-size: .9rem; }
    .interview__textarea { width: 100%; padding: .75rem; border: 1px solid var(--color-border);
                             border-radius: var(--radius-md); font-size: .95rem; resize: vertical;
                             font-family: var(--font-sans); background: var(--color-surface); }
    .interview__footer { display: flex; align-items: center; justify-content: space-between;
                          margin-top: 1rem; gap: 1rem; flex-wrap: wrap; }
    .interview__hint { font-size: .8rem; color: var(--color-text-muted); }
    .interview__score { font-size: 3rem; font-weight: 900; text-align: center;
                         margin: 1rem 0; }
    .interview__score--good { color: var(--color-success); }
    .interview__score--avg  { color: var(--color-warning); }
    .interview__score--poor { color: var(--color-error); }
    .interview__section { margin: 1rem 0; }
    .interview__section ul { margin-top: .5rem; padding-left: 1.25rem;
                               color: var(--color-text-muted); }
    .interview__section li { margin-bottom: .35rem; }
    .interview__model { background: var(--color-bg); padding: 1rem;
                          border-radius: var(--radius-md); }
    .interview__model p { margin-top: .5rem; color: var(--color-text-muted); line-height: 1.7; }
    .interview__nav { display: flex; justify-content: flex-end; margin-top: 1.25rem; }
    .interview__done { text-align: center; }
    .interview__done p { margin-bottom: 1rem; color: var(--color-text-muted); }
  `]
})
export class InterviewComponent {
  readonly authService = inject(AuthService);
  private readonly http = inject(HttpClient);

  selectedCert  = "ocp21";
  difficulty    = "mid";
  userAnswer    = "";

  readonly currentQuestion = signal<InterviewQuestion | null>(null);
  readonly feedback        = signal<InterviewFeedback | null>(null);
  readonly questionIndex   = signal(0);
  readonly loading         = signal(false);
  readonly submitting      = signal(false);

  private questions: InterviewQuestion[] = [];

  startInterview(): void {
    this.loading.set(true);
    this.http.post<{ data: InterviewQuestion[] }>(
      `${environment.apiUrl}/ai/interview/start`,
      { certificationId: this.selectedCert, difficulty: this.difficulty, count: 5 }
    ).subscribe({
      next: res => {
        this.questions = res.data;
        this.questionIndex.set(0);
        this.currentQuestion.set(this.questions[0]);
        this.loading.set(false);
      },
      error: () => this.loading.set(false)
    });
  }

  submitAnswer(): void {
    if (!this.userAnswer.trim()) return;
    this.submitting.set(true);
    this.http.post<{ data: InterviewFeedback }>(
      `${environment.apiUrl}/ai/interview/evaluate`,
      {
        questionId: this.currentQuestion()!.id,
        answer: this.userAnswer,
        certificationId: this.selectedCert
      }
    ).subscribe({
      next: res => { this.feedback.set(res.data); this.submitting.set(false); },
      error: () => this.submitting.set(false)
    });
  }

  nextQuestion(): void {
    const next = this.questionIndex() + 1;
    this.questionIndex.set(next);
    this.currentQuestion.set(this.questions[next] ?? null);
    this.feedback.set(null);
    this.userAnswer = "";
  }

  restart(): void {
    this.currentQuestion.set(null);
    this.feedback.set(null);
    this.questionIndex.set(0);
    this.userAnswer = "";
    this.questions = [];
  }
}
