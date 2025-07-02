import ProjectDescription

let project = Project(
    name: "HomeData",
    packages: [
        .remote(url: "https://github.com/Swinject/Swinject.git", requirement: .upToNextMajor(from: "2.9.1"))
    ],
    targets: [
        .target(
            name: "HomeData",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.DiExamTuist.HomeData",
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "HomeDomain", path: "../../Domain/Home"),
                .project(target: "Core", path: "../../Core"),
                .external(name: "Swinject")
            ]
        )
    ]
)
