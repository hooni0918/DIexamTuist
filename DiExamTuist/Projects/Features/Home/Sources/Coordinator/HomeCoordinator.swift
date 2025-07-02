//
//  HomeCoordinator.swift
//  HomeFeature
//
//  Created by 이지훈 on 7/1/25.
//

import SwiftUI
import Core

@Observable
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
            UserInfoView()
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


struct SettingsView: View {
    var body: some View {
        VStack {
            Text("⚙️ Settings")
                .font(.largeTitle)
                .bold()
                .padding()
            
            Text("여기에 설정 관련 내용이 들어갑니다.")
                .foregroundColor(.secondary)
        }
    }
}

struct UserInfoView: View {
    var body: some View {
        VStack {
            Text("👤 사용자 정보")
                .font(.largeTitle)
                .bold()
                .padding()
            
            Text("사용자 이름, 이메일 등 정보 표시 예정")
                .foregroundColor(.secondary)
        }
    }
}

struct TutorialView: View {
    var body: some View {
        VStack {
            Text("📘 튜토리얼")
                .font(.largeTitle)
                .bold()
                .padding()
            
            Text("앱의 사용법을 소개하는 화면입니다.")
                .foregroundColor(.secondary)
        }
    }
}
