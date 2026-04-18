// certif-parent/certif-ios/Package.swift
// Swift Package Manager — external dependencies for CertifApp iOS module.
// Swift 5.10 / iOS 17+
// Note: KeychainAccess removed — using native Security framework instead.

// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "CertifApp",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "CertifApp", targets: ["CertifApp"])
    ],
    dependencies: [
        // Markdown rendering (course content + revision sheets)
        .package(
            url: "https://github.com/gonzalezreal/swift-markdown-ui",
            from: "2.3.1"
        ),
        // Lottie animations (onboarding + success screens)
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
                .product(name: "Lottie", package: "lottie-spm")
            ],
            path: "CertifApp"
        ),
        .testTarget(
            name: "CertifAppTests",
            dependencies: ["CertifApp"],
            path: "CertifAppTests"
        )
    ]
)
