//
//  AppCoordinator.swift
//  Feature
//
//  Created by 이지훈 on 7/1/25.
//


//
//  Projects/Feature/Sources/AppCoordinator.swift
//  Feature 레이어에 위치
//

import SwiftUI
import Core

// MARK: - App Coordinator
@Observable
@MainActor
public final class AppCoordinator: Coordinatorable {
    public typealias Screen = AppRouter.Screen
    public typealias SheetScreen = AppRouter.Sheet
    public typealias FullScreen = AppRouter.FullScreen
    
    public var path: NavigationPath = NavigationPath()
    public var sheet: SheetScreen?
    public var fullScreenCover: FullScreen?
    
    public init() {
        print("🧭 AppCoordinator 생성 (Feature 레이어)")
    }
    
    @ViewBuilder
    public func view(_ screen: Screen) -> some View {
        switch screen {
        case .home:
            HomeView()
        case .profile:
            ProfileView()
        case .login:
            LoginView()
        case .calendar:
            Text("Calendar View - 추후 구현")
                .font(.title)
                .foregroundColor(.purple)
        case .onboarding:
            Text("Onboarding View - 추후 구현")
                .font(.title)
                .foregroundColor(.green)
        }
    }
    
    @ViewBuilder
    public func presentView(_ sheet: SheetScreen) -> some View {
        switch sheet {
        case .settings:
            SettingsView()
        case .help:
            HelpView()
        }
    }
    
    @ViewBuilder
    public func fullCoverView(_ cover: FullScreen) -> some View {
        switch cover {
        case .onboarding:
            OnboardingFullView()
        case .tutorial:
            TutorialView()
        }
    }
}

// MARK: - Sheet Views
struct SettingsView: View {
    @Environment(AppCoordinator.self) var coordinator
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "gearshape.fill")
                .font(.system(size: 50))
                .foregroundColor(.blue)
            
            Text("설정")
                .font(.title)
                .fontWeight(.bold)
            
            Text("앱 설정을 관리하세요")
                .font(.body)
                .foregroundColor(.secondary)
            
            Button("닫기") {
                coordinator.dismissSheet()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

struct HelpView: View {
    @Environment(AppCoordinator.self) var coordinator
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "questionmark.circle.fill")
                .font(.system(size: 50))
                .foregroundColor(.green)
            
            Text("도움말")
                .font(.title)
                .fontWeight(.bold)
            
            Text("앱 사용법을 확인하세요")
                .font(.body)
                .foregroundColor(.secondary)
            
            Button("닫기") {
                coordinator.dismissSheet()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

// MARK: - Full Screen Views
struct OnboardingFullView: View {
    @Environment(AppCoordinator.self) var coordinator
    
    var body: some View {
        VStack(spacing: 30) {
            Text("환영합니다!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("앱을 시작해보세요")
                .font(.title2)
                .foregroundColor(.secondary)
            
            Button("시작하기") {
                coordinator.dismissCover()
            }
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.orange.opacity(0.1))
    }
}

struct TutorialView: View {
    @Environment(AppCoordinator.self) var coordinator
    
    var body: some View {
        VStack(spacing: 30) {
            Text("튜토리얼")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("앱 사용법을 배워보세요")
                .font(.title2)
                .foregroundColor(.secondary)
            
            Button("완료") {
                coordinator.dismissCover()
            }
            .padding()
            .background(Color.purple)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.purple.opacity(0.1))
    }
}