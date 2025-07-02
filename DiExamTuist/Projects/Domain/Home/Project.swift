import ProjectDescription

let project = Project(
    name: "HomeDomain",
    targets: [
        .target(
            name: "HomeDomain",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.DiExamTuist.HomeDomain",
            sources: ["Sources/**"],
            dependencies: []
        )
    ]
)
