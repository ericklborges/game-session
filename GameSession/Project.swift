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

// MARK: - Project

let project = Project.main(
    name: projectName,
    organization: projectOrganization,
    targets: [
        .app(
            name: projectName,
            platform: .iOS,
            infoPlist: .iOSApp(adding: iOSAppInfoPlistValues),
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
            entitlements: .Database,
            dependencies: [.target(name: "Core-iOS")],
            coreDataModels: [.gameSession]
        ),
        .watchOSFramework(
            name: "Database-watchOS",
            infoPlist: .default,
            sources: ["Database/Sources/**"],
            entitlements: .Database,
            dependencies: [.target(name: "Core-watchOS")],
            coreDataModels: [.gameSession]
        ),
        .watchApp(
            name: "WatchApp",
            infoPlist: .watchApp(),
            dependencies: [.target(name: "WatchAppExtension")]
        ),
        .watchExtension(
            name: "WatchAppExtension",
            infoPlist: .watchAppExtension(),
            dependencies: [.target(name: "Database-watchOS")]
        )
    ]
)

