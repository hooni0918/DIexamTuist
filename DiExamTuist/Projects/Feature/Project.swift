import ProjectDescription

let project = Project(
    name: "Feature",
    packages: [
        .remote(url: "https://github.com/Swinject/Swinject.git", requirement: .upToNextMajor(from: "2.8.0"))
    ],
    targets: [
        .target(
            name: "Feature",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.DiExamTuist.Feature",
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "Core", path: "../Core"),
                            .project(target: "Domain", path: "../Domain"),
                            .project(target: "Data", path: "../Data")
            ]
        ),
        .target(
            name: "FeatureTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.DiExamTuist.FeatureTests",
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "Feature")
            ]
        )
    ]
)
