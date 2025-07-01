//
//  HomeCoordinator.swift
//  Feature
//
//  Created by 이지훈 on 7/1/25.
//


//
//  HomeCoordinator.swift
//  Feature
//
//  Created by 이지훈 on 7/1/25.
//

import SwiftUI
import Core

@Observable
@MainActor
public final class HomeCoordinator: Coordinatorable {
    public typealias Screen = HomeRouter.Screen
    public typealias SheetScreen = HomeRouter.Sheet
    public typealias FullScreen = HomeRouter.FullScreen
    
    public var path: NavigationPath = NavigationPath()
    public var sheet: SheetScreen?
    public var fullScreenCover: FullScreen?
    
    public init() {
        print("🧭 HomeCoordinator 생성")
    }
    
    @ViewBuilder
    public func view(_ screen: Screen) -> some View {
        switch screen {
        case .main:
            HomeView()
        case .settings:
            SettingsView()
        }
    }
    
    @ViewBuilder
    public func presentView(_ sheet: SheetScreen) -> some View {
        switch sheet {
        case .userInfo:
            ProfileView()
        }
    }
    
    @ViewBuilder
    public func fullCoverView(_ cover: FullScreen) -> some View {
        switch cover {
        case .tutorial:
            TutorialView()
        }
    }
}

// MARK: - Home Router
public enum HomeRouter {
    public enum Screen: Hashable {
        case main
        case settings
    }
    
    public enum Sheet: String, Identifiable {
        case userInfo
        
        public var id: String { self.rawValue }
    }
    
    public enum FullScreen: String, Identifiable {
        case tutorial
        
        public var id: String { self.rawValue }
    }
}
