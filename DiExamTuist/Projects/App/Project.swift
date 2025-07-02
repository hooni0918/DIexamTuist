import ProjectDescription

let project = Project(
    name: "App",
    // ❌ Swinject 패키지 완전 제거!
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
                // ✅ Feature 모듈들만 (레퍼런스 방식)
                .project(target: "HomeFeature", path: "../Features/Home"),
                .project(target: "LoginFeature", path: "../Features/Login"),
                .project(target: "ProfileFeature", path: "../Features/Profile"),
                
                // ✅ Domain 모듈들 (Entity 타입 사용)
                .project(target: "HomeDomain", path: "../Domain/Home"),
                .project(target: "LoginDomain", path: "../Domain/Login"),
                .project(target: "ProfileDomain", path: "../Domain/Profile"),
                
                // ✅ Core & Shared (DI Container는 Core에서 관리)
                .project(target: "Core", path: "../Core"),
                .project(target: "Shared", path: "../Shared")
                
                // ❌ Swinject 완전 제거!
                // ❌ Data 모듈들도 제거!
            ]
        )
    ]
)
