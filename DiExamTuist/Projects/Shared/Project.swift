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
        ),
        .target(
            name: "SharedTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.DiExamTuist.SharedTests",
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "Shared")
            ]
        )
    ]
)
