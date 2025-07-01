import ProjectDescription

let project = Project(
    name: "Core",
    targets: [
        .target(
            name: "Core",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.DiExamTuist.Core",
            sources: ["Sources/**"],
            dependencies: [
                .external(name: "Swinject")
            ]
        )
    ]
)
