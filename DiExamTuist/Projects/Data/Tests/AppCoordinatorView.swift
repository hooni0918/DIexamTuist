//
//  AppCoordinatorView.swift
//  Feature
//
//  Created by 이지훈 on 7/1/25.
//


//
//  AppCoordinatorView.swift
//  App
//
//  Created by 이지훈 on 7/1/25.
//

//
//  Projects/App/Sources/AppCoordinatorView.swift
//  수정된 버전
//

import SwiftUI
import Feature  // ✅ Feature import 추가

// MARK: - App Coordinator View
public struct AppCoordinatorView: View {
    @Environment(AppCoordinator.self) var coordinator
    
    public init() {
        print("🧭 AppCoordinatorView 초기화")
    }
    
    public var body: some View {
        @Bindable var bindableCoordinator = coordinator
        
        NavigationStack(path: $bindableCoordinator.path) {
            coordinator.view(.home) // 기본 화면은 홈
                .navigationDestination(for: AppRouter.Screen.self) { screen in
                    coordinator.view(screen)
                }
                .sheet(item: $bindableCoordinator.sheet) { sheet in
                    NavigationView {
                        coordinator.presentView(sheet)
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarLeading) {
                                    Button("닫기") {
                                        coordinator.dismissSheet()
                                    }
                                }
                            }
                    }
                }
                .fullScreenCover(item: $bindableCoordinator.fullScreenCover) { cover in
                    coordinator.fullCoverView(cover)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("닫기") {
                                    coordinator.dismissCover()
                                }
                            }
                        }
                }
        }
        .environment(coordinator)
    }
}
