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
            coreDataModels: [.gameSession]
        )
    ]
)

