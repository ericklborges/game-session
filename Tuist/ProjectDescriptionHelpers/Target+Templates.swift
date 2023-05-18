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
        dependencies: [TargetDependency] = []
    ) -> Target {
        .init(
            name: name,
            platform: .watchOS,
            product: .watch2Extension,
            bundleId: "\(baseBundleId).WatchApp.watchkitextension",
            deploymentTarget: .watchOSGlobal,
            infoPlist: infoPlist,
            sources: "\(name)/Sources/**",
            dependencies: dependencies
        )
    }

    public static func iOSFramework(
        name: String,
        infoPlist: InfoPlist,
        sources: SourceFilesList? = nil,
        resources: ResourceFileElements? = nil,
        entitlements: Path? = nil,
        dependencies: [TargetDependency] = [],
        coreDataModels: [CoreDataModel] = []
    ) -> Target {
        framework(
            name: name,
            platform: .iOS,
            deploymentTarget: .iOSGlobal,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            entitlements: entitlements,
            dependencies: dependencies,
            coreDataModels: coreDataModels
        )
    }

    public static func watchOSFramework(
        name: String,
        infoPlist: InfoPlist,
        sources: SourceFilesList? = nil,
        resources: ResourceFileElements? = nil,
        entitlements: Path? = nil,
        dependencies: [TargetDependency] = [],
        coreDataModels: [CoreDataModel] = []
    ) -> Target {
        framework(
            name: name,
            platform: .watchOS,
            deploymentTarget: .watchOSGlobal,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            entitlements: entitlements,
            dependencies: dependencies,
            coreDataModels: coreDataModels
        )
    }

    private static func framework(
        name: String,
        platform: Platform,
        deploymentTarget: DeploymentTarget,
        infoPlist: InfoPlist,
        sources: SourceFilesList? = nil,
        resources: ResourceFileElements? = nil,
        entitlements: Path? = nil,
        dependencies: [TargetDependency] = [],
        coreDataModels: [CoreDataModel] = []
    ) -> Target {
        return .init(
            name: name,
            platform: platform,
            product: .framework,
            bundleId: "\(baseBundleId).\(name).\(platform.rawValue)",
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            entitlements: entitlements,
            dependencies: dependencies,
            coreDataModels: coreDataModels
        )
    }
}
