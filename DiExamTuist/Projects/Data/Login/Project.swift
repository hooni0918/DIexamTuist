import ProjectDescription

let project = Project(
    name: "LoginData",
    packages: [
        .remote(url: "https://github.com/Swinject/Swinject.git", requirement: .upToNextMajor(from: "2.9.1"))
    ],
    targets: [
        .target(
            name: "LoginData",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.DiExamTuist.LoginData",
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "LoginDomain", path: "../../Domain/Login"),
                .project(target: "Core", path: "../../Core"),
                .external(name: "Swinject")
            ]
        )
    ]
)
