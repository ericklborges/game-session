import ProjectDescription

extension InfoPlist {
    public static func iOSApp(adding newValues: [String : Value] = [:]) -> InfoPlist {
        .extendingDefault(
            with: [
                "CFBundleShortVersionString": "1.0",
                "CFBundleVersion": "1",
                "UIMainStoryboardFile": "",
                "UILaunchStoryboardName": "LaunchScreen",
                "ITSAppUsesNonExemptEncryption": "NO",
            ].add(newValues)
        )
    }

}

private extension Dictionary where Key == String, Value == InfoPlist.Value {
    func add(_ values: [String : InfoPlist.Value]) -> [String : InfoPlist.Value] {
        var dictonaryCopy = self
        dictonaryCopy.merge(values) { oldValue, newValue in newValue }
        return dictonaryCopy
    }
}
