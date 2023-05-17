import ProjectDescription

extension DeploymentTarget {
    public static let iOSGlobal: Self = .iOS(targetVersion: "16.0", devices: .iphone)
    public static let watchOSGlobal: Self = .watchOS(targetVersion: "9.0")
}
