import ProjectDescription

extension Project {
    public static func main(
        name: String,
        organization: String,
        targets: [Target]
    ) -> Project {
        .init(
            name: name,
            organizationName: organization,
            settings: .settings(base: ["DEVELOPMENT_TEAM" :"HJ3JBWEJT5"]),
            targets: targets,
            resourceSynthesizers: [.assets(), .fonts()]
        )
    }
}
