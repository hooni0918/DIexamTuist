import ProjectDescription

let project = Project(
    name: "LoginDomain",
    targets: [
        .target(
            name: "LoginDomain",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.DiExamTuist.LoginDomain",
            sources: ["Sources/**"],
            dependencies: []
        )
    ]
)
