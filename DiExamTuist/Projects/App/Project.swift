import ProjectDescription

let project = Project(
    name: "App",
    packages: [],
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
            dependencies: [
                .project(target: "HomeFeature", path: "../Features/Home"),
                .project(target: "LoginFeature", path: "../Features/Login"),
                .project(target: "ProfileFeature", path: "../Features/Profile"),
                
                .project(target: "Core", path: "../Core"),
                .project(target: "Shared", path: "../Shared")
                
                // ✅ Data 모듈들 완전 제거
            ]
        )
    ]
)
