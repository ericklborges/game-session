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
            coreDataModels: [.gameSession]
        )
    ]
)
