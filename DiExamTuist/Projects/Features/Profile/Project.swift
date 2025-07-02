import ProjectDescription

let project = Project(
    name: "ProfileFeature",
    targets: [
        .target(
            name: "ProfileFeature",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.DiExamTuist.ProfileFeature",
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "ProfileDomain", path: "../../Domain/Profile"),
                .project(target: "Core", path: "../../Core")
                // ✅ Swinject 제거
            ]
        )
    ]
)
