//
//  App Module Main Files
//  App
//
//  Tuist 모듈화 환경 - App 모듈
//

import SwiftUI
import Core
import Feature

// MARK: - Main App
@main
struct DiExamTuistApp: App {
    
    init() {
        print("🚀 DiExamTuist 앱 시작")
        // Feature 모듈에서 모든 의존성 설정
        FeatureAssembly.configureAll()
        print("✅ 앱 초기화 완료")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
