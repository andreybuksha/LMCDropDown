// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "LMCDropDown",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(name: "LMCDropDown", targets: ["LMCDropDown"]),
    ],
    targets: [
        .target(name: "LMCDropDown", path: "LMCDropDown")
    ]
)
