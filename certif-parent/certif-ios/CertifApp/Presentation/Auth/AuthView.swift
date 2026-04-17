// certif-ios/CertifApp/Presentation/Auth/AuthView.swift
//
// Login and registration screen.
// Shown when the user is not authenticated (controlled by RootView).

import SwiftUI

// MARK: - AuthView

struct AuthView: View {

    @EnvironmentObject var authService: AuthService
    @State private var mode: AuthMode = .login
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showPassword: Bool = false
    @FocusState private var focusedField: AuthField?

    enum AuthMode { case login, register }
    enum AuthField { case email, password, confirmPassword }

    // MARK: - View

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                // Logo + Title
                AuthHeader(mode: mode)

                // Form
                VStack(spacing: 16) {
                    // Email
                    LabeledTextField(
                        label: "Email",
                        placeholder: "vous@exemple.com",
                        text: $email,
                        keyboardType: .emailAddress,
                        autocapitalization: .none
                    )
                    .focused($focusedField, equals: .email)
                    .submitLabel(.next)
                    .onSubmit { focusedField = .password }

                    // Password
                    PasswordField(
                        label: "Mot de passe",
                        text: $password,
                        isVisible: showPassword,
                        toggle: { showPassword.toggle() }
                    )
                    .focused($focusedField, equals: .password)
                    .submitLabel(mode == .login ? .done : .next)
                    .onSubmit {
                        if mode == .login { submitAction() }
                        else { focusedField = .confirmPassword }
                    }

                    // Confirm password (register only)
                    if mode == .register {
                        PasswordField(
                            label: "Confirmer le mot de passe",
                            text: $confirmPassword,
                            isVisible: showPassword,
                            toggle: { showPassword.toggle() }
                        )
                        .focused($focusedField, equals: .confirmPassword)
                        .submitLabel(.done)
                        .onSubmit { submitAction() }

                        // Password match indicator
                        if !confirmPassword.isEmpty {
                            HStack {
                                Image(systemName: password == confirmPassword
                                      ? "checkmark.circle.fill" : "xmark.circle.fill")
                                Text(password == confirmPassword
                                     ? "Mots de passe identiques" : "Les mots de passe ne correspondent pas")
                                    .font(.caption)
                            }
                            .foregroundStyle(password == confirmPassword ? .green : .red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }

                // Error
                if let error = authService.errorMessage {
                    ErrorBannerView(message: error)
                }

                // Submit button
                Button(action: submitAction) {
                    Group {
                        if authService.isLoading {
                            ProgressView().tint(.white)
                        } else {
                            Text(mode == .login ? "Se connecter" : "Créer mon compte")
                                .font(.headline)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isFormValid ? Color.accentColor : Color.gray)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .disabled(!isFormValid || authService.isLoading)

                // Mode toggle
                Button {
                    withAnimation(.spring(duration: 0.3)) {
                        mode = mode == .login ? .register : .login
                        authService.errorMessage = nil
                        confirmPassword = ""
                    }
                } label: {
                    HStack(spacing: 4) {
                        Text(mode == .login ? "Pas encore de compte ?" : "Déjà inscrit ?")
                            .foregroundStyle(.secondary)
                        Text(mode == .login ? "S'inscrire" : "Se connecter")
                            .foregroundStyle(.accentColor)
                            .fontWeight(.semibold)
                    }
                    .font(.subheadline)
                }

                // Freemium notice
                if mode == .register {
                    FreemiumInfoBanner()
                }
            }
            .padding(24)
        }
        .scrollDismissesKeyboard(.interactively)
    }

    // MARK: - Validation

    private var isFormValid: Bool {
        let emailValid = email.contains("@") && email.contains(".")
        let passwordValid = password.count >= 8
        if mode == .login {
            return emailValid && passwordValid
        } else {
            return emailValid && passwordValid && password == confirmPassword
        }
    }

    // MARK: - Actions

    private func submitAction() {
        focusedField = nil
        if mode == .login {
            Task { await authService.login(email: email, password: password) }
        } else {
            Task {
                await authService.register(
                    email: email,
                    password: password,
                    locale: Locale.current.language.languageCode?.identifier ?? "fr",
                    timezone: TimeZone.current.identifier
                )
            }
        }
    }
}

// MARK: - AuthHeader

private struct AuthHeader: View {
    let mode: AuthView.AuthMode
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "graduationcap.fill")
                .font(.system(size: 56))
                .foregroundStyle(.accentColor)
            Text("CertifApp")
                .font(.largeTitle.bold())
            Text(mode == .login
                 ? "Connectez-vous pour continuer"
                 : "Créez votre compte gratuitement")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 20)
    }
}

// MARK: - LabeledTextField

private struct LabeledTextField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var autocapitalization: TextInputAutocapitalization = .sentences

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label).font(.caption.bold()).foregroundStyle(.secondary)
            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
                .textInputAutocapitalization(autocapitalization)
                .autocorrectionDisabled()
                .padding(12)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

// MARK: - PasswordField

private struct PasswordField: View {
    let label: String
    @Binding var text: String
    let isVisible: Bool
    let toggle: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label).font(.caption.bold()).foregroundStyle(.secondary)
            HStack {
                Group {
                    if isVisible {
                        TextField("••••••••", text: $text)
                    } else {
                        SecureField("••••••••", text: $text)
                    }
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                Button(action: toggle) {
                    Image(systemName: isVisible ? "eye.slash" : "eye")
                        .foregroundStyle(.secondary)
                }
            }
            .padding(12)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

// MARK: - FreemiumInfoBanner

private struct FreemiumInfoBanner: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("Compte gratuit inclut :", systemImage: "gift.fill")
                .font(.caption.bold()).foregroundStyle(.accentColor)
            VStack(alignment: .leading, spacing: 4) {
                BulletPoint("2 examens par certification")
                BulletPoint("20 questions maximum par examen")
                BulletPoint("Accès aux flashcards de base")
            }
        }
        .padding()
        .background(Color.accentColor.opacity(0.06))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

private struct BulletPoint: View {
    let text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        Label(text, systemImage: "checkmark").font(.caption).foregroundStyle(.secondary)
    }
}
