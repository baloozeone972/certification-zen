// certif-ios/CertifApp/DI/DIContainer.swift
//
// Dependency injection container — iOS equivalent of Hilt @Module classes.
// Uses a manual service locator pattern (no Hilt on iOS).
// Justification: Swift n'a pas d'équivalent Hilt ; un container manuel offre
// un contrôle total et facilite les tests via protocol substitution.

import Foundation
import SwiftData

/// Central dependency injection container, configured at app startup.
/// All ViewModels access their dependencies through this container.
@Observable
final class DIContainer {

    // MARK: - Singleton

    static let shared = DIContainer()

    // MARK: - Services (public — injected via @EnvironmentObject)

    let keychainService: KeychainService
    let authService: AuthService
    let themeManager: ThemeManager
    let storeKitService: StoreKitService

    // MARK: - API Client

    let apiClient: APIClient

    // MARK: - Repositories

    private(set) var certificationRepository: any CertificationRepositoryProtocol
    private(set) var examRepository: any ExamRepositoryProtocol
    private(set) var learningRepository: any LearningRepositoryProtocol
    private(set) var userRepository: any UserRepositoryProtocol
    private(set) var communityRepository: any CommunityRepositoryProtocol
    private(set) var coachingRepository: any CoachingRepositoryProtocol
    private(set) var aiRepository: any AIRepositoryProtocol
    private(set) var paymentRepository: any PaymentRepositoryProtocol

    // MARK: - Init

    private init() {
        let keychain = KeychainService()
        self.keychainService = keychain

        let client = APIClient(keychainService: keychain)
        self.apiClient = client

        self.authService = AuthService(keychainService: keychain, apiClient: client)
        self.themeManager = ThemeManager()
        self.storeKitService = StoreKitService()

        // Repositories initialized with stub ModelContext — replaced in configure()
        let stubContext = try! ModelContainer(for: Schema([CertificationEntity.self])).mainContext
        self.certificationRepository = CertificationRepository(apiClient: client, modelContext: stubContext)
        self.examRepository = ExamRepository(apiClient: client, modelContext: stubContext)
        self.learningRepository = LearningRepository(apiClient: client, modelContext: stubContext)
        self.userRepository = UserRepository(apiClient: client, keychainService: keychain)
        self.communityRepository = CommunityRepository(apiClient: client)
        self.coachingRepository = CoachingRepository(apiClient: client)
        self.aiRepository = AIRepository(apiClient: client)
        self.paymentRepository = PaymentRepository(apiClient: client)
    }

    /// Called from CertifAppApp.onAppear with the real SwiftData ModelContext.
    func configure(modelContext: ModelContext) {
        certificationRepository = CertificationRepository(apiClient: apiClient, modelContext: modelContext)
        examRepository = ExamRepository(apiClient: apiClient, modelContext: modelContext)
        learningRepository = LearningRepository(apiClient: apiClient, modelContext: modelContext)
    }

    // MARK: - ViewModel Factories

    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(certificationRepository: certificationRepository, authService: authService)
    }

    func makeExamConfigViewModel(certificationId: String) -> ExamConfigViewModel {
        ExamConfigViewModel(
            certificationId: certificationId,
            examRepository: examRepository,
            certificationRepository: certificationRepository,
            authService: authService
        )
    }

    func makeExamEngineViewModel(session: ExamSessionDTO) -> ExamEngineViewModel {
        ExamEngineViewModel(session: session, examRepository: examRepository)
    }

    func makeFlashcardViewModel(certificationId: String) -> FlashcardViewModel {
        FlashcardViewModel(certificationId: certificationId, learningRepository: learningRepository)
    }

    func makeCourseViewModel(certificationId: String, themeCode: String) -> CourseViewModel {
        CourseViewModel(
            certificationId: certificationId,
            themeCode: themeCode,
            learningRepository: learningRepository
        )
    }

    func makeAdaptivePlanViewModel(certificationId: String) -> AdaptivePlanViewModel {
        AdaptivePlanViewModel(certificationId: certificationId, learningRepository: learningRepository)
    }

    func makeChallengeViewModel(certificationId: String) -> ChallengeViewModel {
        ChallengeViewModel(certificationId: certificationId, communityRepository: communityRepository)
    }

    func makeCertifiedWallViewModel() -> CertifiedWallViewModel {
        CertifiedWallViewModel(communityRepository: communityRepository)
    }

    func makeCoachViewModel() -> CoachViewModel {
        CoachViewModel(coachingRepository: coachingRepository)
    }

    func makeInterviewViewModel(certificationId: String) -> InterviewViewModel {
        InterviewViewModel(certificationId: certificationId, aiRepository: aiRepository)
    }

    func makeChatViewModel() -> ChatViewModel {
        ChatViewModel(aiRepository: aiRepository)
    }

    func makeProfileViewModel() -> ProfileViewModel {
        ProfileViewModel(
            userRepository: userRepository,
            authService: authService,
            storeKitService: storeKitService,
            paymentRepository: paymentRepository
        )
    }

    func makeHistoryViewModel() -> HistoryViewModel {
        HistoryViewModel(examRepository: examRepository, authService: authService)
    }
}

