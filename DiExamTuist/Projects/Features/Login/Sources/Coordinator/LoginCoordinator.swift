//
//  LoginCoordinator.swift
//  LoginFeature
//
//  Created by 이지훈 on 7/1/25.
//

import SwiftUI
import Core

@Observable
public final class LoginCoordinator: Coordinatorable {
    public typealias Screen = LoginRouter.Screen
    public typealias SheetScreen = LoginRouter.Sheet
    public typealias FullScreen = LoginRouter.FullScreen
    
    public var path: NavigationPath = NavigationPath()
    public var sheet: SheetScreen?
    public var fullScreenCover: FullScreen?
    
    public init() {
        print("🧭 LoginCoordinator 생성")
    }
    
    @ViewBuilder
    public func view(_ screen: Screen) -> some View {
        switch screen {
        case .main:
            LoginView()
        case .signUp:
            SignUpView()
        case .forgotPassword:
            ForgotPasswordView()
        }
    }
    
    @ViewBuilder
    public func presentView(_ sheet: SheetScreen) -> some View {
        switch sheet {
        case .terms:
            TermsView()
        }
    }
    
    @ViewBuilder
    public func fullCoverView(_ cover: FullScreen) -> some View {
        EmptyView()
    }
}

public enum LoginRouter {
    public enum Screen: Hashable {
        case main
        case signUp
        case forgotPassword
    }
    
    public enum Sheet: String, Identifiable {
        case terms
        public var id: String { self.rawValue }
    }
    
    public enum FullScreen: String, Identifiable {
        case none
        public var id: String { self.rawValue }
    }
}
