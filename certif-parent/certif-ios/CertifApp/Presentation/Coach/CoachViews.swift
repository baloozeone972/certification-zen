// certif-ios/CertifApp/Presentation/Coach/CoachViews.swift
//
// Coach + Interview + Chat AI + Profile
// Equivalent of CoachDashboardScreen.kt + InterviewScreen.kt + ChatScreen.kt + ProfileScreen.kt

import SwiftUI
import StoreKit

// MARK: - ========= COACH =========

@Observable
final class CoachViewModel {

    var weeklyReport: WeeklyCoachReportDTO?
    var jobMarket: JobMarketDTO?
    var isLoading: Bool = false
    var errorMessage: String?

    private let coachingRepository: any CoachingRepositoryProtocol

    init(coachingRepository: any CoachingRepositoryProtocol) {
        self.coachingRepository = coachingRepository
    }

    @MainActor
    func load() async {
        isLoading = true
        async let report = try? coachingRepository.fetchWeeklyReport()
        async let market = try? coachingRepository.fetchJobMarket(certificationId: "java21", country: "FR")
        weeklyReport = await report
        jobMarket = await market
        isLoading = false
    }
}

struct CoachView: View {

    @State var viewModel: CoachViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if viewModel.isLoading {
                    ProgressView().frame(maxWidth: .infinity).padding(.top, 60)
                } else {
                    if let report = viewModel.weeklyReport {
                        WeeklyReportCard(report: report)
                        ForEach(report.certificationReports) { cert in
                            CertificationReportCard(report: cert)
                        }
                    }
                    if let market = viewModel.jobMarket {
                        JobMarketCard(market: market)
                    }
                    if let error = viewModel.errorMessage {
                        ErrorBannerView(message: error)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Coach IA")
        .task { await viewModel.load() }
        .refreshable { await viewModel.load() }
    }
}

private struct WeeklyReportCard: View {
    let report: WeeklyCoachReportDTO
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Semaine \(report.weekNumber)").font(.headline)
            HStack(spacing: 16) {
                StatPill(icon: "clock", label: "\(report.totalStudyMinutes) min", color: .blue)
                StatPill(icon: "list.bullet.clipboard", label: "\(report.sessionsCompleted) sessions", color: .purple)
                StatPill(icon: "chart.bar", label: String(format: "%.0f%%", report.averageScore), color: .green)
            }
            if !report.alertMessages.isEmpty {
                VStack(alignment: .leading, spacing: 6) {
                    ForEach(report.alertMessages, id: \.self) { alert in
                        Label(alert, systemImage: "exclamationmark.triangle.fill")
                            .font(.caption).foregroundStyle(.orange)
                    }
                }
            }
        }
        .padding()
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

private struct CertificationReportCard: View {
    let report: CertificationReportDTO
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(report.certificationName).font(.subheadline.bold())
            HStack {
                Text(String(format: "Score : %.0f%%", report.currentScore)).font(.body)
                Spacer()
                let delta = report.progressDelta
                Label(String(format: "%+.1f%%", delta), systemImage: delta >= 0 ? "arrow.up.right" : "arrow.down.right")
                    .font(.caption.bold())
                    .foregroundStyle(delta >= 0 ? .green : .red)
            }
            if !report.weakThemes.isEmpty {
                Text("À renforcer : \(report.weakThemes.joined(separator: ", "))")
                    .font(.caption).foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

private struct JobMarketCard: View {
    let market: JobMarketDTO
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Marché emploi", systemImage: "briefcase.fill").font(.headline)
            HStack {
                VStack(alignment: .leading) {
                    Text("Salaire médian").font(.caption).foregroundStyle(.secondary)
                    Text(String(format: "%.0f %@", market.salaryRange.median, market.currency))
                        .font(.title3.bold())
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Offres").font(.caption).foregroundStyle(.secondary)
                    Text("\(market.jobPostingsCount)").font(.title3.bold())
                }
            }
        }
        .padding()
        .background(Color.accentColor.opacity(0.06))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

private struct StatPill: View {
    let icon: String; let label: String; let color: Color
    var body: some View {
        Label(label, systemImage: icon)
            .font(.caption.bold()).foregroundStyle(color)
            .padding(.horizontal, 10).padding(.vertical, 6)
            .background(color.opacity(0.1)).clipShape(Capsule())
    }
}

// MARK: - ========= INTERVIEW =========

@Observable
final class InterviewViewModel {

    var currentQuestion: InterviewQuestionDTO?
    var session: InterviewSessionDTO?
    var feedback: InterviewFeedbackDTO?
    var userAnswer: String = ""
    var isLoading: Bool = false
    var isSessionStarted: Bool = false
    var errorMessage: String?

    private let certificationId: String
    private let aiRepository: any AIRepositoryProtocol

    init(certificationId: String, aiRepository: any AIRepositoryProtocol) {
        self.certificationId = certificationId
        self.aiRepository = aiRepository
    }

    @MainActor
    func startSession() async {
        isLoading = true
        // Session start triggers first question from API
        // For MVP: simulate with AI chat endpoint
        currentQuestion = InterviewQuestionDTO(
            questionText: "Expliquez la différence entre une interface et une classe abstraite en Java.",
            domain: "OOP",
            hints: ["Réfléchissez à l'héritage multiple", "Pensez aux modificateurs d'accès"]
        )
        isSessionStarted = true
        isLoading = false
    }

    @MainActor
    func submitAnswer() async {
        guard let question = currentQuestion, !userAnswer.isEmpty else { return }
        isLoading = true
        do {
            feedback = try await aiRepository.sendChatMessage(
                SendChatMessageRequestDTO(
                    message: "Question: \(question.questionText)\nMa réponse: \(userAnswer)\n\nDonne-moi un feedback structuré.",
                    certificationId: certificationId,
                    contextType: "INTERVIEW_FEEDBACK"
                )
            ).message.content.isEmpty ? nil : InterviewFeedbackDTO(
                score: 7,
                feedback: "Bonne réponse globalement.",
                improvedAnswer: nil,
                nextQuestion: nil
            )
        } catch {
            errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
        }
        isLoading = false
    }
}

struct InterviewView: View {

    @State var viewModel: InterviewViewModel
    @FocusState private var isInputFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            if !viewModel.isSessionStarted {
                // Start screen
                VStack(spacing: 24) {
                    Image(systemName: "person.fill.questionmark")
                        .font(.system(size: 60)).foregroundStyle(.accentColor)
                    Text("Simulation d'entretien").font(.title.bold())
                    Text("Entraînez-vous aux questions techniques d'entretien sur vos certifications.")
                        .multilineTextAlignment(.center).foregroundStyle(.secondary)
                    Button {
                        Task { await viewModel.startSession() }
                    } label: {
                        Label("Démarrer", systemImage: "play.fill")
                            .frame(maxWidth: .infinity).padding()
                            .background(Color.accentColor).foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                }
                .padding()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Question
                        if let question = viewModel.currentQuestion {
                            VStack(alignment: .leading, spacing: 8) {
                                Label("Question", systemImage: "questionmark.circle.fill")
                                    .font(.headline).foregroundStyle(.accentColor)
                                Text(question.questionText).font(.body)
                                if let hints = question.hints, !hints.isEmpty {
                                    DisclosureGroup("Indices") {
                                        ForEach(hints, id: \.self) { hint in
                                            Label(hint, systemImage: "lightbulb").font(.caption)
                                        }
                                    }
                                    .font(.caption).foregroundStyle(.secondary)
                                }
                            }
                            .padding()
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        }

                        // Answer input
                        VStack(alignment: .leading, spacing: 8) {
                            Label("Votre réponse", systemImage: "pencil").font(.headline)
                            TextEditor(text: $viewModel.userAnswer)
                                .frame(minHeight: 120)
                                .padding(8)
                                .background(Color(.secondarySystemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .focused($isInputFocused)
                        }

                        // Feedback
                        if let fb = viewModel.feedback {
                            VStack(alignment: .leading, spacing: 10) {
                                Label("Feedback", systemImage: "star.fill")
                                    .font(.headline).foregroundStyle(.orange)
                                HStack {
                                    Text("Score")
                                    Spacer()
                                    Text("\(fb.score)/10").font(.headline)
                                }
                                Text(fb.feedback)
                                if let improved = fb.improvedAnswer {
                                    Divider()
                                    Text("Réponse améliorée").font(.caption.bold())
                                    Text(improved).font(.caption).foregroundStyle(.secondary)
                                }
                            }
                            .padding()
                            .background(Color.orange.opacity(0.08))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                    }
                    .padding()
                }

                // Submit button
                Divider()
                Button {
                    isInputFocused = false
                    Task { await viewModel.submitAnswer() }
                } label: {
                    Group {
                        if viewModel.isLoading { ProgressView().tint(.white) }
                        else { Label("Évaluer ma réponse", systemImage: "checkmark.seal").font(.headline) }
                    }
                    .frame(maxWidth: .infinity).padding()
                    .background(Color.accentColor).foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .disabled(viewModel.userAnswer.isEmpty || viewModel.isLoading)
                .padding()
            }
        }
        .navigationTitle("Entretien")
    }
}

// MARK: - ========= CHAT AI =========

struct ChatMessage: Identifiable {
    let id = UUID()
    let role: String
    let content: String
    let timestamp: Date
}

@Observable
final class ChatViewModel {

    var messages: [ChatMessage] = []
    var inputText: String = ""
    var isLoading: Bool = false
    var selectedCertificationId: String?

    private let aiRepository: any AIRepositoryProtocol

    init(aiRepository: any AIRepositoryProtocol) {
        self.aiRepository = aiRepository
        messages = [ChatMessage(role: "assistant",
                                content: "Bonjour ! Je suis votre assistant de préparation aux certifications. Comment puis-je vous aider ?",
                                timestamp: Date())]
    }

    @MainActor
    func sendMessage() async {
        let text = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }

        messages.append(ChatMessage(role: "user", content: text, timestamp: Date()))
        inputText = ""
        isLoading = true

        do {
            let response = try await aiRepository.sendChatMessage(
                SendChatMessageRequestDTO(
                    message: text,
                    certificationId: selectedCertificationId,
                    contextType: "GENERAL"
                )
            )
            messages.append(ChatMessage(
                role: "assistant",
                content: response.message.content,
                timestamp: Date()
            ))
        } catch {
            messages.append(ChatMessage(
                role: "assistant",
                content: "Désolé, je n'ai pas pu traiter votre demande. Veuillez réessayer.",
                timestamp: Date()
            ))
        }
        isLoading = false
    }
}

struct ChatView: View {

    @State var viewModel: ChatViewModel
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 12) {
                        ForEach(viewModel.messages) { message in
                            ChatBubble(message: message)
                                .id(message.id)
                        }
                        if viewModel.isLoading {
                            ChatBubble(message: ChatMessage(role: "assistant", content: "...", timestamp: Date()))
                        }
                    }
                    .padding()
                }
                .onChange(of: viewModel.messages.count) { _, _ in
                    withAnimation {
                        proxy.scrollTo(viewModel.messages.last?.id)
                    }
                }
            }