// ===========================================================================
// MARK: - AuthService
// ===========================================================================

/// Manages authentication state — shared across the entire app via @EnvironmentObject.
@Observable
final class AuthService {

    // MARK: - State

    var currentUser: AppUser?
    var isAuthenticated: Bool = false
    var isLoading: Bool = false
    var errorMessage: String?

    // MARK: - Dependencies

    private let keychainService: KeychainService
    private let apiClient: APIClient

    init(keychainService: KeychainService, apiClient: APIClient) {
        self.keychainService = keychainService
        self.apiClient = apiClient
        self.isAuthenticated = keychainService.isAuthenticated
    }

    // MARK: - Actions

    func login(email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        do {
            let tokens: TokenPairDTO = try await apiClient.request(
                .post("/api/v1/auth/login", body: LoginRequestDTO(email: email, password: password))
            )
            keychainService.save(accessToken: tokens.accessToken, refreshToken: tokens.refreshToken)
            await fetchCurrentUser()
            isAuthenticated = true
        } catch {
            errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
        }
        isLoading = false
    }

    func register(email: String, password: String, locale: String = "fr", timezone: String = TimeZone.current.identifier) async {
        isLoading = true
        errorMessage = nil
        do {
            let _: UserDTO = try await apiClient.request(
                .post("/api/v1/auth/register", body: RegisterRequestDTO(
                    email: email, password: password, locale: locale, timezone: timezone
                ))
            )
            await login(email: email, password: password)
        } catch {
            errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
        }
        isLoading = false
    }

    func logout() {
        keychainService.clearTokens()
        currentUser = nil
        isAuthenticated = false
    }

    @MainActor
    func fetchCurrentUser() async {
        do {
            let dto: UserDTO = try await apiClient.request(.get("/api/v1/users/me"))
            currentUser = AppUser(
                id: dto.id,
                email: dto.email,
                role: AppUser.UserRole(rawValue: dto.role) ?? .user,
                subscriptionTier: AppUser.SubscriptionTier(rawValue: dto.subscriptionTier) ?? .free,
                locale: dto.locale,
                timezone: dto.timezone,
                isActive: dto.isActive
            )
            keychainService.save(userId: dto.id)
        } catch {
            // Non-fatal — user remains unauthenticated
        }
    }
}

// ===========================================================================
// MARK: - ThemeManager
// ===========================================================================

/// Manages the app-wide color scheme (light / dark / system).
@Observable
final class ThemeManager {

    enum AppTheme: String, CaseIterable {
        case light  = "LIGHT"
        case dark   = "DARK"
        case system = "SYSTEM"

        var displayName: String {
            switch self {
            case .light:  return "Clair"
            case .dark:   return "Sombre"
            case .system: return "Système"
            }
        }
    }

    var currentTheme: AppTheme = .system

    init() {
        let stored = UserDefaults.standard.string(forKey: "app_theme") ?? "SYSTEM"
        currentTheme = AppTheme(rawValue: stored) ?? .system
    }

    func setTheme(_ theme: AppTheme) {
        currentTheme = theme
        UserDefaults.standard.set(theme.rawValue, forKey: "app_theme")
    }
}
