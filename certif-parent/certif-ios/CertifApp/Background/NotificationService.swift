// certif-ios/CertifApp/Background/NotificationService.swift
//
// Local notification scheduling using UNUserNotificationCenter.
// Equivalent of Android CoachNotificationWorker.kt.
// Handles: weekly coach report, flashcard review reminders, challenge alerts.

import UserNotifications
import Foundation

// MARK: - NotificationService

/// Manages local notification scheduling and permission.
final class NotificationService: NSObject {

    // MARK: - Singleton

    static let shared = NotificationService()

    // MARK: - Init

    override private init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }

    // MARK: - Permission

    /// Requests notification permission from the user.
    func requestPermission() async -> Bool {
        do {
            return try await UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .badge, .sound]
            )
        } catch {
            return false
        }
    }

    // MARK: - Weekly Coach Report (Monday 08:00)
    // Equivalent of CoachNotificationWorker.kt

    func scheduleWeeklyCoachReport() {
        let content = UNMutableNotificationContent()
        content.title = "📊 Votre rapport hebdo est prêt"
        content.body  = "Découvrez vos progrès de la semaine et votre plan pour la prochaine."
        content.sound = .default
        content.categoryIdentifier = NotificationCategory.coachReport

        var components = DateComponents()
        components.weekday = 2  // Monday (1=Sun, 2=Mon)
        components.hour    = 8
        components.minute  = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(
            identifier: NotificationID.weeklyCoach,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }

    /// Sends immediate coach reminder (called from background task).
    func sendWeeklyCoachReminder() async {
        let content = UNMutableNotificationContent()
        content.title = "📊 Rapport hebdomadaire"
        content.body  = "Consultez vos progrès de la semaine dans CertifApp."
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(
            identifier: "\(NotificationID.weeklyCoach)_now",
            content: content,
            trigger: trigger
        )
        try? await UNUserNotificationCenter.current().add(request)
    }

    // MARK: - Flashcard Review Reminder

    /// Schedules a daily reminder for flashcard reviews at the given hour.
    func scheduleFlashcardReminder(hour: Int = 19) {
        let content = UNMutableNotificationContent()
        content.title = "🃏 Révisions du jour"
        content.body  = "Vous avez des flashcards à réviser. 5 minutes suffisent !"
        content.sound = .default
        content.categoryIdentifier = NotificationCategory.flashcardReview

        var components = DateComponents()
        components.hour   = hour
        components.minute = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(
            identifier: NotificationID.flashcardReview,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }

    // MARK: - Challenge Reminder

    /// Schedules a notification 24h before a challenge ends.
    func scheduleChallengeReminder(challengeTitle: String, endsAt: Date) {
        let reminderDate = endsAt.addingTimeInterval(-24 * 3600)
        guard reminderDate > Date() else { return }

        let content = UNMutableNotificationContent()
        content.title = "⏰ Challenge se termine bientôt"
        content.body  = "\(challengeTitle) se termine dans 24h. Participez avant la fin !"
        content.sound = .default
        content.categoryIdentifier = NotificationCategory.challenge

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: reminderDate),
            repeats: false
        )
        let request = UNNotificationRequest(
            identifier: "\(NotificationID.challengeReminder)_\(endsAt.timeIntervalSince1970)",
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }

    // MARK: - Exam Streak Reminder

    /// Schedules a streak-preservation notification if no activity for 48h.
    func scheduleStreakReminder(afterInactivityHours: Double = 48) {
        removeNotification(id: NotificationID.streakReminder)

        let content = UNMutableNotificationContent()
        content.title = "🔥 Ne brisez pas votre série !"
        content.body  = "Faites un rapide examen ou quelques flashcards pour maintenir votre progression."
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: afterInactivityHours * 3600,
            repeats: false
        )
        let request = UNNotificationRequest(
            identifier: NotificationID.streakReminder,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }

    // MARK: - Cancel

    func removeNotification(id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }

    func removeAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    // MARK: - Categories Setup

    /// Registers notification action categories (call once at startup).
    func setupCategories() {
        let openAction = UNNotificationAction(
            identifier: "OPEN",
            title: "Ouvrir",
            options: .foreground
        )
        let dismissAction = UNNotificationAction(
            identifier: "DISMISS",
            title: "Plus tard",
            options: .destructive
        )

        let reportCategory = UNNotificationCategory(
            identifier: NotificationCategory.coachReport,
            actions: [openAction, dismissAction],
            intentIdentifiers: []
        )
        let flashcardCategory = UNNotificationCategory(
            identifier: NotificationCategory.flashcardReview,
            actions: [openAction, dismissAction],
            intentIdentifiers: []
        )
        let challengeCategory = UNNotificationCategory(
            identifier: NotificationCategory.challenge,
            actions: [openAction, dismissAction],
            intentIdentifiers: []
        )

        UNUserNotificationCenter.current().setNotificationCategories([
            reportCategory, flashcardCategory, challengeCategory
        ])
    }
}

// MARK: - UNUserNotificationCenterDelegate

extension NotificationService: UNUserNotificationCenterDelegate {

    /// Displays notifications while app is in the foreground.
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification
    ) async -> UNNotificationPresentationOptions {
        [.banner, .badge, .sound]
    }

    /// Handles notification tap actions.
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse
    ) async {
        let categoryId = response.notification.request.content.categoryIdentifier
        switch categoryId {
        case NotificationCategory.coachReport:
            // Deep link to coach tab — post notification for RootView to handle
            NotificationCenter.default.post(name: .deepLinkCoach, object: nil)
        case NotificationCategory.flashcardReview:
            NotificationCenter.default.post(name: .deepLinkFlashcards, object: nil)
        case NotificationCategory.challenge:
            NotificationCenter.default.post(name: .deepLinkCommunity, object: nil)
        default:
            break
        }
    }
}

// MARK: - Constants

private enum NotificationID {
    static let weeklyCoach      = "com.certifapp.notification.weeklycoach"
    static let flashcardReview  = "com.certifapp.notification.flashcard"
    static let challengeReminder = "com.certifapp.notification.challenge"
    static let streakReminder    = "com.certifapp.notification.streak"
}

private enum NotificationCategory {
    static let coachReport     = "COACH_REPORT"
    static let flashcardReview = "FLASHCARD_REVIEW"
    static let challenge       = "CHALLENGE"
}

// MARK: - Deep Link Notification Names

extension Notification.Name {
    static let deepLinkCoach      = Notification.Name("com.certifapp.deeplink.coach")
    static let deepLinkFlashcards = Notification.Name("com.certifapp.deeplink.flashcards")
    static let deepLinkCommunity  = Notification.Name("com.certifapp.deeplink.community")
}
