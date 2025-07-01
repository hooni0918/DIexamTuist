//
//  HomeView.swift
//  Feature
//
//  Created by 이지훈 on 6/30/25.
//

import SwiftUI

public struct HomeView: View {
    @Environment(AppCoordinator.self) var coordinator
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
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                Text("안녕하세요, \(viewModel.userName)님!")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            Text("Tuist 모듈화 + Assembly Pattern")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            VStack(spacing: 15) {
                NavigationButton(
                    title: "프로필 보기",
                    icon: "person.circle",
                    color: .green
                ) {
                    coordinator.push(.profile)
                }
                
                NavigationButton(
                    title: "로그인",
                    icon: "person.badge.key",
                    color: .orange
                ) {
                    coordinator.push(.login)
                }
                
                Button("설정") {
                    coordinator.sheet(.settings)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding(.top, 20)
        }
        .padding()
        .navigationTitle("홈")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("새로고침") {
                    viewModel.refreshUserData()
                }
            }
        }
    }
}


// MARK: - Reusable Navigation Button
struct NavigationButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                Text(title)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding()
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}
