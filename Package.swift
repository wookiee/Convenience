// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Convenience",
    
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
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
