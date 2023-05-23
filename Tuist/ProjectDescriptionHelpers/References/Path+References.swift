import ProjectDescription

extension Path {
    public static var app: Path = .relativeToRoot(
        "GameSession/App/Sources/Application/GameSession.entitlements"
    )

    public static var watchApp: Path = .relativeToRoot(
        "GameSession/WatchAppExtension/Sources/Application/WatchAppExtension.entitlements"
    )
}
