// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Convenience",
    
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7)
    ],
    
    products: [
        .library(
            name: "Convenience",
            targets: ["Convenience"]),
    ],
    
    targets: [
        .target(
            name: "Convenience",
            dependencies: []),
        .testTarget(
            name: "ConvenienceTests",
            dependencies: ["Convenience"]),
    ]
)
