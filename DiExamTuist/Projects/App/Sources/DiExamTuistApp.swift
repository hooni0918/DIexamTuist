//
//  DiExamTuistApp.swift
//  DiExamTuist
//
//  Created by 이지훈 on 7/2/25.
//

import SwiftUI

@main
struct DiExamTuistApp: App {
    
    init() {
        print("🚀 DiExamTuist 앱 시작 (레퍼런스 방식)")
        
        AppDependencyConfiguration.configure()
        
        print("✅ 앱 초기화 완료 - Feature들이 스스로 관리")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
