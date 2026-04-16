// certif-parent/certif-web/src/app/features/home/home.component.ts
import { Component, OnInit, inject, signal, ChangeDetectionStrategy } from "@angular/core";
import { RouterLink } from "@angular/router";
import { CommonModule } from "@angular/common";
import { CertificationService } from "../../core/services/certification.service";
import { AuthService } from "../../core/auth/auth.service";
import { Certification } from "../../core/models/certification.models";

/**
 * Home page — certification catalogue + hero section.
 */
@Component({
  selector: "app-home",
  standalone: true,
  imports: [RouterLink, CommonModule],
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    <section class="hero">
      <div class="container">
        <h1>Préparez vos certifications<br><span>avec l'IA</span></h1>
        <p>Examens blancs, flashcards SM-2, coach IA personnalisé, communauté.
           Rejoignez plus de 10 000 professionnels IT.</p>
        @if (!authService.isAuthenticated()) {
          <div class="hero__actions">
            <a routerLink="/auth/register" class="btn btn-primary btn--lg">Commencer gratuitement</a>
            <a routerLink="/auth/login" class="btn btn-secondary btn--lg">Se connecter</a>
          </div>
        }
      </div>
    </section>

    <section class="catalogue container">
      <h2>Certifications disponibles</h2>
      @if (loading()) {
        <div class="catalogue__loading">Chargement...</div>
      } @else {
        <div class="catalogue__grid">
          @for (cert of certifications(); track cert.id) {
            <div class="cert-card card">
              <h3>{{ cert.name }}</h3>
              <p class="cert-card__code">{{ cert.code }}</p>
              <div class="cert-card__stats">
                <span>{{ cert.totalQuestions }} questions</span>
                <span>{{ cert.passingScore }}% requis</span>
                <span>{{ cert.examDurationMin }} min</span>
              </div>
              <a [routerLink]="['/exam']" [queryParams]="{certId: cert.id}"
                 class="btn btn-primary cert-card__btn">
                Commencer l'examen
              </a>
            </div>
          }
        </div>
      }
    </section>
  `,
  styles: [`
    .hero { background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
             color: white; padding: 5rem 0; text-align: center; }
    .hero h1 { font-size: 2.5rem; font-weight: 800; margin-bottom: 1rem; line-height: 1.2; }
    .hero h1 span { color: #f39c12; }
    .hero p { font-size: 1.1rem; opacity: .9; max-width: 600px; margin: 0 auto 2rem; }
    .hero__actions { display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap; }
    .btn--lg { padding: .75rem 2rem; font-size: 1rem; }
    .catalogue { padding: 4rem 0; }
    .catalogue h2 { font-size: 1.75rem; margin-bottom: 2rem; }
    .catalogue__grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 1.5rem; }
    .cert-card h3 { font-size: 1.1rem; margin-bottom: .25rem; }
    .cert-card__code { color: var(--color-text-muted); font-size: .85rem; margin-bottom: 1rem; }
    .cert-card__stats { display: flex; gap: 1rem; font-size: .8rem;
                         color: var(--color-text-muted); margin-bottom: 1.25rem; flex-wrap: wrap; }
    .cert-card__btn { width: 100%; justify-content: center; }
  `]
})
export class HomeComponent implements OnInit {
  readonly certService  = inject(CertificationService);
  readonly authService  = inject(AuthService);
  readonly certifications = this.certService.certifications;
  readonly loading        = this.certService.loading;

  ngOnInit(): void { this.certService.loadAll().subscribe(); }
}
