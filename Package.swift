// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "JValidator",
    products: [.library(name: "JValidator", targets: ["JValidator"])],
    dependencies: [],
    targets: [
        .target(name: "JValidator", dependencies: []),
        .testTarget(name: "JValidatorTests", dependencies: ["JValidator"]),
    ],
    swiftLanguageVersions: [.v5]
)
