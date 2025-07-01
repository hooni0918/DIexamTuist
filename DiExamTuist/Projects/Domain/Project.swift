import ProjectDescription

let project = Project(
    name: "Domain",
    targets: [
        .target(
            name: "Domain",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.DiExamTuist.Domain",
            sources: ["Sources/**"],
            dependencies: [
            ]
        )
    ]
)
