// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CorePresentation",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CorePresentation",
            targets: ["CorePresentation"]),
    ],
    dependencies: [
        .package(
            name: "CoreFoundational",
            path: "../Core/CoreFoundational"
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CorePresentation",
            dependencies: [
                "CoreFoundational"
            ]
        ),
        .testTarget(
            name: "CorePresentationTests",
            dependencies: ["CorePresentation"]
        ),
    ]
)
