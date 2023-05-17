import ProjectDescription

extension CoreDataModel {
    public static var gameSession = CoreDataModel(
        .relativeToRoot("GameSession/App/Sources/Data/LocalDatabase/GameSession.xcdatamodeld")
    )
}