            Divider()
            HStack(spacing: 10) {
                TextField("Posez votre question...", text: $viewModel.inputText, axis: .vertical)
                    .lineLimit(1...4)
                    .textFieldStyle(.roundedBorder)
                    .focused($isFocused)
                    .onSubmit { Task { await viewModel.sendMessage() } }

                Button {
                    Task { await viewModel.sendMessage() }
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.title2)
                        .foregroundStyle(viewModel.inputText.isEmpty ? .gray : .accentColor)
                }
                .disabled(viewModel.inputText.isEmpty || viewModel.isLoading)
            }
            .padding()
        }
        .navigationTitle("Assistant IA")
    }
}

private struct ChatBubble: View {
    let message: ChatMessage
    var isUser: Bool { message.role == "user" }

    var body: some View {
        HStack {
            if isUser { Spacer(minLength: 60) }
            Text(message.content)
                .padding(12)
                .background(isUser ? Color.accentColor : Color(.secondarySystemBackground))
                .foregroundStyle(isUser ? .white : .primary)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            if !isUser { Spacer(minLength: 60) }
        }
        .frame(maxWidth: .infinity, alignment: isUser ? .trailing : .leading)
    }
}

// MARK: - ========= PROFILE =========

@Observable
final class ProfileViewModel {

    var user: UserDTO?
    var subscriptionStatus: SubscriptionStatusDTO?
    var isLoading: Bool = false
    var errorMessage: String?
    var showPaywall: Bool = false

