import ProjectDescription

let project = Project(
    name: "ProfileData",
    packages: [
        .remote(url: "https://github.com/Swinject/Swinject.git", requirement: .upToNextMajor(from: "2.9.1"))
    ],
    targets: [
        .target(
            name: "ProfileData",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.DiExamTuist.ProfileData",
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "ProfileDomain", path: "../../Domain/Profile"),
                .project(target: "Core", path: "../../Core"),
                .external(name: "Swinject")
            ]
        )
    ]
)
