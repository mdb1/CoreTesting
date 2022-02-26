// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreTesting",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "CoreTesting",
            targets: ["CoreTesting"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CoreTesting",
            dependencies: []
        ),
        .testTarget(
            name: "CoreTestingTests",
            dependencies: ["CoreTesting"]
        )
    ]
)
