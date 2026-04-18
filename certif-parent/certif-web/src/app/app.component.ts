// certif-parent/certif-web/src/app/app.component.ts
import {Component, inject, OnInit, signal} from '@angular/core';
import {RouterLink, RouterLinkActive, RouterOutlet} from '@angular/router';
import {CommonModule} from '@angular/common';
import {AuthService} from './core/auth/auth.service';

/**
 * Root shell component.
 * Provides the main navigation bar and the router outlet.
 * Uses Angular 18 Signals for reactive state.
 */
@Component({
    selector: 'app-root',
    standalone: true,
    imports: [RouterOutlet, RouterLink, RouterLinkActive, CommonModule],
    template: `
    <nav class="navbar" [attr.data-theme]="theme()">
      <div class="container navbar__inner">
        <a routerLink="/" class="navbar__brand">
          <span class="navbar__logo">🎓</span>
          CertifApp
        </a>

        <div class="navbar__links">
          @if (authService.isAuthenticated()) {
            <a routerLink="/learning" routerLinkActive="active">Révisions</a>
            <a routerLink="/community" routerLinkActive="active">Communauté</a>
            <a routerLink="/coaching" routerLinkActive="active">Coach IA</a>
            <a routerLink="/chat" routerLinkActive="active">Assistant</a>
            <a routerLink="/profile" routerLinkActive="active" class="navbar__avatar">
              {{ authService.currentUser()?.email?.charAt(0)?.toUpperCase() }}
            </a>
          } @else {
            <a routerLink="/auth/login" class="btn btn-primary">Connexion</a>
            <a routerLink="/auth/register" class="btn btn-secondary">Inscription gratuite</a>
          }
          <button class="btn-icon" (click)="toggleTheme()" [title]="'Thème ' + theme()">
            {{ theme() === 'dark' ? '☀️' : '🌙' }}
          </button>
        </div>
      </div>
    </nav>

    <main class="main-content" [attr.data-theme]="theme()">
      <router-outlet />
    </main>
  `,
    styles: [`
    .navbar {
      position: sticky; top: 0; z-index: 100;
      background: var(--color-surface);
      border-bottom: 1px solid var(--color-border);
      box-shadow: var(--shadow-sm);
    }
    .navbar__inner {
      display: flex; align-items: center;
      justify-content: space-between;
      height: 60px;
    }
    .navbar__brand {
      display: flex; align-items: center; gap: .5rem;
      font-size: 1.25rem; font-weight: 700;
      color: var(--color-primary); text-decoration: none;
    }
    .navbar__links {
      display: flex; align-items: center; gap: 1rem;
      a { color: var(--color-text-muted); font-weight: 500;
          &.active, &:hover { color: var(--color-secondary); } }
    }
    .navbar__avatar {
      width: 36px; height: 36px; border-radius: 50%;
      background: var(--color-secondary); color: white;
      display: flex; align-items: center; justify-content: center;
      font-weight: 700; cursor: pointer;
    }
    .btn-icon {
      background: none; border: 1px solid var(--color-border);
      border-radius: var(--radius-md); padding: .4rem .6rem;
      cursor: pointer; font-size: 1rem;
    }
    .main-content { min-height: calc(100vh - 60px); }
  `]
})
export class AppComponent implements OnInit {
    readonly authService = inject(AuthService);
    readonly theme = signal<'light' | 'dark'>('light');

    ngOnInit(): void {
        // Restore theme from localStorage
        const saved = localStorage.getItem('theme') as 'light' | 'dark' | null;
        if (saved) this.theme.set(saved);
        document.documentElement.setAttribute('data-theme', this.theme());
    }

    toggleTheme(): void {
        const next = this.theme() === 'light' ? 'dark' : 'light';
        this.theme.set(next);
        localStorage.setItem('theme', next);
        document.documentElement.setAttribute('data-theme', next);
    }
}
