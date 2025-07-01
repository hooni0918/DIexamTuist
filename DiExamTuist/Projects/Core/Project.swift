import ProjectDescription

let project = Project(
    name: "Core",
    packages: [
        .remote(url: "https://github.com/Swinject/Swinject.git", requirement: .upToNextMajor(from: "2.9.1"))
    ],
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
