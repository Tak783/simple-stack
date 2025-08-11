// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MockNetworking",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "MockNetworking",
            targets: [
                "MockNetworking"
            ]
        ),
    ],
    dependencies: [
        .package(
            name: "CoreFoundational",
            path: "../Core/CoreFoundational"
        ),
        .package(
            name: "CoreTesting",
            path: "../CoreTesting"
        ),
        .package(
            name: "CoreNetworking",
            path: "../CoreComponents/Sources/CoreNetworking"
        ),
    ],
    targets: [
        .target(
            name: "MockNetworking",
            dependencies: [
                "CoreFoundational",
                "CoreNetworking"
            ]
        )
    ]
)
