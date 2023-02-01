import ProjectDescription

extension InfoPlist {
    static let basePlist: InfoPlist = .extendingDefault(
        with: [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UIMainStoryboardFile": "",
            "UILaunchStoryboardName": "LaunchScreen",
            "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"]
        ]
    )
}
