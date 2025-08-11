// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreNetworking",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "CoreNetworking",
            targets: [
                "CoreNetworking"
            ]
        )
    ],
    dependencies: [
        .package(
            name: "CoreFoundational",
            path: "../Core/CoreFoundational"
        ),
        .package(
            name: "CoreTesting",
            path: "../Core/CoreTesting"
        )
    ],
    targets: [
        .target(
            name: "CoreNetworking",
            dependencies: [
                "CoreFoundational"
            ],
            path: "Sources/CoreNetworking"
        ),
        .testTarget(
            name: "CoreNetworkingTests",
            dependencies: [
                "CoreNetworking",
                "CoreTesting"
            ]
        ),
    ]
)
