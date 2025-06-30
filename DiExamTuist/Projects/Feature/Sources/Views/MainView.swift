//
//  MainView.swift
//  Feature
//
//  Created by 이지훈 on 6/30/25.
//

import SwiftUI

public struct MainView: View {
    @StateObject private var router: RouterImpl
    private let factory: ViewModelFactory
    
    public init() {
        print("📱 MainView 생성 시작")
        
        let factory = ViewModelFactory()
        self.factory = factory
        
        let router = factory.getRouter() as! RouterImpl
        self._router = StateObject(wrappedValue: router)
        
        print("✅ MainView 생성 완료")
    }
    
    public var body: some View {
        NavigationView {
            Group {
                switch router.currentRoute {
                case .home:
                    HomeView(
                        viewModel: factory.makeHomeViewModel(),
                        router: router
                    )
                case .profile:
                    ProfileView(
                        viewModel: factory.makeProfileViewModel(),
                        router: router
                    )
                case .login:
                    LoginView(
                        viewModel: factory.makeLoginViewModel(),
                        router: router
                    )
                }
            }
        }
    }
}
