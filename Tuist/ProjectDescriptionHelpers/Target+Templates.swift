import ProjectDescription

extension Target {
    public static func app(
        name: String,
        platform: Platform,
        deploymentTarget: DeploymentTarget,
        infoPlist: InfoPlist,
        entitlements: Path? = nil,
        dependencies: [TargetDependency] = [],
        coreDataModels: [CoreDataModel] = []
    ) -> Target {
        .init(
            name: name,
            platform: platform,
            product: .app,
            bundleId: baseBundleId,
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            sources: ["App/Sources/**"],
            resources: ["App/Resources/**"],
            entitlements: entitlements,
            dependencies: dependencies,
            coreDataModels: coreDataModels
        )
    }
}
