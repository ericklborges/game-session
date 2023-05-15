import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.main(
    name: "GameSession",
    organization: "bcl",
    targets: [
        .app(
            name: "GameSession",
            organization: "bcl",
            platform: .iOS,
            entitlements: .relativeToRoot("GameSession/Sources/Application/GameSession.entitlements"),
            coreDataModels: [.gameSession]
        )
    ]
)
