import ProjectDescription

let project = Project(
    name: "HomeFeature",
    targets: [
        .target(
            name: "HomeFeature",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.DiExamTuist.HomeFeature",
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "HomeDomain", path: "../../Domain/Home"),
                .project(target: "Core", path: "../../Core")
                // ✅ Swinject 제거 (Assembly 안함)
            ]
        )
    ]
)
