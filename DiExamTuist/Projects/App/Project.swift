import ProjectDescription

let project = Project(
    name: "App",
    packages: [
        .remote(url: "https://github.com/Swinject/Swinject.git", requirement: .upToNextMajor(from: "2.9.1"))
    ],
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
                // ✅ Feature 모듈들 (Assembly 제공)
                .project(target: "HomeFeature", path: "../Features/Home"),
                .project(target: "LoginFeature", path: "../Features/Login"),
                .project(target: "ProfileFeature", path: "../Features/Profile"),
                
                // ✅ Domain 모듈들 (Protocol + Entity)
                .project(target: "HomeDomain", path: "../Domain/Home"),
                .project(target: "LoginDomain", path: "../Domain/Login"),
                .project(target: "ProfileDomain", path: "../Domain/Profile"),
                
                // ✅ Core & Shared
                .project(target: "Core", path: "../Core"),
                .project(target: "Shared", path: "../Shared"),
                .external(name: "Swinject")
                
                // ❌ Data 모듈들 완전 제거!
            ]
        )
    ]
)
