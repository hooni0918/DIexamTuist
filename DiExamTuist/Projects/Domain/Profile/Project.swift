import ProjectDescription

let project = Project(
    name: "ProfileDomain",
    targets: [
        .target(
            name: "ProfileDomain",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.DiExamTuist.ProfileDomain",
            sources: ["Sources/**"],
            dependencies: []
        )
    ]
)
