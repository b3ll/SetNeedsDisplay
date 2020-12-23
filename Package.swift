// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SetNeedsDisplay",
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
    ]
)
