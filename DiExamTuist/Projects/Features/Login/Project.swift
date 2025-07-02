import ProjectDescription

let project = Project(
    name: "LoginFeature",
    targets: [
        .target(
            name: "LoginFeature",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.DiExamTuist.LoginFeature",
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "LoginDomain", path: "../../Domain/Login"),
                .project(target: "Core", path: "../../Core")
                // ✅ Swinject 제거
            ]
        )
    ]
)
