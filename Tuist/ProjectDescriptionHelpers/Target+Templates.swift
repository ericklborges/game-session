import ProjectDescription

extension Target {
    public static func app(
        name: String,
        platform: Platform,
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
            deploymentTarget: .iOSGlobal,
            infoPlist: infoPlist,
            sources: ["App/Sources/**"],
            resources: ["App/Resources/**"],
            entitlements: entitlements,
            dependencies: dependencies,
            coreDataModels: coreDataModels
        )
    }

    public static func watchApp(
        name: String,
        infoPlist: InfoPlist,
        entitlements: Path? = nil,
        dependencies: [TargetDependency] = [],
        coreDataModels: [CoreDataModel] = []
    ) -> Target {
        .init(
            name: name,
            platform: .watchOS,
            product: .watch2App,
            bundleId: "\(baseBundleId).WatchApp",
            deploymentTarget: .watchOSGlobal,
            infoPlist: infoPlist,
            resources: "\(name)/**",
            entitlements: entitlements,
            dependencies: dependencies,
            coreDataModels: coreDataModels
        )
    }

    public static func watchExtension(
        name: String,
        infoPlist: InfoPlist,
        entitlements: Path? = nil,
        coreDataModels: [CoreDataModel] = []
    ) -> Target {
        .init(
            name: name,
            platform: .watchOS,
            product: .watch2Extension,
            bundleId: "\(baseBundleId).WatchApp.watchkitextension",
            deploymentTarget: .watchOSGlobal,
            infoPlist: infoPlist,
            sources: "\(name)/Sources/**",
            entitlements: entitlements,
            coreDataModels: coreDataModels
        )
    }
}
