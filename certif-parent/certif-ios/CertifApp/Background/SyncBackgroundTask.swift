// certif-ios/CertifApp/Background/SyncBackgroundTask.swift
//
// Background sync using BGTaskScheduler (iOS 13+).
// Equivalent of Android WorkManager SyncWorker.kt.
// Flushes PendingSyncEntity queue to the REST API when connectivity returns.
// Justification: BGTaskScheduler est le standard Apple pour les tâches différées.
// WorkManager n'existe pas sur iOS — BGAppRefreshTask est son équivalent exact.

import BackgroundTasks
import SwiftData
import Foundation
import Network

// MARK: - Task Identifiers (must be declared in Info.plist BGTaskSchedulerPermittedIdentifiers)

enum BackgroundTaskIdentifier {
    static let sync         = "com.certifapp.sync"
    static let coachReport  = "com.certifapp.coachreport"
}

// MARK: - SyncBackgroundTask

/// Registers and handles background sync tasks.
final class SyncBackgroundTask {

    private let apiClient: APIClient
    private let modelContainer: ModelContainer

    init(apiClient: APIClient, modelContainer: ModelContainer) {
        self.apiClient = apiClient
        self.modelContainer = modelContainer
    }

    // MARK: - Registration

    /// Call this once at app startup (CertifAppApp.init or onAppear).
    func registerAll() {
        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: BackgroundTaskIdentifier.sync,
            using: nil
        ) { [weak self] task in
            self?.handleSyncTask(task as! BGAppRefreshTask)
        }

        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: BackgroundTaskIdentifier.coachReport,
            using: nil
        ) { [weak self] task in
            self?.handleCoachReportTask(task as! BGAppRefreshTask)
        }
    }

    /// Schedules the next sync execution.
    func scheduleSync() {
        let request = BGAppRefreshTaskRequest(identifier: BackgroundTaskIdentifier.sync)
        request.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60) // 15 min minimum
        try? BGTaskScheduler.shared.submit(request)
    }

    /// Schedules the weekly coach report notification (Monday 08:00).
    func scheduleCoachReport() {
        let request = BGAppRefreshTaskRequest(identifier: BackgroundTaskIdentifier.coachReport)
        request.earliestBeginDate = nextMondayAt8AM()
        try? BGTaskScheduler.shared.submit(request)
    }

    // MARK: - Handlers

    private func handleSyncTask(_ task: BGAppRefreshTask) {
        scheduleSync() // Reschedule for next execution

        let syncTask = Task {
            await flushPendingSync()
        }

        task.expirationHandler = {
            syncTask.cancel()
        }

        Task {
            await syncTask.value
            task.setTaskCompleted(success: true)
        }
    }

    private func handleCoachReportTask(_ task: BGAppRefreshTask) {
        scheduleCoachReport()
        Task {
            await NotificationService.shared.sendWeeklyCoachReminder()
            task.setTaskCompleted(success: true)
        }
    }

    // MARK: - Sync Logic

    /// Processes all PendingSyncEntity records and sends them to the API.
    @MainActor
    private func flushPendingSync() async {
        let context = modelContainer.mainContext
        let descriptor = FetchDescriptor<PendingSyncEntity>(
            predicate: #Predicate { $0.retryCount < 5 },
            sortBy: [SortDescriptor(\.createdAt)]
        )

        guard let pending = try? context.fetch(descriptor), !pending.isEmpty else { return }

        for entity in pending {
            do {
                switch entity.type {
                case "SUBMIT_ANSWER":
                    let dto = try JSONDecoder().decode(SubmitAnswerRequestDTO.self, from: entity.payloadJson)
                    let _: AnswerResultDTO = try await apiClient.request(
                        .post("/api/v1/exams/\(dto.sessionId)/answers", body: dto)
                    )
                    context.delete(entity)

                case "REVIEW_FLASHCARD":
                    struct ReviewPayload: Codable { let id: UUID; let rating: Int }
                    let payload = try JSONDecoder().decode(ReviewPayload.self, from: entity.payloadJson)
                    let _: SM2ProgressDTO = try await apiClient.request(
                        .post("/api/v1/learning/flashcards/\(payload.id)/review",
                              body: ReviewFlashcardRequestDTO(rating: payload.rating))
                    )
                    context.delete(entity)

                default:
                    entity.retryCount += 1
                }
            } catch {
                entity.retryCount += 1
                print("[SyncBackgroundTask] Failed to sync \(entity.type): \(error)")
            }
        }

        try? context.save()
    }

    // MARK: - Helpers

    private func nextMondayAt8AM() -> Date {
        var cal = Calendar.current
        cal.locale = Locale(identifier: "fr_FR")
        let now = Date()
        let weekday = cal.component(.weekday, from: now)
        // weekday: 1=Sunday, 2=Monday ... 7=Saturday
        let daysUntilMonday = weekday == 2 ? 7 : (9 - weekday) % 7
        guard let nextMonday = cal.date(byAdding: .day, value: daysUntilMonday, to: now) else {
            return Date(timeIntervalSinceNow: 7 * 24 * 3600)
        }
        return cal.date(bySettingHour: 8, minute: 0, second: 0, of: nextMonday) ?? nextMonday
    }
}

// MARK: - Network Monitor

/// Monitors network connectivity and triggers sync on reconnection.
/// Equivalent of Android ConnectivityManager callbacks.
@Observable
final class NetworkMonitor {

    var isConnected: Bool = true

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "com.certifapp.network")

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            let connected = path.status == .satisfied
            DispatchQueue.main.async {
                let wasDisconnected = self?.isConnected == false
                self?.isConnected = connected
                if connected && wasDisconnected {
                    // Trigger sync when connectivity restored
                    NotificationCenter.default.post(name: .networkRestored, object: nil)
                }
            }
        }
        monitor.start(queue: queue)
    }
}

extension Notification.Name {
    static let networkRestored = Notification.Name("com.certifapp.networkRestored")
}
