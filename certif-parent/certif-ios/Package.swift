// certif-ios/Package.swift
// Swift Package Manager — dépendances externes du module iOS CertifApp
// Swift 5.10 / iOS 17+

// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "CertifApp",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "CertifApp",
            targets: ["CertifApp"]
        )
    ],
    dependencies: [
        // Markdown rendering (cours + fiches de révision)
        .package(
            url: "https://github.com/gonzalezreal/swift-markdown-ui",
            from: "2.3.1"
        ),
        // Keychain wrapper — stockage sécurisé JWT
        .package(
            url: "https://github.com/kishikawakatsumi/KeychainAccess",
            from: "4.2.2"
        ),
        // Lottie — animations onboarding + success screens
        .package(
            url: "https://github.com/airbnb/lottie-spm",
            from: "4.4.3"
        )
    ],
    targets: [
        .target(
            name: "CertifApp",
            dependencies: [
                .product(name: "MarkdownUI", package: "swift-markdown-ui"),
                .product(name: "KeychainAccess", package: "KeychainAccess"),
                .product(name: "Lottie", package: "lottie-spm")
            ]
        ),
        .testTarget(
            name: "CertifAppTests",
            dependencies: ["CertifApp"]
        )
    ]
)
