// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "email_contact_picker",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "email-contact-picker", targets: ["email_contact_picker"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "email_contact_picker",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ],
            resources: [
                .process("Resources/PrivacyInfo.xcprivacy")
            ]
        )
    ]
)
