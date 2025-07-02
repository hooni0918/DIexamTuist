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
               // .project(target: "HomeData", path: "../../Data/Home"), // ✅ 제거
               .project(target: "Core", path: "../../Core")
           ]
       )
   ]
)
