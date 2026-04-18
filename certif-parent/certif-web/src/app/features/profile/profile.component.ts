// certif-parent/certif-web/src/app/features/profile/profile.component.ts
import { Component, OnInit, inject, signal, ChangeDetectionStrategy } from "@angular/core";
import { CommonModule } from "@angular/common";
import { ReactiveFormsModule, FormBuilder, Validators } from "@angular/forms";
import { RouterLink } from "@angular/router";
import { HttpClient } from "@angular/common/http";
import { AuthService } from "../../core/auth/auth.service";
import { environment } from "../../../environments/environment";
import { UserPreferences } from "../../core/models/user.models";
import { ApiResponse } from "../../core/models/api.models";
import { map } from "rxjs";

@Component({
  selector: "app-profile",
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, RouterLink],
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    <div class="profile container">
      <h1>Mon profil</h1>

      @if (authService.currentUser(); as user) {
        <!-- Carte abonnement -->
        <div class="profile__sub card" [class.profile__sub--pro]="authService.isPro()">
          <div class="profile__sub-header">
            <span class="profile__sub-badge"
              [class.badge-success]="authService.isPro()"
              [class.badge-info]="!authService.isPro()">
              {{ user.subscriptionTier }}
            </span>
            <strong>{{ user.email }}</strong>
          </div>
          @if (!authService.isPro()) {
            <p class="profile__sub-pitch">
              Passez Pro pour accéder aux examens illimités, au coach IA, aux flashcards et à l'export PDF.
            </p>
            <a routerLink="/profile/upgrade" class="btn btn-primary">
              🚀 Passer à Pro — 9,99 €/mois
            </a>
          } @else {
            <p class="profile__sub-active">✅ Abonnement Pro actif — accès illimité à tout</p>
            <button class="btn btn-secondary" (click)="manageSubscription()">
              Gérer mon abonnement
            </button>
          }
        </div>

        <!-- Préférences -->
        <div class="card" style="margin-top:1.5rem">
          <h2>Préférences</h2>
          @if (saved()) {
            <div class="banner banner--success">✅ Préférences enregistrées</div>
          }
          <form [formGroup]="prefsForm" (ngSubmit)="savePreferences()">
            <div class="form-row">
              <label>Thème</label>
              <select formControlName="theme">
                <option value="light">☀️ Clair</option>
                <option value="dark">🌙 Sombre</option>
                <option value="system">🖥️ Système</option>
              </select>
            </div>
            <div class="form-row">
              <label>Langue</label>
              <select formControlName="language">
                <option value="fr">🇫🇷 Français</option>
                <option value="en">🇬🇧 English</option>
              </select>
            </div>
            <div class="form-row">
              <label>Mode d'examen par défaut</label>
              <select formControlName="defaultMode">
                <option value="EXAM">📝 Examen officiel</option>
                <option value="FREE">🎯 Mode libre</option>
                <option value="REVISION">📚 Révision</option>
              </select>
            </div>
            <div class="form-row form-row--check">
              <label>
                <input type="checkbox" formControlName="notificationsEnabled">
                Notifications (rappels quotidiens)
              </label>
            </div>
            <button type="submit" class="btn btn-primary" [disabled]="saving()">
              {{ saving() ? "Enregistrement..." : "Enregistrer" }}
            </button>
          </form>
        </div>

        <!-- Actions du compte -->
        <div class="card" style="margin-top:1.5rem">
          <h2>Compte</h2>
          <div class="profile__actions">
            <button class="btn btn-danger" (click)="logout()">Se déconnecter</button>
          </div>
        </div>
      }
    </div>
  `,
  styles: [`
    .profile { padding: 2rem 1rem; max-width: 700px; }
    h1 { font-size: 1.75rem; margin-bottom: 1.5rem; }
    h2 { font-size: 1.2rem; margin-bottom: 1rem; }
    .profile__sub { border-left: 4px solid var(--color-secondary); }
    .profile__sub--pro { border-left-color: var(--color-success); }
    .profile__sub-header { display: flex; align-items: center; gap: 1rem; margin-bottom: .75rem; }
    .profile__sub-pitch { color: var(--color-text-muted); margin-bottom: 1rem; }
    .profile__sub-active { color: var(--color-success); margin-bottom: 1rem; }
    .form-row { display: flex; flex-direction: column; gap: .35rem; margin-bottom: 1rem; }
    .form-row label { font-weight: 600; font-size: .9rem; }
    .form-row select, .form-row input[type=text] {
      padding: .5rem .75rem; border: 1px solid var(--color-border);
      border-radius: var(--radius-md); font-size: .95rem; background: var(--color-surface);
    }
    .form-row--check label { display: flex; align-items: center; gap: .5rem; font-weight: 400; cursor: pointer; }
    .profile__actions { display: flex; gap: 1rem; }
    .banner--success { background: #d4edda; color: #155724; padding: .75rem 1rem;
                        border-radius: var(--radius-md); margin-bottom: 1rem; }
  `]
})
export class ProfileComponent implements OnInit {
  readonly authService = inject(AuthService);
  private readonly http = inject(HttpClient);
  private readonly fb   = inject(FormBuilder);
  private readonly base = `${environment.apiUrl}/users`;

  readonly saving = signal(false);
  readonly saved  = signal(false);

  readonly prefsForm = this.fb.group({
    theme:                 ["light"],
    language:              ["fr"],
    defaultMode:           ["EXAM"],
    notificationsEnabled:  [true],
  });

  ngOnInit(): void {
    this.http.get<ApiResponse<UserPreferences>>(`${this.base}/preferences`)
      .pipe(map(r => r.data))
      .subscribe(prefs => {
        this.prefsForm.patchValue({
          theme:               prefs.theme,
          language:            prefs.language,
          defaultMode:         prefs.defaultMode,
          notificationsEnabled: prefs.notificationsEnabled,
        });
      });
  }

  savePreferences(): void {
    if (this.prefsForm.invalid) return;
    this.saving.set(true);
    this.http.put<ApiResponse<UserPreferences>>(`${this.base}/preferences`, this.prefsForm.value)
      .subscribe({
        next: () => { this.saved.set(true); this.saving.set(false);
                       setTimeout(() => this.saved.set(false), 3000); },
        error: () => this.saving.set(false)
      });
  }

  manageSubscription(): void {
    this.http.post<{ url: string }>(`${this.base}/billing-portal`, {}).subscribe(res => {
      window.open(res.url, "_blank");
    });
  }

  logout(): void { this.authService.logout(); }
}
