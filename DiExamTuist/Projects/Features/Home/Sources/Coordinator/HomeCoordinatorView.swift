//
//  HomeCoordinatorView.swift
//  HomeFeature
//
//  Created by 이지훈 on 7/1/25.
//

import SwiftUI

public struct HomeCoordinatorView: View {
    @Environment(HomeCoordinator.self) var coordinator
    
    public init() {
        print("🏠 HomeCoordinatorView 초기화")
    }
    
    public var body: some View {
        @Bindable var bindableCoordinator = coordinator
        
        NavigationStack(path: $bindableCoordinator.path) {
            coordinator.view(.main)
                .navigationDestination(for: HomeRouter.Screen.self) { screen in
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
                }
        }
        .environment(coordinator)
    }
}
