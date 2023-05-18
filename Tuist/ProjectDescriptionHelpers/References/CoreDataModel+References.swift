import ProjectDescription

extension CoreDataModel {
    public static var gameSession = CoreDataModel(
        .relativeToRoot("GameSession/Database/GameSession.xcdatamodeld")
    )
}
