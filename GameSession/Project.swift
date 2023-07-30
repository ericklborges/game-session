import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Properties

private let iOSAppInfoPlistValues: [String: InfoPlist.Value] = [
    "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
    "UIBackgroundModes": ["remote-notification"],
    "UIApplicationSceneManifest": [
        "UIApplicationSupportsMultipleScenes": "NO",
        "UISceneConfigurations": [:]
    ]
]

private let watchAppInfoPlistValues: [String: InfoPlist.Value] = [
    "CFBundleDisplayName": "GameSession"
]


private let watchAppExtensionInfoPlistValues: [String: InfoPlist.Value] = [
    "UIBackgroundModes": ["remote-notification"]
]

// MARK: - Project

let project = Project.main(
    name: projectName,
    organization: projectOrganization,
    targets: [
        .app(
            name: projectName,
            platform: .iOS,
            infoPlist: .iOSApp(adding: iOSAppInfoPlistValues),
            entitlements: .app,
            dependencies: [
                .target(name: "Database-iOS"),
                .target(name: "WatchApp")
            ]
        ),
        .iOSFramework(
            name: "Core-iOS",
            infoPlist: .default,
            sources: ["Core/**"]
        ),
        .watchOSFramework(
            name: "Core-watchOS",
            infoPlist: .default,
            sources: ["Core/**"]
        ),
        .iOSFramework(
            name: "Database-iOS",
            infoPlist: .default,
            sources: ["Database/Sources/**"],
            dependencies: [.target(name: "Core-iOS")],
            coreDataModels: [.gameSession]
        ),
        .watchOSFramework(
            name: "Database-watchOS",
            infoPlist: .default,
            sources: ["Database/Sources/**"],
            dependencies: [.target(name: "Core-watchOS")],
            coreDataModels: [.gameSession]
        ),
        .watchApp(
            name: "WatchApp",
            infoPlist: .watchApp(adding: watchAppInfoPlistValues),
            dependencies: [.target(name: "WatchAppExtension")]
        ),
        .watchExtension(
            name: "WatchAppExtension",
            infoPlist: .watchAppExtension(adding: watchAppExtensionInfoPlistValues),
            entitlements: .watchApp,
            dependencies: [.target(name: "Database-watchOS")]
        )
    ]
)

