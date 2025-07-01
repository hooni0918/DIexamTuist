//
//  HomeView.swift
//  Feature
//
//  Created by 이지훈 on 7/1/25.
//

import SwiftUI

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
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                Text("안녕하세요, \(viewModel.userName)님!")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            Text("Feature별 독립 Coordinator")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            VStack(spacing: 15) {
                NavigationButton(
                    title: "설정",
                    icon: "gearshape",
                    color: .blue
                ) {
                    coordinator.push(.settings)
                }
                
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
