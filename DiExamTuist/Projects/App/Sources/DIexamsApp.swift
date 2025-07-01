//
//  DiExamTuistApp.swift
//  App
//
//  Created by 이지훈 on 7/1/25.
//

import SwiftUI
import Feature

@main
struct DiExamTuistApp: App {
    
    init() {
        print("🚀 DiExamTuist 앱 시작")
        // Feature 모듈에서 모든 DI 설정 처리
        FeatureAssembly.configureAll()
        print("✅ 앱 초기화 완료")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
