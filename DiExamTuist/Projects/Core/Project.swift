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
                .project(target: "Shared", path: "../Shared")
            ]
        ),
        .target(
            name: "CoreTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.DiExamTuist.CoreTests",
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "Core")
            ]
        )
    ]
)
