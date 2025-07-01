//
//  LoginCoordinatorView.swift
//  Feature
//
//  Created by 이지훈 on 7/1/25.
//


//
//  LoginCoordinatorView.swift
//  Feature
//
//  Created by 이지훈 on 7/1/25.
//

import SwiftUI

public struct LoginCoordinatorView: View {
    @Environment(LoginCoordinator.self) var coordinator
    
    public init() {
        print("🔐 LoginCoordinatorView 초기화")
    }
    
    public var body: some View {
        @Bindable var bindableCoordinator = coordinator
        
        NavigationStack(path: $bindableCoordinator.path) {
            coordinator.view(.main)
                .navigationDestination(for: LoginRouter.Screen.self) { screen in
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