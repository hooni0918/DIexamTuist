//
//  ContentView.swift
//  App
//
//  Created by 이지훈 on 7/1/25.
//

import SwiftUI
import Feature

struct ContentView: View {
    
    @State private var routeState: ContentView.RouteType = .home
    private let coordinatㅣorFactory: CoordinatorFactory = CoordinatorFactory()
    
    init() {
        print("📱 ContentView 초기화")
    }
    
    var body: some View {
        VStack {
            HStack {
                Button("홈") { routeState = .home }
                Button("프로필") { routeState = .profile }
                Button("로그인") { routeState = .login }
            }
            .padding()
            
            contentView
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch routeState {
        case .home:
            coordinatorFactory.homeCoordinatorRootView
        case .profile:
            coordinatorFactory.profileCoordinatorRootView
        case .login:
            coordinatorFactory.loginCoordinatorRootView
        }
    }
}

extension ContentView {
    enum RouteType {
        case home
        case profile
        case login
    }
}

#Preview {
    ContentView()
}
