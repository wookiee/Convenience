// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MWConvenience",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "MWConvenience",
            targets: ["MWConvenience"]),
    ],
    targets: [
        .target(
            name: "MWConvenience",
            dependencies: []),
        .testTarget(
            name: "MWConvenienceTests",
            dependencies: ["MWConvenience"]),
    ]
)
