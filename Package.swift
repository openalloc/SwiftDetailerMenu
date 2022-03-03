// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SwiftDetailerMenu",
    platforms: [.macOS("11.0"), .iOS("14.0")],
    products: [
        .library(name: "DetailerMenu", targets: ["DetailerMenu"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DetailerMenu",
            dependencies: [],
            path: "Sources"
        ),
//        .testTarget(
//            name: "DetailerTests",
//            dependencies: [
//                "Detailer",
//            ],
//            path: "Tests"
//        ),
    ]
)
