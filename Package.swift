// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "HaskellSwift",
    platforms: [
    .macOS(.v10_15),
    ],
    products: [
        .library(name: "HaskellSwift", targets: ["HaskellSwift"]),
    ],
    targets: [
    .target(name: "HaskellSwift", dependencies: []),
//    .testTarget(name: "HaskellSwiftTests", dependencies: ["HaskellSwift"]),
    ]
)
