// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SetNeedsDisplay",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13),
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "SetNeedsDisplay",
            targets: ["SetNeedsDisplay"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SetNeedsDisplay",
            dependencies: []),
        .testTarget(
            name: "SetNeedsDisplayTests",
            dependencies: ["SetNeedsDisplay"]),
    ],
    swiftLanguageVersions: [.v5]
)
