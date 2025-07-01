import ProjectDescription

let project = Project(
    name: "Shared",
    targets: [
        .target(
            name: "Shared",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.DiExamTuist.Shared",
            sources: ["Sources/**"],
            dependencies: []
        )
    ]
)
