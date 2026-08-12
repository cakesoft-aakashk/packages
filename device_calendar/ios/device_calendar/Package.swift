// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "device_calendar",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "device-calendar", targets: ["device_calendar"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "device_calendar",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ]
        )
    ]
)
