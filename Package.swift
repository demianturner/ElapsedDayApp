// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ElapsedDayShared",
    platforms: [
        .iOS(.v14),
        .watchOS(.v7),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "ElapsedDayShared",
            targets: ["ElapsedDayShared"]),
    ],
    dependencies: [
        // Add any external dependencies here if needed
    ],
    targets: [
        .target(
            name: "ElapsedDayShared",
            dependencies: [],
            path: "Sources/ElapsedDayShared"
        ),
        .testTarget(
            name: "ElapsedDaySharedTests",
            dependencies: ["ElapsedDayShared"],
            path: "Tests/ElapsedDaySharedTests"
        ),
    ]
) 