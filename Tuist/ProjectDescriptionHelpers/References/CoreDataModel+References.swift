import ProjectDescription

extension CoreDataModel {
    public static var gameSession = CoreDataModel(
        .relativeToRoot("GameSession/Sources/Data/LocalDatabase/GameSession.xcdatamodeld")
    )
}
