// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PCLocale",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v10_15), .iOS(.v13),
    ],
    products: [
        .library(
            name: "PCLocale",
            targets: ["PCLocale"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "PCLocale",
            dependencies: [],
            resources: [.process("Resources")]),
        .testTarget(
            name: "PCLocaleTests",
            dependencies: ["PCLocale"]),
    ]
)
