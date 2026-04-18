// certif-parent/certif-web/src/app/features/exam/exam-setup.component.ts
import {ChangeDetectionStrategy, Component, inject, OnInit, signal} from "@angular/core";
import {ActivatedRoute, Router} from "@angular/router";
import {CommonModule} from "@angular/common";
import {FormsModule} from "@angular/forms";
import {CertificationService} from "../../core/services/certification.service";
import {ExamService} from "../../core/services/exam.service";
import {Certification} from "../../core/models/certification.models";

@Component({
    selector: "app-exam-setup",
    standalone: true,
    imports: [CommonModule, FormsModule],
    changeDetection: ChangeDetectionStrategy.OnPush,
    template: `
    <div class="setup container">
      <h1>Configurer l'examen</h1>

      @if (cert()) {
        <div class="setup__cert card">
          <h2>{{ cert()!.name }}</h2>
          <div class="setup__meta">
            <span>{{ cert()!.examQuestionCount }} questions</span>
            <span>{{ cert()!.examDurationMin }} minutes</span>
            <span>Seuil : {{ cert()!.passingScore }}%</span>
          </div>
        </div>

        <div class="setup__mode card">
          <h3>Mode d'examen</h3>
          <div class="mode-grid">
            @for (m of modes; track m.value) {
              <button class="mode-btn" [class.mode-btn--active]="selectedMode() === m.value"
                      (click)="selectedMode.set(m.value)">
                <span class="mode-btn__icon">{{ m.icon }}</span>
                <strong>{{ m.label }}</strong>
                <small>{{ m.desc }}</small>
              </button>
            }
          </div>
        </div>

        <button class="btn btn-primary start-btn" [disabled]="starting()"
                (click)="startExam()">
          {{ starting() ? "Démarrage..." : "Démarrer l'examen →" }}
        </button>
      }
    </div>
  `,
    styles: [`
    .setup { max-width: 700px; padding: 2rem 1rem; }
    .setup h1 { font-size: 1.75rem; margin-bottom: 1.5rem; }
    .setup__cert, .setup__mode { margin-bottom: 1.5rem; }
    .setup__meta { display: flex; gap: 1.5rem; margin-top: .5rem;
                    color: var(--color-text-muted); font-size: .9rem; }
    .mode-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
                  gap: 1rem; margin-top: 1rem; }
    .mode-btn { border: 2px solid var(--color-border); border-radius: var(--radius-md);
                 padding: 1rem; background: var(--color-surface); cursor: pointer;
                 display: flex; flex-direction: column; gap: .3rem; text-align: left;
                 transition: all var(--transition);
                 &--active { border-color: var(--color-secondary); background: #e8f4fd; }
                 &:hover { border-color: var(--color-secondary); } }
    .mode-btn__icon { font-size: 1.5rem; }
    .start-btn { margin-top: .5rem; padding: .75rem 2.5rem; font-size: 1rem; }
  `]
})
export class ExamSetupComponent implements OnInit {
    readonly cert = signal<Certification | null>(null);
    readonly selectedMode = signal<"EXAM" | "FREE" | "REVISION">("EXAM");
    readonly starting = signal(false);
    readonly modes = [
        {
            value: "EXAM" as const, icon: "📝", label: "Examen officiel",
            desc: "Conditions réelles, timer, correction à la fin"
        },
        {
            value: "FREE" as const, icon: "🎯", label: "Mode libre",
            desc: "Choisissez les thèmes, timer optionnel"
        },
        {
            value: "REVISION" as const, icon: "📚", label: "Révision",
            desc: "Correction immédiate après chaque réponse"
        }
    ];
    private readonly certService = inject(CertificationService);
    private readonly examService = inject(ExamService);
    private readonly router = inject(Router);
    private readonly route = inject(ActivatedRoute);

    ngOnInit(): void {
        const certId = this.route.snapshot.queryParamMap.get("certId") ?? "";
        if (certId) {
            this.certService.getById(certId).subscribe(c => this.cert.set(c));
        }
    }

    startExam(): void {
        if (!this.cert()) return;
        this.starting.set(true);
        this.examService.start(this.cert()!.id, this.selectedMode()).subscribe({
            next: session => this.router.navigate(["/exam/session", session.id]),
            error: () => this.starting.set(false)
        });
    }
}
