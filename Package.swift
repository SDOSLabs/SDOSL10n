// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SDOSL10n",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .executable(
            name: "SDOSL10nScript",
            targets: ["SDOSL10nScript"]
        ),
        .library(
            name: "SDOSL10nSwift",
            targets: ["SDOSL10nSwift"]
        )
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "SDOSL10nScript",
                dependencies: ["SDOSL10nSwift"],
                path: "src/Scripts/Classes/SDOSLocalizable",
                exclude: ["Swift"],
                publicHeadersPath: "",
                cSettings: [
                    .headerSearchPath("ConsoleParameter"),
                    .headerSearchPath("Constants"),
                    .headerSearchPath("ScriptAction/LanguageCollectionObject"),
                    .headerSearchPath("ScriptAction/LanguageObject"),
                    .headerSearchPath("ScriptAction"),
                    .headerSearchPath("Util"),
                      ]
        ),
        .target(name: "SDOSL10nSwift",
                path: "src/Scripts/Classes/SDOSLocalizable/Swift")
    ]
)
