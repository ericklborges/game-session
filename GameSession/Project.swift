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
            entitlements: .appEntitlements,
            infoPlist: .iOSApp(adding: iOSAppInfoPlistValues),
            dependencies: [.target(name: "WatchApp")],
            coreDataModels: [.gameSession]
        ),
        .watchApp(
            name: "WatchApp",
            infoPlist: .watchApp(),
            dependencies: [.target(name: "WatchAppExtension")]
        ),
        .watchExtension(
            name: "WatchAppExtension",
            infoPlist: .watchAppExtension()
        )
    ]
)

