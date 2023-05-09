import ProjectDescription

extension Target {
    public static func app(
        name: String,
        organization: String,
        platform: Platform,
        coreDataModels: [CoreDataModel] = []
    ) -> Target {
        .init(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "com.\(organization).\(name)",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
            infoPlist: .basePlist,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            coreDataModels: coreDataModels
        )
    }
}
