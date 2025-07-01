//
//  ProfileView.swift
//  Feature
//
//  Created by 이지훈 on 6/30/25.
//

import SwiftUI

public struct ProfileView: View {
    @Environment(AppCoordinator.self) var coordinator
    @StateObject private var viewModel = ProfileViewModel()
    
    public init() {
        print("👤 ProfileView 초기화")
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else if let user = viewModel.user {
                VStack(spacing: 10) {
                    Text(user.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(user.email)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            
            VStack(spacing: 15) {
                Button(action: {
                    viewModel.requestLogout()
                }) {
                    HStack {
                        Image(systemName: "arrow.right.square")
                        Text("로그아웃")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                Button(action: {
                    coordinator.pop()
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                        Text("뒤로가기")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding(.top, 30)
        }
        .padding()
        .navigationTitle("프로필")
        .alert("로그아웃", isPresented: $viewModel.showLogoutAlert) {
            Button("취소", role: .cancel) {
                viewModel.cancelLogout()
            }
            Button("로그아웃", role: .destructive) {
                viewModel.confirmLogout()
                coordinator.push(.login)
            }
        } message: {
            Text("정말로 로그아웃 하시겠습니까?")
        }
    }
}