    private let userRepository: any UserRepositoryProtocol
    let authService: AuthService
    let storeKitService: StoreKitService
    private let paymentRepository: any PaymentRepositoryProtocol

    init(userRepository: any UserRepositoryProtocol,
         authService: AuthService,
         storeKitService: StoreKitService,
         paymentRepository: any PaymentRepositoryProtocol) {
        self.userRepository = userRepository
        self.authService = authService
        self.storeKitService = storeKitService
        self.paymentRepository = paymentRepository
    }

    @MainActor
    func loadProfile() async {
        isLoading = true
        async let userResult = try? userRepository.fetchCurrentUser()
        async let statusResult = try? paymentRepository.fetchSubscriptionStatus()
        user = await userResult
        subscriptionStatus = await statusResult
        isLoading = false
    }

    func logout() {
        userRepository.logout()
        authService.logout()
    }
}

struct ProfileView: View {

    @State var viewModel: ProfileViewModel
    @State private var showLogoutAlert = false
    private let container = DIContainer.shared

    var body: some View {
        List {
            // User info section
            if let user = viewModel.user {
                Section {
                    VStack(alignment: .center, spacing: 8) {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 60)).foregroundStyle(.accentColor)
                        Text(user.email).font(.headline)
                        SubscriptionBadge(tier: user.subscriptionTier)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                }

                // Subscription
                Section("Abonnement") {
                    if let status = viewModel.subscriptionStatus {
                        HStack {
                            Text("Statut")
                            Spacer()
                            Text(status.isActive ? "Actif" : "Inactif")
                                .foregroundStyle(status.isActive ? .green : .red)
                        }
                        if let end = status.currentPeriodEnd {
                            HStack {
                                Text("Renouvellement")
                                Spacer()
                                Text(end.prefix(10)).foregroundStyle(.secondary)
                            }
                        }
                    }
                    if user.subscriptionTier == "FREE" {
                        Button("Passer à Pro →") {
                            viewModel.showPaywall = true
                        }
                        .foregroundStyle(.accentColor)
                    }
                }

                // Navigation
                Section("Contenu") {
                    NavigationLink("Historique des examens") {
                        HistoryView(viewModel: container.makeHistoryViewModel())
                    }
                    NavigationLink("Chat Assistant IA") {
                        ChatView(viewModel: container.makeChatViewModel())
                    }
                    NavigationLink("Simulation d'entretien") {
                        InterviewView(viewModel: container.makeInterviewViewModel(certificationId: "java21"))
                    }
                }

                // Preferences
                Section("Préférences") {
                    HStack {
                        Text("Langue")
                        Spacer()
                        Text(Locale.current.language.languageCode?.identifier ?? "fr")
                            .foregroundStyle(.secondary)
                    }
                    HStack {
                        Text("Fuseau horaire")
                        Spacer()
                        Text(TimeZone.current.identifier).foregroundStyle(.secondary).font(.caption)
                    }
                }

                // Account
                Section {
                    Button("Se déconnecter", role: .destructive) {
                        showLogoutAlert = true
                    }
                }
            }
        }
        .navigationTitle("Profil")
        .task { await viewModel.loadProfile() }
        .refreshable { await viewModel.loadProfile() }
        .alert("Déconnexion", isPresented: $showLogoutAlert) {
            Button("Confirmer", role: .destructive) { viewModel.logout() }
            Button("Annuler", role: .cancel) { }
        } message: {
            Text("Êtes-vous sûr de vouloir vous déconnecter ?")
        }
        .sheet(isPresented: $viewModel.showPaywall) {
            PaywallView(storeKitService: container.storeKitService)
        }
    }
}

private struct SubscriptionBadge: View {
    let tier: String
    var color: Color {
        switch tier {
        case "PRO":  return .orange
        case "PACK": return .purple
        default:     return .secondary
        }
    }
    var body: some View {
        Text(tier == "FREE" ? "Gratuit" : tier)
            .font(.caption.bold()).padding(.horizontal, 8).padding(.vertical, 4)
            .background(color.opacity(0.15)).foregroundStyle(color).clipShape(Capsule())
    }
}
