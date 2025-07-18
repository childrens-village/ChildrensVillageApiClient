// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChildrensVillageApiClient",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ChildrensVillageApiClient",
            targets: ["ChildrensVillageApiClient"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(
          name: "JwtApiClient",
          url: "git@github.com:chris-kobrzak/JsonApiClient.git", .upToNextMinor(from: "4.0.0")
        ),
        .package(
          name: "Mockingbird",
          url: "https://github.com/birdrides/mockingbird.git", .upToNextMinor(from: "0.20.0")
        ),
        .package(
          name: "GenericJSON",
          url: "https://github.com/iwill/generic-json-swift.git", .upToNextMinor(from: "2.0.2")
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ChildrensVillageApiClient",
            dependencies: ["JwtApiClient"]),
        .testTarget(
            name: "ChildrensVillageApiClientTests",
            dependencies: ["GenericJSON", "Mockingbird", "JwtApiClient", "ChildrensVillageApiClient"]),
        // Temporarily uncomment for generating Mockingbird mocks
//        .target(
          // “Package” suffix below as it conflicts with an existing dependency
//           name: "JwtApiClient",
//           dependencies: ["Mockingbird"],
//           path: ".build/checkouts/JsonApiClient/Sources"),
    ]
)
