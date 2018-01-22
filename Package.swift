// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "sugar",
    dependencies: [
        .package(url: "https://github.com/JohnSundell/Releases.git", from: "2.0.0"),
        .package(url: "https://github.com/kylef/Commander.git", from: "0.8.0"),
        .package(url: "https://github.com/JohnSundell/ShellOut.git", from: "2.0.0")
    ],
    targets: [
        .target(
            name: "sugar",
            dependencies: ["sugar_core"]
        ),
        .target(
            name: "sugar_core",
            dependencies: ["Commander", "Releases", "ShellOut"]
        )
    ]
)
