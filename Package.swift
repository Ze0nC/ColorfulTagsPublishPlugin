// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "ColorfulTagsPublishPlugin",
    platforms: [
        .macOS(.v12),
    ],
    products: [
        .library(
            name: "ColorfulTagsPublishPlugin",
            targets: ["ColorfulTagsPublishPlugin"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", exact: "0.9.0")
    ],
    targets: [
        .target(
            name: "ColorfulTagsPublishPlugin",
            dependencies: [
                .product(name: "Publish", package: "Publish"),
            ]
        ),
        .testTarget(
            name: "ColorfulTagsPublishPluginTests",
            dependencies: ["ColorfulTagsPublishPlugin"]
        ),
    ]
)
