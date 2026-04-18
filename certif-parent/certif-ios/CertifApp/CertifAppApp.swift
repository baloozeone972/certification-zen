// certif-ios/CertifApp/CertifAppApp.swift

import SwiftUI
import SwiftData

/// Application entry point.
/// Injects the DI container and SwiftData model container at the root level.
@main
struct CertifAppApp: App {

    // MARK: - Properties

    /// Shared dependency injection container (network, repositories, use cases).
    @State private var container = DIContainer.shared

    /// SwiftData model container for offline persistence.
    private let modelContainer: ModelContainer = {
        let schema = Schema([
            CertificationEntity.self,
            QuestionEntity.self,
            ExamSessionEntity.self,
            FlashcardEntity.self,
            SM2ScheduleEntity.self,
            PendingSyncEntity.self
        ])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("SwiftData ModelContainer creation failed: \(error)")
        }
    }()

    // MARK: - Scene

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(container.authService)
                .environmentObject(container.themeManager)
                .environment(\.modelContext, modelContainer.mainContext)
                .onAppear {
                    container.configure(modelContext: modelContainer.mainContext)
                }
        }
        .modelContainer(modelContainer)
    }
}
