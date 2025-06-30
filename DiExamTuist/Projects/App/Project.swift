import ProjectDescription

let project = Project(
    name: "App",
    targets: [
        .target(
            name: "DiExamTuist",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.DiExamTuist",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "Feature", path: "../Feature"),
                .project(target: "Shared", path: "../Shared")
            ]
        ),
        .target(
            name: "AppTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.DiExamTuist.AppTests",
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "DiExamTuist")
            ]
        )
    ]
)
