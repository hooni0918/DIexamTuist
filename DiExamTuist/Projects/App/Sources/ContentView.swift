//
//  ContentView.swift
//  DiExamTuist
//
//  Created by 이지훈 on 6/30/25.
//

import SwiftUI
import Core
import Feature

// MARK: - Content View
struct ContentView: View {
    @State private var coordinator: AppCoordinator
    
    init() {
        print("📱 ContentView 초기화")
        // DI Container에서 Coordinator 가져오기
        let coordinator = DIContainer.shared.resolve(AppCoordinator.self)
        self._coordinator = State(initialValue: coordinator)
        print("🧭 AppCoordinator 주입 완료")
    }
    
    var body: some View {
        AppCoordinatorView()
            .environment(coordinator)
            .onAppear {
                print("✅ 앱 화면 표시 완료")
            }
    }
}
