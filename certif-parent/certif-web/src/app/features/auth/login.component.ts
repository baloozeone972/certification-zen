// certif-parent/certif-web/src/app/features/auth/login.component.ts
import { Component, inject, signal, ChangeDetectionStrategy } from "@angular/core";
import { FormBuilder, ReactiveFormsModule, Validators } from "@angular/forms";
import { Router, RouterLink, ActivatedRoute } from "@angular/router";
import { CommonModule } from "@angular/common";
import { AuthService } from "../../core/auth/auth.service";

@Component({
  selector: "app-login",
  standalone: true,
  imports: [ReactiveFormsModule, RouterLink, CommonModule],
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    <div class="auth-page">
      <div class="auth-card card">
        <h1>Connexion</h1>
        <form [formGroup]="form" (ngSubmit)="submit()">
          <div class="field">
            <label>Email</label>
            <input type="email" formControlName="email" placeholder="vous@example.com">
          </div>
          <div class="field">
            <label>Mot de passe</label>
            <input type="password" formControlName="password" placeholder="••••••••">
          </div>
          @if (error()) { <p class="error-msg">{{ error() }}</p> }
          <button type="submit" class="btn btn-primary w-full"
                  [disabled]="form.invalid || loading()">
            {{ loading() ? "Connexion..." : "Se connecter" }}
          </button>
        </form>
        <p class="auth-card__footer">
          Pas encore de compte ? <a routerLink="/auth/register">S'inscrire gratuitement</a>
        </p>
      </div>
    </div>
  `,
  styles: [`
    .auth-page { display: flex; justify-content: center; align-items: center;
                  min-height: calc(100vh - 60px); padding: 2rem; }
    .auth-card { width: 100%; max-width: 420px; }
    .auth-card h1 { font-size: 1.75rem; margin-bottom: 1.5rem; }
    .field { margin-bottom: 1rem; }
    .field label { display: block; font-weight: 600; margin-bottom: .35rem; font-size: .9rem; }
    .field input { width: 100%; padding: .6rem .75rem; border: 1px solid var(--color-border);
                    border-radius: var(--radius-md); font-size: 1rem;
                    &:focus { outline: 2px solid var(--color-secondary); border-color: transparent; } }
    .error-msg { color: var(--color-error); font-size: .875rem; margin-bottom: 1rem; }
    .w-full { width: 100%; justify-content: center; margin-top: .5rem; }
    .auth-card__footer { text-align: center; margin-top: 1.25rem; font-size: .9rem;
                          color: var(--color-text-muted); }
  `]
})
export class LoginComponent {
  private readonly auth    = inject(AuthService);
  private readonly router  = inject(Router);
  private readonly route   = inject(ActivatedRoute);
  private readonly fb      = inject(FormBuilder);

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

    this.auth.login(email!, password!).subscribe({
      next: () => {
        const returnUrl = this.route.snapshot.queryParamMap.get("returnUrl") ?? "/";
        this.router.navigateByUrl(returnUrl);
      },
      error: () => {
        this.error.set("Email ou mot de passe incorrect.");
        this.loading.set(false);
      }
    });
  }
}
