//
//  HomeView.swift
//  HomeFeature
//
//  Created by 이지훈 on 7/1/25.
//

import SwiftUI
import Core
import HomeDomain

public struct HomeView: View {
    @Environment(HomeCoordinator.self) var coordinator
    @StateObject private var viewModel = HomeViewModel()
    
    public init() {
        print("🏠 HomeView 초기화")
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "house.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            if viewModel.isLoading {
                ProgressView()
            } else {
                Text("안녕하세요, \(viewModel.userName)님!")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            Text("HGDGDS: App에서 Assembly 등록")
                .font(.body)
                .foregroundColor(.secondary)
            
            VStack(spacing: 15) {
                Button("설정") {
                    coordinator.push(.settings)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("사용자 정보") {
                    coordinator.sheet(.userInfo)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("튜토리얼") {
                    coordinator.fullCover(.tutorial)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("홈")
    }
}

public final class HomeViewModel: ObservableObject {
    @Published public var userName: String = ""
    @Published public var isLoading: Bool = false
    
    @Dependency private var getCurrentUserUseCase: GetCurrentUserUseCaseProtocol
    
    public init() {
        print("🏠 HomeViewModel 생성")
        loadUserData()
    }
    
    private func loadUserData() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            if let user = self.getCurrentUserUseCase.execute() {
                self.userName = user.name
                print("👤 사용자 데이터 로드: \(user.name)")
            } else {
                self.userName = "사용자 없음"
            }
            self.isLoading = false
        }
    }
}

struct SettingsView: View {
    @Environment(HomeCoordinator.self) var coordinator
    
    var body: some View {
        VStack {
            Text("설정 화면")
                .font(.title)
            
            Button("뒤로가기") {
                coordinator.pop()
            }
            .padding()
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .navigationTitle("설정")
    }
}

struct UserInfoView: View {
    @Environment(HomeCoordinator.self) var coordinator
    
    var body: some View {
        VStack {
            Text("사용자 정보")
                .font(.title)
            
            Button("닫기") {
                coordinator.dismissSheet()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

struct TutorialView: View {
    @Environment(HomeCoordinator.self) var coordinator
    
    var body: some View {
        VStack {
            Text("튜토리얼")
                .font(.title)
            
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
