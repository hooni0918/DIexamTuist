//
//  DiExamTuistApp.swift
//  App
//
//  Created by 이지훈 on 7/1/25.
//

import SwiftUI

@main
struct DiExamTuistApp: App {
    
    init() {
        print("🚀 DiExamTuist 앱 시작 (HGDGDS 방식)")
        AppDependencyConfiguration.configure()
        print("✅ 앱 초기화 완료")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
