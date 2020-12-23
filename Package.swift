// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LayoutInvalidating",
    products: [
        .library(
            name: "LayoutInvalidating",
            targets: ["LayoutInvalidating"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "LayoutInvalidating",
            dependencies: []),
        .testTarget(
            name: "LayoutInvalidatingTests",
            dependencies: ["LayoutInvalidating"]),
    ]
)
