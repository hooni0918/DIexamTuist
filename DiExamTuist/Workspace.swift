import ProjectDescription

let workspace = Workspace(
   name: "DiExamTuist",
   projects: [
       // ✅ App (메인)
       "Projects/App",
       
       // ✅ Feature 모듈들 (UI Layer)
       "Projects/Features/Home",
       "Projects/Features/Login",
       "Projects/Features/Profile",
       
       // ✅ Domain 모듈들 (Business Logic)
       "Projects/Domain/Home",
       "Projects/Domain/Login",
       "Projects/Domain/Profile",
       
       // ✅ Data 모듈들 (Implementation)
       "Projects/Data/Home",
       "Projects/Data/Login",
       "Projects/Data/Profile",
       
       // ✅ Core & Shared
       "Projects/Core",
       "Projects/Shared"
   ]
)
