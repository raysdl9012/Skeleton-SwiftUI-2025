import Foundation
import ProjectDescription

// MARK: - Base Settings

private let name = "Project"
private let bundleIdentifier = "com.rsdl.project"
private let organization = "rsdl"

let baseSettings: SettingsDictionary = [:]

func debugSettings() -> SettingsDictionary {
    var settings = baseSettings
    settings["ENABLE_TESTABILITY"] = "YES"
    return settings
}

func stagingSettings() -> SettingsDictionary {
    var settings = baseSettings
    return settings
}

func releaseSettings() -> SettingsDictionary {
    var settings = baseSettings
    return settings
}

// MARK: - Project Definition
let project = Project(
    name: "\(name)",
    organizationName: "\(organization)",
    settings: .settings(
        configurations: [
            .debug(name: "Debug",
                   settings: debugSettings(),
                   xcconfig: "Configuration/xcconfigs/Debug.xcconfig"),
            .debug(name: "Staging",
                   settings: stagingSettings(),
                   xcconfig: "Configuration/xcconfigs/Staging.xcconfig"),
            .release(name: "Release",
                     settings: releaseSettings(),
                     xcconfig: "Configuration/xcconfigs/Release.xcconfig")
        ]
    ),
    targets: [
        .target(
            name: "\(name)",
            destinations: .iOS,
            product: .app,
            bundleId: "\(bundleIdentifier)",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            buildableFolders: [
                "Project/Sources",
                "Project/Resources",
            ],
            dependencies: []
        ),
        .target(
            name: "ProjectTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "\(bundleIdentifier)Tests",
            infoPlist: .default,
            buildableFolders: [
                "Project/Tests"
            ],
            dependencies: [
                .target(name: "Project")
            ]
        ),
    ],
    additionalFiles: [
        "README.md"
    ]
)
