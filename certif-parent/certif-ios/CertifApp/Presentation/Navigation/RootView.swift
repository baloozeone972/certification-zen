// certif-ios/CertifApp/Presentation/Navigation/RootView.swift
//
// Root navigation controller — handles auth gate and tab structure.
// Equivalent of NavGraph.kt in Android.

import SwiftUI

/// Entry view: shows auth flow or main tab interface based on authentication state.
struct RootView: View {

    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        Group {
            if authService.isAuthenticated {
                AppTabView()
            } else {
                AuthView()
            }
        }
        .preferredColorScheme(colorScheme(for: themeManager.currentTheme))
        .task {
            if authService.isAuthenticated {
                await authService.fetchCurrentUser()
            }
        }
    }

    private func colorScheme(for theme: ThemeManager.AppTheme) -> ColorScheme? {
        switch theme {
        case .light:  return .light
        case .dark:   return .dark
        case .system: return nil
        }
    }
}

// MARK: - AppTabView

/// Main tab bar — 5 tabs mirroring the Android bottom navigation.
struct AppTabView: View {

    @State private var selectedTab: Tab = .home
    private let container = DIContainer.shared

    enum Tab: Int, CaseIterable {
        case home      = 0
        case learning  = 1
        case community = 2
        case coach     = 3
        case profile   = 4

        var title: String {
            switch self {
            case .home:      return "Accueil"
            case .learning:  return "Apprendre"
            case .community: return "Communauté"
            case .coach:     return "Coach"
            case .profile:   return "Profil"
            }
        }

        var icon: String {
            switch self {
            case .home:      return "house.fill"
            case .learning:  return "book.fill"
            case .community: return "person.3.fill"
            case .coach:     return "chart.line.uptrend.xyaxis"
            case .profile:   return "person.circle.fill"
            }
        }
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            // Home — certification catalog
            NavigationStack {
                HomeView(viewModel: container.makeHomeViewModel())
            }
            .tabItem {
                Label(Tab.home.title, systemImage: Tab.home.icon)
            }
            .tag(Tab.home)

            // Learning — flashcards, courses, adaptive plan
            NavigationStack {
                LearningHubView()
            }
            .tabItem {
                Label(Tab.learning.title, systemImage: Tab.learning.icon)
            }
            .tag(Tab.learning)

            // Community — challenges + certified wall
            NavigationStack {
                CommunityHubView()
            }
            .tabItem {
                Label(Tab.community.title, systemImage: Tab.community.icon)
            }
            .tag(Tab.community)

            // Coach — weekly report + job market
            NavigationStack {
                CoachView(viewModel: container.makeCoachViewModel())
            }
            .tabItem {
                Label(Tab.coach.title, systemImage: Tab.coach.icon)
            }
            .tag(Tab.coach)

            // Profile — account + subscription + preferences
            NavigationStack {
                ProfileView(viewModel: container.makeProfileViewModel())
            }
            .tabItem {
                Label(Tab.profile.title, systemImage: Tab.profile.icon)
            }
            .tag(Tab.profile)
        }
        .tint(.accentColor)
    }
}
