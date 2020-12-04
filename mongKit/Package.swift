// swift-tools-version:5.3
import PackageDescription

// master list
let package = Package(
    name        : "mongKit",
    platforms:  [ SupportedPlatform.iOS(.v12) ],
    products    : [ .library(name: "mongKit",
                             targets: [ "mongKitCore", "mongKitNetworking", "mongKitStructure", "mongKitView" ]),
                    .library(name: "mongKitCore",
                             targets: [ "mongKitCore" ]),
                    .library(name: "mongKitNetworking",
                             targets: [ "mongKitNetworking" ]),
                    .library(name: "mongKitStructure",
                             targets: [ "mongKitStructure" ]),
                    .library(name: "mongKitView",
                             targets: [ "mongKitView" ]), ],
    dependencies: [ .package(url: "https://github.com/ReactiveCocoa/ReactiveSwift.git", from: "6.1.0"),
                    .package(url: "https://github.com/ReactiveCocoa/ReactiveCocoa.git", Package.Dependency.Requirement.branch("master")) ],
    targets     : [ .target(name: "mongKitCore",
                            dependencies: [ "ReactiveSwift", "ReactiveCocoa" ],
                            path: "mongKit.core"),
                    .target(name: "mongKitNetworking",
                            dependencies: [ "ReactiveSwift", "ReactiveCocoa", "mongKitCore" ],
                            path: "mongKit.networking"),
                    .target(name: "mongKitStructure",
                            dependencies: [ "ReactiveSwift", "ReactiveCocoa", "mongKitCore" ],
                            path: "mongKit.structure"),
                    .target(name: "mongKitView",
                            dependencies: [ "ReactiveSwift", "ReactiveCocoa", "mongKitCore", "mongKitStructure" ],
                            path: "mongKit.view")
    ])
