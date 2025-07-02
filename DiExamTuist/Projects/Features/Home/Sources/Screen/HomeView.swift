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
    @State private var viewModel = HomeViewModel()
    
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
                
                if let user = viewModel.currentUser {
                    Text(user.email)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Text("실제 Data 모듈 연동 완료!")
                .font(.body)
                .foregroundColor(.green)
                .fontWeight(.semibold)
            
            VStack(spacing: 15) {
                Button("새로고침") {
                    Task {
                        await viewModel.refreshUser()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                // ✅ 사용자 전환 버튼들
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.allUsers, id: \.id) { user in
                            Button(user.name) {
                                Task {
                                    await viewModel.switchUser(to: user)
                                }
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                viewModel.currentUser?.id == user.id ?
                                Color.blue : Color.gray.opacity(0.3)
                            )
                            .foregroundColor(
                                viewModel.currentUser?.id == user.id ?
                                .white : .primary
                            )
                            .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                }
                
                Button("설정") {
                    coordinator.push(.settings)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("홈")
    }
}
