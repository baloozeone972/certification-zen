// certif-parent/certif-web/src/app/features/auth/register.component.ts
import { Component, inject, signal, ChangeDetectionStrategy } from "@angular/core";
import { FormBuilder, ReactiveFormsModule, Validators } from "@angular/forms";
import { Router, RouterLink } from "@angular/router";
import { CommonModule } from "@angular/common";
import { AuthService } from "../../core/auth/auth.service";

@Component({
  selector: "app-register",
  standalone: true,
  imports: [ReactiveFormsModule, RouterLink, CommonModule],
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    <div class="auth-page">
      <div class="auth-card card">
        <h1>Créer un compte</h1>
        <p class="subtitle">Gratuit — sans carte bancaire</p>
        <form [formGroup]="form" (ngSubmit)="submit()">
          <div class="field">
            <label>Email professionnel</label>
            <input type="email" formControlName="email" placeholder="vous@example.com">
          </div>
          <div class="field">
            <label>Mot de passe <span class="hint">(min. 8 caractères)</span></label>
            <input type="password" formControlName="password" placeholder="••••••••">
          </div>
          @if (error()) { <p class="error-msg">{{ error() }}</p> }
          <button type="submit" class="btn btn-primary w-full"
                  [disabled]="form.invalid || loading()">
            {{ loading() ? "Création..." : "Créer mon compte gratuit" }}
          </button>
        </form>
        <p class="auth-card__footer">
          Déjà inscrit ? <a routerLink="/auth/login">Se connecter</a>
        </p>
      </div>
    </div>
  `,
  styles: [`
    .auth-page { display: flex; justify-content: center; align-items: center;
                  min-height: calc(100vh - 60px); padding: 2rem; }
    .auth-card { width: 100%; max-width: 420px; }
    .auth-card h1 { font-size: 1.75rem; margin-bottom: .25rem; }
    .subtitle { color: var(--color-text-muted); font-size: .9rem; margin-bottom: 1.5rem; }
    .field { margin-bottom: 1rem; }
    .field label { display: block; font-weight: 600; margin-bottom: .35rem; font-size: .9rem; }
    .hint { font-weight: 400; color: var(--color-text-muted); }
    .field input { width: 100%; padding: .6rem .75rem; border: 1px solid var(--color-border);
                    border-radius: var(--radius-md); font-size: 1rem; }
    .error-msg { color: var(--color-error); font-size: .875rem; margin-bottom: 1rem; }
    .w-full { width: 100%; justify-content: center; margin-top: .5rem; }
    .auth-card__footer { text-align: center; margin-top: 1.25rem; font-size: .9rem;
                          color: var(--color-text-muted); }
  `]
})
export class RegisterComponent {
  private readonly auth   = inject(AuthService);
  private readonly router = inject(Router);
  private readonly fb     = inject(FormBuilder);

  readonly loading = signal(false);
  readonly error   = signal<string | null>(null);

  readonly form = this.fb.group({
    email:    ["", [Validators.required, Validators.email]],
    password: ["", [Validators.required, Validators.minLength(8)]]
  });

  submit(): void {
    if (this.form.invalid) return;
    this.loading.set(true);
    this.error.set(null);
    const { email, password } = this.form.value;

    this.auth.register(email!, password!).subscribe({
      next: () => this.router.navigate(["/"]),
      error: (err) => {
        this.error.set(err?.error?.message ?? "Une erreur est survenue.");
        this.loading.set(false);
      }
    });
  }
}
