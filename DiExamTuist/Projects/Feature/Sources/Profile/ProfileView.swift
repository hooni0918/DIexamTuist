//
//  ProfileView.swift
//  Feature
//
//  Created by 이지훈 on 7/1/25.
//

import SwiftUI

public struct ProfileView: View {
    @Environment(ProfileCoordinator.self) var coordinator
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
                    coordinator.push(.editProfile)
                }) {
                    HStack {
                        Image(systemName: "person.crop.circle.badge.plus")
                        Text("프로필 편집")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                Button(action: {
                    coordinator.sheet(.logout)
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
            }
            .padding(.top, 30)
        }
        .padding()
        .navigationTitle("프로필")
    }
}
